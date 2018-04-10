//
//  KMUserDefaultUtils.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KMUserDefaultUtils : NSObject

#pragma mark - 首页
#pragma mark 推荐
+(BOOL)saveRecommendListCacheFromHome:(NSString *)jsonStr;
+(NSString *)getRecommendListCache;

#pragma mark 同城时刻
+(BOOL)saveWorkTimeListCacheFromHome:(NSString *)jsonStr;
+(NSString *)getWorkTimeListCache;

#pragma mark - 好友圈
+(BOOL)saveCircleListCache:(NSString *)jsonStr;
+(NSString *)getCircleListCache;

@end
