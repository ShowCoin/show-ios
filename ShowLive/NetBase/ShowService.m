
//
//  ShowService.m
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowService.h"
#import "ShowRequest.h"
#import "ShowHelper.h"
#import "ShowHTTPRequestSerializer.h"
#import "ShowHTTPResponseSerializer.h"
#import "NSString+MD5.h"
#import "ShowError.h"
#define QC_MAX_SERVICE_CONCURRENT_COUNT (10)

@interface ShowService ()
@property (nonatomic, strong) NSMutableArray* todoQueue;
@property (nonatomic, strong) NSMutableDictionary *requestQueue;
@property (nonatomic, strong) dispatch_queue_t dispatchQueue;

@property (nonatomic, strong) NSArray *noNeedErrorAlertActionArray;
@end

@implementation ShowService
+ (ShowService *)sharedInstance {
    static id __obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __obj = [[self alloc] init];
    });
    return __obj;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dispatchQueue = dispatch_queue_create("com.qinqin.request_queue", DISPATCH_QUEUE_CONCURRENT);
        _requestQueue = [NSMutableDictionary dictionary];
        _todoQueue = [NSMutableArray array];
    }
    return self;
}

+(void)startRequest:(ShowRequest *)request{
    [[self sharedInstance] startRequest:request];
}

+(void)cancelRequest:(ShowRequest *)request{
    [[self sharedInstance] cancelRequestWithID:request.requestID];
}

+(void)cancelRequestWithId:(NSString *)requestID{
    [[self sharedInstance] cancelRequestWithID:requestID];
}

-(void)startRequest:(ShowRequest *)request{
    dispatch_async(_dispatchQueue, ^{
        @synchronized(self){
            if (self.requestQueue[request.requestID]) {
                return ;
            }
            
            if (self.requestQueue.count >= QC_MAX_SERVICE_CONCURRENT_COUNT) {
                [self.todoQueue addObject:request];
                return;
            }
            
            request.startTimestamp = [[NSDate date] timeIntervalSince1970];
            self.requestQueue[request.requestID] = request;
            
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            config.timeoutIntervalForRequest = 30.0;
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
            ShowHTTPRequestSerializer *requestSerializer = [ShowHTTPRequestSerializer serializer];
            NSString *sign = [self cryptData:requestSerializer.HTTPRequestHeaders parameters:request.requestData.parameters];
            [requestSerializer setValue:sign forHTTPHeaderField:@"Sign"];
            manager.requestSerializer = requestSerializer;
            
            ShowHTTPResponseSerializer *responseSerializer = [ShowHTTPResponseSerializer serializer];
            manager.responseSerializer = responseSerializer;
            
            [manager setSecurityPolicy:[self customSecurityPolicy]];
            
            __weak typeof(self) weaks = self;
            NSString *url = @"";
            if ([request.serverURL hasSuffix:@"/"]) {
                url = [NSString stringWithFormat:@"%@%@", request.serverURL, request.requestData.interface];
            }else{
                url = [NSString stringWithFormat:@"%@/%@", request.serverURL, request.requestData.interface];
            }
            
            [manager POST:url parameters:request.requestData.parameters constructingBodyWithBlock:nil  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (weaks.requestQueue[request.requestID] == nil) {
                    return ;
                }
                NSDictionary *jsonDict = [KMHelper dictionaryWithJSON:responseObject];
                if(jsonDict && [jsonDict[@"state"] integerValue]==1){
                    id response = jsonDict[@"data"];
                    [weaks request:request postData:response];
                }else{
                    NSError *error = [ShowError errorWithDomain:[NSString stringWithFormat:@"%@",task.originalRequest.URL] message:jsonDict[@"msg"] code:[jsonDict[@"state"] integerValue]];
                    [weaks request:request postError:error];
                    if (error.code == 11002) {
                        [KMPathUtils writeErrorFile:task.currentRequest.allHTTPHeaderFields parameters:request.requestData.parameters];
                    }
                }
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSError *err = [ShowError error:error];
                [weaks request:request postError:err];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }];
        }
    });
}

- (void)request:(ShowRequest *)request postData:(id)data {
    if (request.successeBlock) {
        request.successeBlock(request, data);
    }
    [self removeRequest:request];
}

- (void)request:(ShowRequest *)request postError:(NSError *)error {
    if (![self.noNeedErrorAlertActionArray containsObject:request.requestData.interface]) {
//        [ShowWaringView waringView:error.userInfo[@"msg"] style:WaringStyleRed];
    }
    if (request.failedBlock) {
        request.failedBlock(request, error);
    }
    [self removeRequest:request];
}

- (void)requestPostCancel:(ShowRequest *)request {
    if (request.cancelledBlock) {
        request.cancelledBlock(request);
    }
    [self removeRequest:request];
}

- (void)removeRequest:(ShowRequest *)request {
    dispatch_sync(_dispatchQueue, ^{
        [self.requestQueue removeObjectForKey:request.requestID];
        
        if (self.requestQueue.count < QC_MAX_SERVICE_CONCURRENT_COUNT) {
            if (self.todoQueue.count > 0) {
                ShowRequest *request = self.todoQueue.firstObject;
                [self.todoQueue removeObjectAtIndex:0];
                [self startRequest:request];
            }
        }
    });
}

- (void)cancelRequestWithID:(NSString *)requestID {
    dispatch_async(_dispatchQueue, ^{
        ShowRequest *request = self.requestQueue[requestID];
        if (!request) {
            return;
        }
        [self requestPostCancel:request];
        [request cancel];
    });
}

- (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    //    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"beke" ofType:@"cer"];//证书的路径
    //  NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    //securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}

//加密
-(NSString *)cryptData:(NSDictionary *)cryptData parameters:(NSDictionary*)parameters;
{
    NSArray *arr = @[@"MAC",@"IM",@"IDFA",@"IDFY",@"Beke-Userid",@"Channel",@"Longitude",@"Latitude",@"Phone-Type",@"OP",@"CO",@"OS",@"SC",@"Kernel-Version",@"App-Version",@"VN",@"Net-Type",@"Time",@"Device-Uuid",@"TAG",@"Beke-UserToken",@"City",@"Device-Name",@"Phone-Number",@"Push-Id"];
    NSMutableDictionary *cryptM = [NSMutableDictionary dictionary];
    [cryptData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([arr containsObject:key]) {
            [cryptM setObject:obj forKey:key];
        }
    }];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [cryptM setObject:obj forKey:key];
    }];
    
    NSArray *keys = [cryptM allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *cryptStr = [NSMutableString string];
    for (NSString *categoryId in sortedArray) {
        
        NSString * value = [cryptM valueForKey:categoryId];
        [cryptStr appendFormat:@"%@=%@",categoryId,value];
    }
    
    [cryptStr appendFormat:@"dfafoi3j0rj0238ruh81028e"];
    
    NSString *encrypt = [self encodeToPercentEscapeString:cryptStr];
    return [NSString MD5WithString:encrypt];
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!'();:@&=$,/?+%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}

+(void)cleanAllCookie{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
}

-(NSArray *)noNeedErrorAlertActionArray{
    if (!_noNeedErrorAlertActionArray) {
        _noNeedErrorAlertActionArray = @[];
    }
    return _noNeedErrorAlertActionArray;
}
@end
