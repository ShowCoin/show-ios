//
//  ShowRequest.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowRequest.h"
#import "ShowService.h"
@implementation ShowRequest
- (instancetype)init {
    self = [super init];
    if (self) {
        _requestID = [[self class] generateRequestID];
    }
    return self;
}

+(void)requestWithData:(NSString *)serverUrl requestData:(ShowRequestData *)requestData succeed:(ShowRequestSucceedBlock)succeedBlock failed:(ShowRequestFailedBlock)failedBlock cancelled:(ShowRequestCancelledBlock)cancelledBlock{
    NSLog(@"###----%@ ----",requestData.interface);
    ShowRequest *request = [[ShowRequest alloc] init];
    request.requestData =requestData;
    request.serverURL = serverUrl;
    
    request.successeBlock = succeedBlock;
    request.failedBlock = failedBlock;
    request.cancelledBlock = cancelledBlock;
    [ShowService startRequest:request];
}

+ (NSString *)generateRequestID {
    NSString *requestID = [NSString stringWithFormat:@"%.0f%lu",[[NSDate date] timeIntervalSince1970]*1000000,(unsigned long)arc4random()];
    return requestID;
}

-(void)cancel{
    self.successeBlock = nil;
    self.failedBlock = nil;
    self.cancelledBlock = nil;
}
@end
