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

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.loopBlock) {
        self.loopBlock(anim, flag);
    }
}

@end

@interface SLLoopView () <CAAnimationDelegate>

@property (nonatomic, weak) CAReplicatorLayer *reLayer;
@property (nonatomic, strong) SLLoopContentView *titleView;
@property (nonatomic, strong) SLLoopContentView *imageView;

@end

@implementation SLLoopView{
    BOOL isEndAni;
}

+ (instancetype)shared {
    static SLLoopView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SLLoopView alloc] init];
        instance.frame = CGRectMake(0, 0, KScreenWidth * 2, kSLLoopViewHeight);
        //[instance addTimer];
    });
    return instance;
}


@end

@interface SLLoopContentView ()

@property (nonatomic, weak) SLRotationImageView *imageView;
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation SLLoopContentView


@end

@implementation SLRotationImageView


@end
