//
//  PageManager.m
//  ShowLive
//
//  Created by 周华 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "PageManager.h"
#import "ShowLoginViewController.h"
#import "ShowLiveViewController.h"
#import "SLChatViewController.h"

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
    UINavigationController *nav = self.tabBarController.selectedViewController;
    [nav pushViewController:vc animated:YES];
}

#pragma mark - 开播页面
-(void)presentLiveViewController
{
    UINavigationController *LiveNav = [[UINavigationController alloc]initWithRootViewController:[[ShowLiveViewController alloc]init]];
    [self.tabBarController presentViewController:LiveNav animated:YES completion:nil];
}

#pragma mark - 登录页面
- (void)presentLoginViewController{
    UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:[[ShowLoginViewController alloc]init]];
    [self.tabBarController presentViewController:loginNav animated:YES completion:nil];
    self.loginNav = loginNav;
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
@end
