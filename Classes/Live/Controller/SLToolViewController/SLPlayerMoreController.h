//
//  SLPlayerMoreViewController.h
//  ShowLive
//
//  Created by 陈英豪 on 2018/5/28.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLMoreActionView.h"
#import "SLToolView.h"

#define PlayMoreMgr [SLPlayerMoreController shared]

@class SLMoreAnimater;

@protocol SLPlayerMoreDelegate <NSObject>

@optional
- (void)sl_playerToolPause;
- (void)sl_playerToolResume;
// YES: clear NO: resume
- (void)sl_playerToolClearScreen:(BOOL)isClear;
- (void)sl_playerToolScreenShoot;

@end

@interface SLPlayerMoreController : UIViewController

@property (nonatomic, assign, readonly) BOOL pause;
@property (nonatomic, assign) BOOL clear; // YES: isClear NO: isResume

@property (nonatomic, weak) id <SLPlayerMoreDelegate> delegate;
@property (nonatomic, weak) BaseViewController * Controller;
@property (nonatomic, strong) SLToolView *toolView;

+ (instancetype)shared;
// when change viewcontroller need resetTool
// + (void)resetTool;
+ (void)dismiss;

@end

@interface SLMoreAnimater : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@end

@interface PAPhotoAuthorized : NSObject


@end
