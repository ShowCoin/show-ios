//
//  SLClick.h
//  ShowLive
//
//  Created by chenyh on 2018/6/22.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SLClickType) {
    SLClickTypeLike,
    SLClickTypePlay,
};

@interface SLClick : NSObject

+ (void)sl_event:(SLClickType)e;

+ (void)sl_beginLogPageView:(id)cls;
+ (void)sl_endLogPageView:(id)cls;

+ (void)sl_launchRecord;
+ (void)sl_exitRecord;

@end
