//
//  PageManager.m
//  ShowLive
//
//  Created by 周华 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "PageManager.h"
#import "ShowLoginViewController.h"
#import "SLChatViewController.h"
#import "SLPrivateChatViewController.h"
#import "SLLiveViewController.h"
#import "SLAppMediaPerssion.h"
#import "SLCommentViewController.h"
#import "SLFansViewController.h"
#import "SLFriendListViewController.h"

@interface PageManager ()

/**
 *  rootWindow
 */
@property (nonatomic ,strong) UIWindow *rootWindow;
/**
 *  loginNav
 */
@property (nonatomic, weak) UINavigationController *loginNav;

@end

@implementation PageManager
+ (instancetype)manager {
    static id __obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __obj = [[self alloc] init];
    });
    return __obj;
}
#pragma mark - 初始化
-(void)setupWithWindow:(UIWindow *)rootWindow{
    [self config];
    self.rootWindow = rootWindow;
    self.rootController = [[RootViewController alloc] init];
    rootWindow.rootViewController = self.rootController;
}

#pragma mark window
-(UIWindow *)getCurrentWindow{
    return self.rootWindow;
}

#pragma mark 配置
-(void)config{
    
}
#pragma mar dealloc
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - tabBarController
-(BaseTabBarController *)tabBarController{
    
    return self.rootController.tabBarController;

}
#pragma mark 是否不存在子页
-(BOOL)hasNoNextController:(UIViewController *)controller{
    UINavigationController *nav = (UINavigationController *)self.tabBarController.selectedViewController;
    NSString *className =  NSStringFromClass([nav.topViewController class]);
    if ([[self.tabBarController tabBarTopController] containsObject:className]) {
        return  controller.presentingViewController ? NO :YES;
    }else {
        return NO;
    }
}

-(BOOL)hasNoNextControllerInCurrentTab{
    UINavigationController *nav = (UINavigationController *)self.tabBarController.selectedViewController;
    NSString *className =  NSStringFromClass([nav.topViewController class]);
    if ([[self.tabBarController tabBarTopController] containsObject:className]) {
        return NO;
    }else {
        return YES;
    }
}

#pragma mark - 常规操作

- (void)setTabBarSelectedIndexType:(BaseTabBarControllerIndexType)selectedIndexType
{
    [self.tabBarController setTabBarSelectedIndex:selectedIndexType];
}

- (void)dismissAndPopAllPagesBackToTopTabAnimated:(BOOL)animation
{
    [self dismissAllPresentedViewController];
    UINavigationController *nav = self.tabBarController.selectedViewController;
    [nav popToRootViewControllerAnimated:animation];
}

- (BOOL)isControllerInTop:(NSString *)controllerName
{
    if (!controllerName) {
        return NO;
    }
    
    Class cls = NSClassFromString(controllerName);
    UINavigationController *nav = (UINavigationController *)self.tabBarController.selectedViewController;
    if ([nav.topViewController isKindOfClass:cls]) {
        return YES;
    }
    return NO;
}

#pragma mark - Private
- (void)dismissAllPresentedViewController
{
    if (self.tabBarController.presentedViewController) {
        if ([self.tabBarController.presentedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)self.tabBarController.presentedViewController;
            UIViewController *viewController = navigationController.topViewController;
            [viewController dismissViewControllerAnimated:NO completion:nil];
        } else {
            [self.tabBarController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        }
    }
}
#pragma mark - 私信页面

- (void)pushToChatViewController
{
    SLChatViewController *vc = [[SLChatViewController alloc] init];
    vc.hidesBottomBarWhenPushed  = YES;
    UINavigationController *nav = self.tabBarController.selectedViewController;
    [nav pushViewController:vc animated:YES];
}

#pragma mark - 开播页面
-(void)presentLiveViewController
{
    [SLAppMediaPerssion requestMediaCapturerAccessWithCompletionHandler:^(SLDeviceErrorStatus status) {
        switch (status) {
            case 0:
            {
     
                SLLiveViewController *vc = [[SLLiveViewController alloc] init];
                vc.hidesBottomBarWhenPushed  = YES;
                UINavigationController *nav = self.tabBarController.selectedViewController;
                [nav pushViewController:vc animated:YES];
            }
                
                break;
            default:
            {
            
                
            }
                break;
        }
        
    }];

}

#pragma mark - 登录页面
- (void)presentLoginViewController{
    UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:[[ShowLoginViewController alloc]init]];
    [self.tabBarController presentViewController:loginNav animated:YES completion:nil];
    self.loginNav = loginNav;
}
#pragma mark - 聊天页面
- (void)pushToChatViewControllerWithTargetUserId:(NSString *)targetUserId
{
    if (AccountUserInfoModel.userid) {
            SLPrivateChatViewController *vc = [[SLPrivateChatViewController alloc] init];
            vc.targetUid = targetUserId;
            UINavigationController *nav = self.tabBarController.selectedViewController;
            [nav pushViewController:vc animated:YES];
    }else{
        [self presentLoginViewController];
    }
}
#pragma mark - logout
-(void)logout:(NSString *)content{
    __weak typeof(self) weaks =self;
    dispatch_block_t block = ^{
        //清除用户信息
        [IMSer logout];
        
        BOOL showText = self.loginNav? NO : YES;
        if (showText && content.length >0) {
            [weaks presentLoginViewController];
        }
        
        for(UINavigationController *nav in weaks.tabBarController.viewControllers){
            [nav popToRootViewControllerAnimated:NO];
        }
        
        NSString *msg = content;
        if (msg.length >0 && showText) {
            [ShowWaringView waringView:msg style:WaringStyleRed];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil userInfo:nil];
    };
    dispatch_main_sync_safe(block);
}

#pragma mark - 跳转个人信息页
-(void)pushtoUserInfoVC;
{
    UINavigationController *nav = self.tabBarController.selectedViewController;
    UserInfoViewController *vc = [[UserInfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];

}
#pragma mark - 跳转设置页
-(void)pushtoUserSettingVC;
{
    UINavigationController *nav = self.tabBarController.selectedViewController;
    ShowSettingViewController *vc = [[ShowSettingViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];

}

#pragma mark - 跳转榜单页
-(void)pushtoTopListVC
{
    UINavigationController *nav = self.tabBarController.selectedViewController;
    SLTopListViewController *vc = [[SLTopListViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];

}
#pragma mark - 跳转评论页
- (void)pushComment
{
    UINavigationController *nav = self.tabBarController.selectedViewController;
    SLCommentViewController *vc = [[SLCommentViewController alloc] init];
    vc.navTitle = @"评论";
    [nav pushViewController:vc animated:YES];
}
#pragma mark - 跳转赞页
- (void)pushLike
{
    UINavigationController *nav = self.tabBarController.selectedViewController;
    SLCommentViewController *vc = [[SLCommentViewController alloc] init];
    vc.navTitle = @"赞👍";
    [nav pushViewController:vc animated:YES];
}
#pragma mark - 跳转fans
- (void)pushFans
{
    UINavigationController *nav = self.tabBarController.selectedViewController;
    SLFansViewController *vc = [[SLFansViewController alloc] init];
    [nav pushViewController:vc animated:YES];
}
#pragma mark 个人页

- (void)pushToUserCenterControllerWithUid:(NSString *)userID {
    [self pushToUserCenterControllerWithUid:userID fromChat:NO];
}

- (void)pushToUserCenterControllerWithUid:(NSString *)userID fromChat:(BOOL)fromChat
{
    [ShowWaringView waringView:@"跳转个人页" style:WaringStyleBlue];
}
#pragma mark - 联系人

- (void)pushToFriendListViewController
{
    SLFriendListViewController* vc=[SLFriendListViewController new];
    UINavigationController *nav = self.tabBarController.selectedViewController;
    [nav pushViewController:vc animated:YES];
}

@end
