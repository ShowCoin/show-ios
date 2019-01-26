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



@end
