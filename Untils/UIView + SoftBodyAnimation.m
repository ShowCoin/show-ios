//
//  UIView + SoftBodyAnimation.m
//  ButtonAnimation
//
//  Created by show on 2017/6/13.
//  Copyright © 2017年 showgx. All rights reserved.
//
#import <objc/runtime.h>
#import "UIView + SoftBodyAnimation.h"

static const char *kisPlayBodyAnimation = "kisPlayBodyAnimation";
static const char *kisAnimationZoomX = "kisAnimationZoomX";
static const char *kisScaleXY = "kisScaleXY";


@implementation UIView(SoftBodyAnimation)

-(void)startSoftBodyAnimation{
    
    self.isPlayBodyAnimation = YES;
    self.isAnimationZoomX = YES;
    
    [self softBodyMotion];
}

-(void)softBodyMotion{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction  animations:^{
        if(weakSelf.isAnimationZoomX){
            weakSelf.transform = CGAffineTransformMakeScale(1.04, 0.96);
        }else{
            weakSelf.transform = CGAffineTransformMakeScale(0.96, 1.04);
        }
        
    } completion:^(BOOL finished) {
        if(finished){
            if(weakSelf.isPlayBodyAnimation == NO){
                return;
            }
            weakSelf.isAnimationZoomX = !self.isAnimationZoomX;
            [weakSelf softBodyMotion];
        }
        
    }];
}
-(void)startScaleMotion{
    self.isScaleXY  = YES;
    [self scaleMotion];
}
-(void)scaleMotion{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction| UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat  animations:^{
        if(weakSelf.isScaleXY == NO){
            return;
        }
        weakSelf.transform = CGAffineTransformMakeScale(1.03, 1.03);
    } completion:^(BOOL finished) {
    }];
}
-(void)stopScaleMotion{
    self.isScaleXY  = NO;
}


@end
