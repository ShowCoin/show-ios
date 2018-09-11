//
//  SLLoginHightButton.m
//  Edu
//
//  Created by chenyh on 2018/9/7.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLLoginHelpButton.h"

@interface SLLHBAniDelegate : NSObject <CAAnimationDelegate>

@property (nonatomic, copy) SLSimpleBlock aniblock;

@end

@implementation SLLHBAniDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.aniblock) {
        self.aniblock();
    }
}

@end

@interface SLLoginHelpButton ()
@property (nonatomic, strong) SLLHBAniDelegate *delegate;
@end

@implementation SLLoginHelpButton

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [self blackColor];
        [self setTitle:@"帮助" forState:UIControlStateNormal];
        [self setTitleColor:kGrayWith676767 forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont sl_fontMediumOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

        self.layer.cornerRadius = 14;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (UIColor *)blackColor {
     return HexRGBAlpha(0x242424, 1);
}

- (UIColor *)highlightedColor {
    return HexRGBAlpha(0x242424, 1);
}

- (void)beginAnimation {
    [self setTitleColor:HexRGBAlpha(0x0c0c0c, 1) forState:UIControlStateNormal];
    self.backgroundColor = HexRGBAlpha(0xf7f7f7, 1);
    
    CABasicAnimation *tcolorAni = [CABasicAnimation animationWithKeyPath:@"titleLabel.textColor"];
    tcolorAni.fromValue = (id)HexRGBAlpha(0x676767, 1).CGColor;
    tcolorAni.toValue = (id)HexRGBAlpha(0x0c0c0c, 1).CGColor;
    
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAni.fromValue = @1;
    scaleAni.toValue = @1.2;
    scaleAni.duration = 0.5;
    scaleAni.repeatCount = 2;
    scaleAni.autoreverses = YES;
    scaleAni.removedOnCompletion = NO;
    scaleAni.fillMode = kCAFillModeForwards;
    scaleAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.layer addAnimation:scaleAni forKey:nil];
    
//    CABasicAnimation *colorAni = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    colorAni.fromValue = (id)[self blackColor].CGColor;
//    colorAni.toValue = (id)[self highlightedColor].CGColor;
//    
//    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAni.fromValue = @1;
//    scaleAni.toValue = @1.1;
//    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.animations = @[colorAni, scaleAni];
//    group.duration = 0.5;
//    group.repeatCount = 2;
//    group.removedOnCompletion = NO;
//    group.autoreverses = YES;
//    group.fillMode = kCAFillModeForwards;
//    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    self.delegate = [[SLLHBAniDelegate alloc] init];
//    __weak typeof (self) wself = self;
//    self.delegate.aniblock = ^{
//        [wself doColorAni];
//    };
//    group.delegate = self.delegate;
//    [self.layer addAnimation:group forKey:nil];
}  

- (void)doColorAni {
    CABasicAnimation *colorAni = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    colorAni.fromValue = (id)[self blackColor].CGColor;
    colorAni.toValue = (id)[self highlightedColor].CGColor;
    colorAni.removedOnCompletion = NO;
    colorAni.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:colorAni forKey:nil];
}

@end
