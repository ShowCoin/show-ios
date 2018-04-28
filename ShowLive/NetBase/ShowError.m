//
//  ShowError.m
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowError.h"
#import "ShowErrorCode.h"
#define SHOW_NET_DEFAULTERROR @"网络连接不稳定，请重试"

@implementation ShowError
+(NSError *)errorWithDomain:(NSString *)domain message:(NSString *)message code:(NSInteger)code{
    NSLog(@"请求错误  domain: %@  message: %@  code: %ld  ",domain,message,code);
    BOOL serviceCode = YES;//[KMErrorCode serviceCode:code];
    if (code == 5005) {
        message = message.length >0 ? message : @"抱歉，您的登录已过期，请重新登录。";
    }else if(code == 5002){
        message = message.length >0 ? message : @"您的账号已经被封禁，请联系客服。";
    }else if(code == 2019){
        message = message.length >0 ? message : @"抱歉，您的登录已过期，请重新登录。";
    }
    NSString *msg = (serviceCode && message.length > 0) ? message : SHOW_NET_DEFAULTERROR;
    return [NSError errorWithDomain:domain code:code userInfo:@{@"msg":msg}];
}

+(NSError *)error:(NSError *)error{
    NSInteger code = error.code;
    NSURL *url = error.userInfo[@"NSErrorFailingURLKey"];
    NSString *domain = url !=nil? url.absoluteString : @"";
    NSString *message = error.localizedDescription;
    return [self errorWithDomain:domain message:message code:code];
}

@end
