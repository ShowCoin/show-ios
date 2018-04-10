//
//  KMencryption.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "KMencryption.h"
#import "NSString+MD5.h"
@implementation KMencryption

#pragma mark - 加密 已经包含请求参数
+(NSDictionary *)cryptDict:(NSDictionary *)cryptData parameters:(NSDictionary *)parameters{
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
    
    [cryptStr appendFormat:@"Knk9ss{3jMM;KD%%;k8km,s;sks/.,.]ski2G9,^43*5KM./a.aNNlf/.sdfgnp==>(mskI^8*NKD::I&^(^(KDH,WND..LK*%%KJD8'%%73djkssj...;'][sks"];
    
    NSString *encrypt = [self encodeToPercentEscapeString:cryptStr];
    NSString *md5 = [NSString MD5WithString:encrypt];
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:cryptData];
    [dictM setObject:md5 forKey:@"Sign1"];
    [dictM setObject:cryptStr forKey:@"cryptStr"];
    return dictM;
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!'();:@&=$,/?+%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}

@end
