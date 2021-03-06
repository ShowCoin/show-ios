//
//  AnimateVIew.h
//  test
//
//  Created by 陈英豪 on 2018/5/23.
//  Copyright © 2018年 chuxia. All rights reserved.
//
//
// loop view animater with ContentView and RotationImageView

#import <UIKit/UIKit.h>
#import "SLMusicView.h"

UIKIT_EXTERN CGFloat const kLoopTopMargin;
UIKIT_EXTERN CGFloat const kSLLoopViewHeight;

@interface SLLoopView : UIView

@property (nonatomic, assign, readonly) BOOL isAnimating;

// can set view's text/image
- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle;
// beginAnimation
- (void)beginAnimation;
// endAnimation
- (void)endAnimation;
// show title rotation view
- (void)showTitleMusicView;

//+ (instancetype)shared;

@end


@class SLRotationImageView;

@interface SLLoopContentView : UIView

// SLRotationImageView
@property (nonatomic, weak, readonly) SLRotationImageView *imageView;
// textLabel
@property (nonatomic, weak, readonly) UILabel *textLabel;

@end
