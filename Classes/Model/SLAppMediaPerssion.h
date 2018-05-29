//
//  SLAppMediaPerssion.h
//  ShowLive
//
//  Created by showgx on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
//硬件权限枚举
typedef NS_ENUM(NSInteger, SLDeviceErrorStatus) {
    AVDeviceNOErrorStatus  =0,//都开了
    AudioDeviceErrorStatus = 1,//麦克风没开,相机开
    VedioDeviceErrorStatus,//相机没开，麦克风开
    AVDeviceErrorStatus, //都没开
    
};
@interface SLAppMediaPerssion : NSObject


+ (void)requestMediaCapturerAccessWithCompletionHandler:(void (^)(SLDeviceErrorStatus status))handler;

@end
