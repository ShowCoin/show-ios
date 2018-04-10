//
//  KMShareUtils.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KMShareUtils : NSObject

/**
 *  分享视频
 */
+(void)shareVideo:(NSString *)videoUrl shareUserName:(NSString *)shareUserName thumbImage:(UIImage *)thumbImage platform:(UMSocialPlatformType)platformType currentController:(id)controller completion:(UMSocialRequestCompletionHandler)completion isOffical:(BOOL)isOffical;

/**
 *  分享图片
 */
+(void)shareImage:(UIImage *)thumbImage contentUrl:(NSString *)url shareUserName:(NSString *)shareUserName platform:(UMSocialPlatformType)platformType currentController:(id)controller completion:(UMSocialRequestCompletionHandler)completion isOffical:(BOOL)isOffical;

/**
 *  分享视频
 */
+(void)shareVideo:(NSString *)videoUrl title:(NSString *)title desc:(NSString *)desc shareUserName:(NSString *)shareUserName thumbImage:(UIImage *)thumbImage platform:(UMSocialPlatformType)platformType currentController:(id)controller completion:(UMSocialRequestCompletionHandler)completion;

/**
 *  分享图片
 */
+(void)shareImage:(UIImage *)thumbImage title:(NSString *)title desc:(NSString *)desc contentUrl:(NSString *)url shareUserName:(NSString *)shareUserName platform:(UMSocialPlatformType)platformType currentController:(id)controller completion:(UMSocialRequestCompletionHandler)completion;

@end
