//
//  KMShareUtils.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "KMShareUtils.h"

@implementation KMShareUtils

/**
 *  分享视频
 */
+(void)shareVideo:(NSString *)videoUrl shareUserName:(NSString *)shareUserName thumbImage:(UIImage *)thumbImage platform:(UMSocialPlatformType)platformType currentController:(id)controller completion:(UMSocialRequestCompletionHandler)completion isOffical:(BOOL)isOffical{
//    NSString *title = @"";
//    NSString *desc = @"";
//    if(isOffical){
//        title = SysConfig.shareMsgTitle;
//        desc = SysConfig.shareMsgDesc;
//    }
//    [self shareVideo:videoUrl title:title desc:desc shareUserName:shareUserName thumbImage:thumbImage platform:platformType currentController:controller completion:completion];
}

/**
 *  分享图片
 */
+(void)shareImage:(UIImage *)thumbImage contentUrl:(NSString *)url shareUserName:(NSString *)shareUserName platform:(UMSocialPlatformType)platformType currentController:(id)controller completion:(UMSocialRequestCompletionHandler)completion isOffical:(BOOL)isOffical{
//    NSString *title = @"";
//    NSString *desc = @"";
//    if(isOffical){
//        title = SysConfig.shareMsgTitle;
//        desc = SysConfig.shareMsgDesc;
//    }
//    [self shareImage:thumbImage title:title desc:desc contentUrl:url shareUserName:shareUserName platform:platformType currentController:controller completion:completion];
}

/**
 *  分享视频
 */
+(void)shareVideo:(NSString *)videoUrl title:(NSString *)title desc:(NSString *)desc shareUserName:(NSString *)shareUserName thumbImage:(UIImage *)thumbImage platform:(UMSocialPlatformType)platformType currentController:(id)controller completion:(UMSocialRequestCompletionHandler)completion{
    
    NSString *waringStr = [self warningStrNotInstallWithPlatformType:platformType];

//    if (platformType == UMSocialPlatformType_Qzone || platformType == UMSocialPlatformType_QQ) {
//        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
//            [KMWaringView waringView:waringStr style:WaringStyleRed];
//            return;
//        }
//    }else {
//        if (![[UMSocialManager defaultManager] isInstall:platformType]) {
//            [KMWaringView waringView:waringStr style:WaringStyleRed];
//            return;
//        }
//    }
//
//    if (title.length == 0 ) {
//        title = SysConfig.shareTitle.count >0 ? SysConfig.shareTitle[arc4random() % SysConfig.shareTitle.count] : @"";
//    }
//
//    NSRange range = [title rangeOfString:@"%nickname%"];
//    if (range.length >0) {
//        if (shareUserName.length == 0) {
//            shareUserName = UserProfile.nickName;
//        }
//        title = [title stringByReplacingCharactersInRange:range withString:shareUserName];
//    }
//
//    if (desc.length == 0) {
//        if (platformType == UMSocialPlatformType_WechatSession) {
//            desc = SysConfig.shareWx.count > 0 ? SysConfig.shareWx[arc4random() % SysConfig.shareWx.count] : @"";
//        }else if (platformType == UMSocialPlatformType_WechatTimeLine) {
//            desc = SysConfig.shareWxPyq.count > 0 ? SysConfig.shareWxPyq[arc4random() % SysConfig.shareWxPyq.count] : @"";
//        }else if (platformType == UMSocialPlatformType_Sina) {
//            desc = SysConfig.shareWeibo.count > 0 ? SysConfig.shareWeibo[arc4random() % SysConfig.shareWeibo.count] : @"";
//        }else if (platformType == UMSocialPlatformType_Sina) {
//            desc = SysConfig.shareQq.count > 0 ? SysConfig.shareQq[arc4random() % SysConfig.shareQq.count] : @"";
//        }else if (platformType == UMSocialPlatformType_Sina) {
//            desc = SysConfig.shareQqzone.count > 0 ? SysConfig.shareQqzone[arc4random() % SysConfig.shareQqzone.count] : @"";
//        }
//    }
    
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:desc thumImage:thumbImage];
    //设置视频网页播放地址
    shareObject.videoUrl = videoUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:controller completion:^(id result, NSError *error) {
        if (completion) {
            completion(result,error);
        }
    }];
}
/**
 *  分享图片
 */
+(void)shareImage:(UIImage *)thumbImage title:(NSString *)title desc:(NSString *)desc contentUrl:(NSString *)url shareUserName:(NSString *)shareUserName platform:(UMSocialPlatformType)platformType currentController:(id)controller completion:(UMSocialRequestCompletionHandler)completion{
    
    NSString *waringStr = [self warningStrNotInstallWithPlatformType:platformType];
    
//    if (platformType == UMSocialPlatformType_Qzone || platformType == UMSocialPlatformType_QQ) {
//        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
//            [KMWaringView waringView:waringStr style:WaringStyleRed];
//            return;
//        }
//    }else {
//        if (![[UMSocialManager defaultManager] isInstall:platformType]) {
//            [KMWaringView waringView:waringStr style:WaringStyleRed];
//            return;
//        }
//    }
//    
//    if (title.length == 0 ) {
//        title = SysConfig.shareTitle.count >0 ? SysConfig.shareTitle[arc4random() % SysConfig.shareTitle.count] : @"";
//    }
//    
//    NSRange range = [title rangeOfString:@"%nickname%"];
//    if (range.length >0) {
//        if (shareUserName.length == 0) {
//            shareUserName = UserProfile.nickName;
//        }
//        title = [title stringByReplacingCharactersInRange:range withString:shareUserName];
//    }
//    
//    if (desc.length == 0) {
//        if (platformType == UMSocialPlatformType_WechatSession) {
//            desc = SysConfig.shareWx.count > 0 ? SysConfig.shareWx[arc4random() % SysConfig.shareWx.count] : @"";
//        }else if (platformType == UMSocialPlatformType_WechatTimeLine) {
//            desc = SysConfig.shareWxPyq.count > 0 ? SysConfig.shareWxPyq[arc4random() % SysConfig.shareWxPyq.count] : @"";
//        }else if (platformType == UMSocialPlatformType_Sina) {
//            desc = SysConfig.shareWeibo.count > 0 ? SysConfig.shareWeibo[arc4random() % SysConfig.shareWeibo.count] : @"";
//            desc = title.length >0 ? [NSString stringWithFormat:@"%@%@",title,desc] : desc;
//            title = @"";
//            if (url.length >0) {
//                desc = [NSString stringWithFormat:@"%@%@",desc,url];
//            }
//        }else if (platformType == UMSocialPlatformType_QQ) {
//            desc = SysConfig.shareQq.count > 0 ? SysConfig.shareQq[arc4random() % SysConfig.shareQq.count] : @"";
//        }else if (platformType == UMSocialPlatformType_Qzone) {
//            desc = SysConfig.shareQqzone.count > 0 ? SysConfig.shareQqzone[arc4random() % SysConfig.shareQqzone.count] : @"";
//        }
//    }else{
//        if (platformType == UMSocialPlatformType_Sina) {
//            desc = title.length >0 ? [NSString stringWithFormat:@"%@%@",title,desc] : desc;
//            title = @"";
//            if (url.length >0) {
//                desc = [NSString stringWithFormat:@"%@%@",desc,url];
//            }
//        }
//    }
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = title;
    messageObject.text = desc;
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.thumbImage = thumbImage;
    shareObject.shareImage = thumbImage;
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:controller completion:^(id result, NSError *error) {
        if (completion) {
            completion(result,error);
        }
    }];
}

+ (NSString *)warningStrNotInstallWithPlatformType:(UMSocialPlatformType)platformType
{
    NSString *str = nil;
    switch (platformType) {
        case UMSocialPlatformType_Sina:
        {
            str = @"未安装微博";
            break;
        }
        case UMSocialPlatformType_WechatSession:
        case UMSocialPlatformType_WechatTimeLine:
        case UMSocialPlatformType_WechatFavorite:
        {
            str = @"未安装微信";
            break;
        }
        case UMSocialPlatformType_QQ:
        case UMSocialPlatformType_Qzone:
        {
            str = @"未安装QQ";
            break;
        }

        default:
            str = @"未安装该APP";
            break;
    }
    return str;
}

@end
