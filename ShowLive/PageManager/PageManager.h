//
//  PageManager.h
//  ShowLive
//
//  Created by 周华 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTabBarController.h"
#import "RootViewController.h"

#define PageMgr [PageManager manager]

@interface PageManager : NSObject

@property (nonatomic, strong) BaseTabBarController *tabBarController;
@property (nonatomic, strong) RootViewController *rootController;

+ (instancetype)manager;
/// 跳到登录页
- (void)presentLoginViewController;
//跳转开播页
-(void)presentLiveViewController;
//私信页
- (void)pushToChatViewController;
/**
 *  tabbar 是否还有下一级Controller
 */
-(BOOL)hasNoNextController:(UIViewController *)controller;
/**
 *  当前 tabbar 是否还有下一级
 */
-(BOOL)hasNoNextControllerInCurrentTab;
/**
 *  初始化配置
 */
-(void)setupWithWindow:(UIWindow *)rootWindow;
#pragma mark - logout
-(void)logout:(NSString *)content;



@end
