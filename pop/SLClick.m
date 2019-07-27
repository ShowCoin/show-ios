//
//  SLClick.m
//  ShowLive
//
//  Created by chenyh on 2018/6/22.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLClick.h"
#import "SLLaunchAction.h"
#import <UMAnalytics/MobClick.h>

static NSString * const kLaunchRecordTimeKey = @"kLaunchRecordTimeKey";

static NSString * const kClickLike  = @"clicklike";
static NSString * const kPlayerPlay = @"playerPlay";

@implementation SLClick

+ (void)sl_event:(SLClickType)e {
    switch (e) {
        case SLClickTypeLike:
            [MobClick event:kClickLike];
            break;
            
        case SLClickTypePlay:
            [MobClick event:kPlayerPlay];
            break;
            
        default:
            break;
    }
}

+ (void)sl_beginLogPageView:(id)cls {
    if ([cls isKindOfClass:[NSObject class]]) {
        [MobClick beginLogPageView:NSStringFromClass([cls class])];
    }
}

+ (void)sl_endLogPageView:(id)cls {
    if ([cls isKindOfClass:[NSObject class]]) {
        [MobClick endLogPageView:NSStringFromClass([cls class])];
    }
}

@end
