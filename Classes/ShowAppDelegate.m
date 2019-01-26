//
//  AppDelegate.m
//  ShowLive
//
//  Created by vning on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAppDelegate.h"
#import "BaseTabBarController.h"
#import "AppDelegate+RegisterService.h"
#import "WXApi.h" 
#import "SLFPSStatus.h"
#import <AVFoundation/AVFoundation.h>
@interface ShowAppDelegateAppDelegate ()

@end

@implementation ShowAppDelegate
//入口函数
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    __weak typeof(self) weaks = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weaks show_registerService:application didFinishLaunchingWithOptions:launchOptions];
    });
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [PageMgr setupWithWindow:self.window];
    self.window.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.window makeKeyAndVisible];
    
    #if defined(DEBUG)
        [[SLFPSStatus sharedInstance] open];
    #endif
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


/**
 desp add

 @param application UIApplication 
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - 收到 的 APNS 通知 体
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    // 实现了这个方法：application:didReceiveRemoteNotification:fetchCompletionHandler:，本方法不再走了
    NSLog(@"iOS10以下系统，收到远程通知:%@",userInfo);
}

#pragma mark - ios10之前
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS10以下系统，收到远程通知(前台或者后台):%@",userInfo);
    // 只处理后台消息,点起app从后台到前台也要加上，
    if (application.applicationState != UIApplicationStateActive) {

    }
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"iOS10以下系统，收到本地通知:%@",notification.userInfo);
    [[NSNotificationCenter defaultCenter] postNotificationName:kKMApplicationDidReceivedLocalNotification object:nil userInfo:notification.userInfo];
}

#pragma mark - 注册deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
    [IMSer setDeviceToken:deviceToken];
}
#pragma mark - 注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings: (UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#pragma mark - application openURL
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // 地图打开
    NSString* wxPayPre=[NSString stringWithFormat:@"%@://",WX_APPID];
    NSString* currentURLPre=[url.absoluteString substringToIndex:[wxPayPre length]];
    if ([currentURLPre isEqualToString:wxPayPre]) {
        if ([url.absoluteString containsString:@"ret=0"]) {//成功后pop
        }
        return  NO;
    }

}

@end
