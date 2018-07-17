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

@end
