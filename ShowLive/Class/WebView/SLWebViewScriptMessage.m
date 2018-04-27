//
//  SLWebViewScriptMessage.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLWebViewScriptMessage.h"

@implementation SLWebViewScriptMessage
+ (instancetype)messageWithName:(NSString *)name body:(id)body
{
    SLWebViewScriptMessage *message = [[self alloc] init];
    message.name = name;
    message.body = body;
    return message;
}
@end
