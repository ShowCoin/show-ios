//
//  AnimateVIew.m
//  test
//
//  Created by 陈英豪 on 2018/5/23.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLLoopView.h"
#import "HomeHeader.h"

static NSString * const kAnimationKey    = @"AnimationKey";
static NSString * const kAnimationFirst  = @"kAnimationFirst";
static NSString * const kAnimationSecond = @"kAnimationSecond";

CGFloat const kLoopTopMargin = 6;
CGFloat const kSLLoopViewHeight = 44 + 6 + 6;

typedef void(^LoopBlock)(CAAnimation *anim, BOOL flag);

@interface LoopAnimationDelegate : NSObject <CAAnimationDelegate>

@property (nonatomic, copy) LoopBlock loopBlock;

@end

@implementation LoopAnimationDelegate

@end

@interface SLLoopView () <CAAnimationDelegate>

@property (nonatomic, weak) CAReplicatorLayer *reLayer;
@property (nonatomic, strong) SLLoopContentView *titleView;
@property (nonatomic, strong) SLLoopContentView *imageView;

@end

@implementation SLLoopView


@end

@interface SLLoopContentView ()

@property (nonatomic, weak) SLRotationImageView *imageView;
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation SLLoopContentView


@end

@implementation SLRotationImageView


@end
