//
//  KMUserDefaultUtils.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "KMUserDefaultUtils.h"

#define __Key_RecommendList @"__Key_RecommendList"
#define __Key_WorkTimeList @"WorkTimeList"
#define __Key_CircleList @"__Key_CircleList"

@implementation KMUserDefaultUtils

#pragma mark 推荐
+(BOOL)saveRecommendListCacheFromHome:(NSString *)jsonStr{
    if (jsonStr.length == 0) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:jsonStr forKey:__Key_RecommendList];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}
+(NSString *)getRecommendListCache{
    return [[NSUserDefaults standardUserDefaults] objectForKey:__Key_RecommendList];
}

#pragma mark 同城时刻
+(BOOL)saveWorkTimeListCacheFromHome:(NSString *)jsonStr{
    if (jsonStr.length == 0) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:jsonStr forKey:__Key_WorkTimeList];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

+(NSString *)getWorkTimeListCache{
    return [[NSUserDefaults standardUserDefaults] objectForKey:__Key_WorkTimeList];
}

#pragma mark - 好友圈
+(BOOL)saveCircleListCache:(NSString *)jsonStr{
    if (jsonStr.length == 0) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:jsonStr forKey:__Key_CircleList];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

+(NSString *)getCircleListCache{
    return [[NSUserDefaults standardUserDefaults] objectForKey:__Key_CircleList];
}

@end
