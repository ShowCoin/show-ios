//
//  SLPlayerMoreViewController.m
//  ShowLive
//
//  Created by 陈英豪 on 2018/5/28.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPlayerMoreController.h"
#import "SLLiveChatVC.h"

// 75 = chat cell height
CGFloat const kMCellH = 75;
CGFloat const kMTViewH = 44 + 10;
CGFloat const kMessageViewH = kMCellH + kMTViewH;
CGFloat const kMessageMaxH = kMCellH * 3 + kMTViewH;

@interface SLPlayerMoreController ()

@property (nonatomic, strong) SLLiveChatVC *chatView;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) BOOL pause;
@property (nonatomic, strong) UIView *backView;

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

- (void)dealloc {
    self.window = nil;
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showWindow:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showWindow:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(logoutAction) name:kNotificationLogout object:nil];
}

- (void)logoutAction {
    [SLPlayerMoreController dismiss];
    onceToken = 0;
    _instance = nil;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor clearColor];
    
    CGFloat w = KScreenWidth - kMargin10 * 2;
    self.toolView = [SLToolView new];
    self.toolView.frame = CGRectMake(kMargin10, self.toolY, w, kSLToolViewH);
    self.toolView.layer.cornerRadius = 15;
    self.toolView.layer.masksToBounds = YES;
    @weakify(self)
    self.toolView.clickBlock = ^(SLLiveToolType type) {
        @strongify(self)
        [self toolAction:type];
    };
    [self.toolView addEffect:UIBlurEffectStyleDark];
    [self.view addSubview:self.toolView];
    
    self.chatView = [[SLLiveChatVC alloc] init];
    self.chatView.formType = SLLiveContollerTypePlayer;
    self.chatView.Controller = self.Controller;
    
    
    
    
    UIWindow *window = [[UIWindow alloc] init];
    window.backgroundColor = [UIColor clearColor];
    window.frame = CGRectMake(kMargin10, KScreenHeight, w, kMessageViewH);
    window.windowLevel = UIApplication.sharedApplication.keyWindow.windowLevel + 1;
    window.layer.cornerRadius = 15;
    window.layer.masksToBounds = YES;
    [window makeKeyAndVisible];
    [IQKeyboardManager sharedManager].enable = YES;
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.chatView];
    self.window = window;
    
    self.backView = [UIView new];
    CGFloat h = KScreenHeight - self.backY;
    self.backView.frame = CGRectMake(0, self.backY, KScreenWidth, h);
    self.backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [self.view insertSubview:self.backView atIndex:0];
}

#pragma mark - Animator

- (CGFloat)backY {
    return self.windowY - kMargin10;
}

- (CGFloat)windowY {
    return self.toolY - 8 - self.window.mj_h;
}

- (CGFloat)toolY {
    return KScreenHeight - kSLToolViewH  - kMargin10 - (__IphoneX__ ? 32 : 0);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [SLPlayerMoreController dismiss];
}

#pragma mark - Privte

- (void)toolAction:(SLLiveToolType)type {
    [SLPlayerMoreController dismiss];
    
    if (   type == SLLiveToolTypeClear
        && [self.delegate respondsToSelector:@selector(sl_playerToolClearScreen:)]) {
        // do clear screen
        [self.delegate sl_playerToolClearScreen:self.toolView.clearSelect];
        [self postNotification:self.toolView.clearSelect];
        return;
    }
    
    if (   type == SLLiveToolTypeScreenShot
        && [self.delegate respondsToSelector:@selector(sl_playerToolScreenShoot)]) {
        [self.delegate sl_playerToolScreenShoot];
        return;
    }
    
    if (type != SLLiveToolTypePause) return;
    if ([self.delegate respondsToSelector:(@selector(sl_playerToolPause))]) {
        [self.delegate sl_playerToolPause];
    }
    [SLPauseView.shared show:YES];
    SLPlayerMoreController.shared.pause = YES;
    @weakify(self)
    SLPauseView.shared.hiddenBlock = ^{
        @strongify(self)
        if ([self.delegate respondsToSelector:@selector(sl_playerToolResume)]) {
            [self.delegate sl_playerToolResume];
        }
        SLPlayerMoreController.shared.pause = NO;
    };
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
