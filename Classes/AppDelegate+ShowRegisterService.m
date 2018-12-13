//
//  AppDelegate+RegisterService.m
//  ShowLive
//
//  Created by JokeSmileZhang on 2018/4/8.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "AppDelegate+ShowRegisterService.h"
#import <Bugtags/Bugtags.h>
#import "SLAliyunOSS.h"
#import "SLLocalNotificationCenter.h"
#import "JPUSHService.h"
#import "SLLocationManager.h"

@implementation ShowAppDelegateAppDelegate (ShowRegisterService)
/**
 注册  各种服务
 */
-(void)registerService:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self show_registerBugtags];
    [self show_registerJPush:launchOptions];
    [self show_registerMobClick];
    [self show_registerUmengSocial];
    [self show_registerAliyun];
    [self show_registerLocation];
    [self show_registerLocalNot];
    [SysConfig requestConfig];
    [loginMgr setup];
}

/**
 注册  BugTags
 */
- (void)show_registerBugtags{
#if !defined(DEBUG)
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingCrashes = YES; // 具体可设置的属性请查看 Bugtags.h
    [Bugtags startWithAppKey:@""  invocationEvent:BTGInvocationEventNone  options:options];
#endif
}

/**
  注册 友盟统计
 */
-(void)show_registerMobClick;
{
    [UMConfigure initWithAppkey:UM_Analytics_AppKey channel:@"App Store"];
    [UMConfigure setLogEnabled:NO];
}

/**
 注册  友盟分享
 */
-(void)show_registerUmengSocial;
{
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_Social_Appkey];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_APPID appSecret:UM_WX_AppSecret redirectURL:UM_WX_RedirectURL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINA_APPID appSecret:UM_SINA_AppSecret redirectURL:UM_SINA_RedirectURL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPID appSecret:UM_QQ_AppSecret redirectURL:UM_QQ_RedirectURL];
    
}


/**
 注册  阿里云
 */
-(void)show_registerAliyun{
}

/**
 注册  本地通知
 */
-(void)show_registerLocalNot{
    [[SLLocalNotificationCenter sharedCenter] registerLocalNotification:^(BOOL success) {
        //        NSLog(@"本地消息注册 %@", success?@"成功":@"失败");
    }];
}

/**
 注册  极光推送
 */
- (void)show_registerJPush:(NSDictionary *)launchOptions{
    NSString *advertisingId = [KMUtils idfa];
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_AppKey
                          channel:JPUSH_Channel
                 apsForProduction:JPUSH_isProduction
            advertisingIdentifier:advertisingId];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        } else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];

}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
/**
 app处于后端或者未开启时收到push

 @param center 通知中心
 @param response 收到消息
 @param completionHandler 回调
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    // 是否远程通知
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        } else {
            // 由于极光推送劫持了系统的本地推送回调，因此在此发接受本地消息的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kKMApplicationDidReceivedLocalNotification object:nil userInfo:response.notification.request.content.userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统执行这个方法
}

#endif

/**
 开启定位
 */
- (void)show_registerLocation
{
    [[SLLocationManager shareManager]startLocation];
}
@end
