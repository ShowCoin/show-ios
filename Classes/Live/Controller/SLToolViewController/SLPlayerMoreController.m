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
    [self addNotification];
}

#pragma mark - Method

- (void)addNotification {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(logoutAction) name:kNotificationLogout object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(sl_didReceiveMessage) name:kNotify_Received_RongCloud_ConvMsg object:nil];
}

- (void)sl_didReceiveMessage {
    [self.chatView loadConversationList];
}

- (void)logoutAction {
    [SLPlayerMoreController dismiss];
    onceToken = 0;
    _instance = nil;
}


/**
 setup ui
 */
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


/**
 when show window is need auto show max height

 @param more isShow more
 */
- (void)cx_windowMore:(BOOL)more {
    if (self.window.mj_h == kMessageMaxH) return;
    CGFloat h = kMessageMaxH - self.window.mj_h;
    
    [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
        if (more) {
            self.window.mj_y -= h;
            self.window.mj_h += h;
            self.backView.mj_y -= h;
            self.backView.mj_h += h;
        }
    } completion:nil];
}

- (CGFloat)backY {
    return self.windowY - kMargin10;
}

- (CGFloat)windowY {
    return self.toolY - 8 - self.window.mj_h;
}

- (CGFloat)windowH {
    if (count <= 3) {
        return kMTViewH + count * kMCellH;
    }
    NSInteger count = [self.chatView.dataSource.firstObject count];
    if (count == 0) {
        return kMessageViewH;
    }
    return kMessageMaxH;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [SLPlayerMoreController dismiss];
}

#pragma mark - Privte

/**
 @param type SLLiveToolType
 */
- (void)toolAction:(SLLiveToolType)type {
    
    if (   type == SLLiveToolTypeClear
        && [self.delegate respondsToSelector:@selector(sl_playerToolClearScreen:)]) {
        // do clear screen
        [self.delegate sl_playerToolClearScreen:self.toolView.clearSelect];
        [self postNotification:self.toolView.clearSelect];
        return;
    }
}


/**
 post notification

 @param select is select
 */
- (void)postNotification:(BOOL)select {
    [[NSNotificationCenter defaultCenter]postNotificationName:SLPlayerBottomCollectionNotification object:@(select)];
    [PageMgr setRootScrollEnabled:!select];
}

#pragma mark - Public

+ (void)resetTool {
    [SLPlayerMoreController.shared.toolView resetView];
}

+ (void)dismiss {
    [SLPlayerMoreController.shared dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation SLMoreAnimater

@end


@implementation PAPhotoAuthorized

@end
