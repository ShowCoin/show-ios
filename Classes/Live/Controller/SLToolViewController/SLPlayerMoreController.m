//
//  SLPlayerMoreViewController.m
//  ShowLive
//
//  Created by 陈英豪 on 2018/5/28.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPlayerMoreController.h"
#import "SLLiveChatVC.h"

static CGFloat kMessageViewH = 75 + 44 + 10;

@interface SLPlayerMoreController ()


@end

@implementation SLPlayerMoreController

@end

@implementation SLMoreAnimater {
    BOOL _isPresent;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresent = NO;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isPresent = YES;
    return self;
}

#pragma mark - <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGFloat h = UIScreen.mainScreen.bounds.size.height;
    CGFloat w = UIScreen.mainScreen.bounds.size.width;
    NSTimeInterval time = [self transitionDuration:transitionContext];
    UIView *containerView = [transitionContext containerView];
    if (_isPresent) {
        UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [containerView addSubview:presentedView];
        presentedView.frame = CGRectMake(0, h, w, h);
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            presentedView.frame = CGRectMake(0, 0, w, h);
        }completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        UIView *dismissedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [containerView addSubview:dismissedView];
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            dismissedView.frame =CGRectMake(0, h, w, h);
        }completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}
}

@end
