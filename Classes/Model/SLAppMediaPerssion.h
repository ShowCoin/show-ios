//
//  SLAppMediaPerssion.h
//  ShowLive
//
//  Created by showgx on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLAppMediaPerssion : NSObject


+ (void)requestMediaCapturerAccessWithCompletionHandler:(void (^)(SLDeviceErrorStatus status))handler;

@end
