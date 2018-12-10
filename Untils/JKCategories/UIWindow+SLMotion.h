//
//  UIWindow+SLMotion.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/18.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (SLMotion)

- (BOOL)canBecomeFirstResponder;
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;


@end
