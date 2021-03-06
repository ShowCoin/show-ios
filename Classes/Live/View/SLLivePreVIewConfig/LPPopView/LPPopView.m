//
//  LPPopView.m
//  Edu
//
//  Created by chenyh on 2018/9/20.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "LPPopView.h"

@implementation LPPopView

@synthesize animating = _animating;

/** 增加描述

 @param frame set frame
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame
{// initWithFrame
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        self.layer.anchorPoint = CGPointMake(0.5, 0);        
    }
    return self;
}

#pragma mark - Method

/** sl_show method

 @param show sl_show
 @param complete
 */
- (void)sl_show:(BOOL)show complete:(void(^)(void))cmp {
    self->_animating = YES;
    /// option
    UIViewAnimationOptions option;
    if (show) {
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(1, 0.001);
        option = UIViewAnimationOptionCurveEaseOut;
    } else {
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
        option = UIViewAnimationOptionCurveEaseIn;
    }
    /// animation
    [UIView animateWithDuration:kLPAniDuration delay:0 options:option animations:^{
        if (show) {
            self.alpha = 1;
            self.transform = CGAffineTransformIdentity;
        } else {
            self.alpha = 0;
            self.transform = CGAffineTransformMakeScale(1, 0.001);
        }
    } completion:^(BOOL finished) {
        self->_animating = NO;
        if (cmp) {
            cmp();
        }
    }];
}

@end
