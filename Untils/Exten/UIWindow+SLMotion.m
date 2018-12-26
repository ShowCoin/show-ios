//
//  UIWindow+SLMotion.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/18.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UIWindow+SLMotion.h"
//#import "SULogger.h"

#define UIEventSubtypeMotionShakeNotification @"UIEventSubtypeMotionShakeNotification"

@implementation UIWindow (SLMotion)

- (BOOL)canBecomeFirstResponder {//默认是NO，所以得重写此方法，设成YES
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.type == UIEventSubtypeMotionShake) {
     //   [SULogger visibleChange];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"shake");
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
}

@end
