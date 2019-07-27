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


- (void)pan:(UIPanGestureRecognizer *)panGes {
    NSLog(@"%s",__func__);
    switch (panGes.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.delegate = self.transition;
            if ([ShowHomeBaseController isScollerPlayerView]) {
                ShowHomeBaseController * b = (ShowHomeBaseController *)self.viewControllers.lastObject;
                if(![b isKindOfClass:[ShowHomeBaseController class]]){
                    return ;
                }
                SLLiveListModel*model = [b.dataSource objectAtIndex:[[b getCurrentIndexPath] row]];
                if(model){
                    UserCenterViewController  *vc = [[UserCenterViewController alloc] initWithIsMe:NO andUserModel:model.master];
                    [self pushViewController:vc animated:YES];
                }
            }
            else
            {
                ShowHomeViewController * p = (ShowHomeViewController *)self.viewControllers.lastObject;
                ShowHomeBaseController * b = p.secondVC;
                SLLiveListModel*model = [b.dataSource objectAtIndex:[[b getCurrentIndexPath] row]];
                if(model){
                    UserCenterViewController  *vc = [[UserCenterViewController alloc] initWithIsMe:NO andUserModel:model.master];
                    [self pushViewController:vc animated:YES];
                }
                break;
            }
            
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            self.delegate = self;
//            SLPlayerViewController * p = (SLPlayerViewController *)self.viewControllers.lastObject;
//            p.switchView.scrollEnabled = YES;
            break;
        }
        default:
            break;
    }
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
 
