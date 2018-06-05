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

static id _instance = nil;
static dispatch_once_t onceToken;

/**
 shared

 @return a SLPlayerMoreController objc
 */
+ (instancetype)shared {
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)postNotification:(BOOL)select {
    [[NSNotificationCenter defaultCenter]postNotificationName:SLPlayerBottomCollectionNotification object:@(select)];
    [PageMgr setRootScrollEnabled:!select];
}

@synthesize clear = _clear;

- (BOOL)clear {
    return self.toolView.clearSelect;
}

- (void)setClear:(BOOL)clear {
    _clear = clear;
    if (clear == NO) {
        [self.toolView resetView];
        [self.delegate sl_playerToolClearScreen:NO];
        
        [self postNotification:NO];
    }
}

#pragma mark - Public

+ (void)resetTool {
    [SLPlayerMoreController.shared.toolView resetView];
}

+ (void)dismiss {
    [SLPlayerMoreController.shared dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation SLMoreAnimater {
    BOOL _isPresent;
}

/**
 do dismissed animator delegate objc

 @param dismissed view
 @return protocal vc <UIViewControllerAnimatedTransitioning>
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresent = NO;
    return self;
}

/**
 UIViewControllerAnimatedTransitioning

 @param presented presented
 @param presenting presenting
 @param source source
 @return UIViewControllerAnimatedTransitioning
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isPresent = YES;
    return self;
}

#pragma mark - <UIViewControllerAnimatedTransitioning>

/**
 time

 @param transitionContext transitionContext
 @return NSTimeInterval
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

/**
 animateTransition

 @param transitionContext transitionCont
 */
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

@end


@implementation PAPhotoAuthorized


/// Return YES if Authorized 返回YES如果得到了授权
+ (BOOL)authorizationStatusAuthorized {
    NSInteger status = [self.class authorizationStatus];
    if (status == 0) {
        /**
         * 当某些情况下AuthorizationStatus == AuthorizationStatusNotDetermined时，无法弹出系统首次使用的授权alertView，系统应用设置里亦没有相册的设置，此时将无法使用，故作以下操作，弹出系统首次使用的授权alertView
         */
        [self requestAuthorizationWithCompletion:nil];
    }
    
    return status == 3;
}

+ (NSInteger)authorizationStatus {
    if (iOS8Later) {
        return [PHPhotoLibrary authorizationStatus];
    } else {
        return [ALAssetsLibrary authorizationStatus];
    }
    return NO;
}

+ (void)requestAuthorizationWithCompletion:(void (^)(void))completion {
    void (^callCompletionBlock)(void) = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    };
    
    if (iOS8Later) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                callCompletionBlock();
            }];
        });
    } else {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            callCompletionBlock();
        } failureBlock:^(NSError *error) {
            callCompletionBlock();
        }];
    }
}

@end
