//
//  PageManager.h
//  ShowLive
//
//  Created by Mac on 2018/4/9.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTabBarController.h"
#import "RootViewController.h"
#import "UserInfoViewController.h"
#import "ShowSettingViewController.h"
#import "SLTopListViewController.h"
#define PageMgr [PageManager manager]

@interface PageManager : NSObject

@property (nonatomic, strong) BaseTabBarController *tabBarController;
@property (nonatomic, strong) RootViewController *rootController;

+ (instancetype)manager;
#pragma mark - logout
-(void)logout:(NSString *)content;

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
/**
 *  rootWindow
 */
- (UIWindow *)getCurrentWindow;
- (UIViewController *)getCurrentVC;
- (UIViewController *)topViewController;
#pragma mark -跳转个人信息页
-(void)pushtoUserInfoVC;
#pragma mark -跳转设置页
-(void)pushtoUserSettingVC;
#pragma mark -跳转榜单页
-(void)pushtoTopListVC;
#pragma mark - 跳转评论页
- (void)pushComment;
#pragma mark - 跳转赞页
- (void)pushLike;
#pragma mark - 跳转fans
- (void)pushFans;
#pragma mark - 跳到登录页
- (void)presentLoginViewController;
#pragma mark -跳转开播页
-(void)presentLiveViewController;
#pragma mark -私信页
- (void)pushToChatViewController;
#pragma mark - 聊天页
- (void)pushToChatViewControllerWithTargetUserId:(NSString *)targetUserId;
- (void)pushToFriendRequestViewController;
#pragma mark 个人页
- (void)pushToUserCenterControllerWithUid:(NSString *)userID ;
- (void)pushToUserCenterControllerWithUid:(NSString *)userID fromChat:(BOOL)fromChat;
#pragma mark - 联系人
- (void)pushToFriendListViewController;

@end
