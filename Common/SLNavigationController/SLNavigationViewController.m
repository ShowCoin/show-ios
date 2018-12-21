//
//  SLNavigationViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/5/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLNavigationViewController.h"
#import "SLNavigationControllerTransition.h"
#import "SLPlayerViewController.h"
#import "UserCenterViewController.h"
#import "ShowHomeViewController.h"
#import "HomeHeader.h"
#import "SLPlayerMoreController.h"
@interface SLNavigationViewController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) SLNavigationControllerTransition *transition;

@end

@implementation SLNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transition = [SLNavigationControllerTransition new];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [pan addTarget:self.transition action:@selector(pan:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];

    [self setNavigationBarHidden:YES animated:NO];
    self.interactivePopGestureRecognizer.delegate = self;
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    [[NSNotificationCenter defaultCenter]postNotificationName:SLHotScrollerNotification object:@(YES)];
    if((![HomeHeader isHot] && ![ShowHomeBaseController isScollerPlayerView])||[SLPlayerMoreController shared].clear){
        return NO ;
    }
    return YES ;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:SLHotScrollerNotification object:@(YES)];

    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return self.viewControllers.count > 1;
    }
    
    UIViewController *vc = self.topViewController;
    if (![vc isKindOfClass:[ShowHomeViewController class]]&&[ShowHomeBaseController isScollerPlayerView]!= YES) {
        return NO;
    }
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translationP = [pan translationInView:self.view];
        CGPoint velocityP = [pan velocityInView:self.view];
        if (translationP.x >= 0 && velocityP.x > 0) {
            return NO;
        }
        return YES;
    } else if ([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
        UISwipeGestureRecognizer *sges = (UISwipeGestureRecognizer *)gestureRecognizer;
        if (sges.direction == UISwipeGestureRecognizerDirectionLeft) {
            return YES;
        }
        return NO;
    }
    
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
