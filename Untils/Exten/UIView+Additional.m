//
//  UIView+UIView_Additional.m
//  I500user
//
//  Created by shanWu on 15/4/9.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import "UIView+Additional.h"
#import <objc/runtime.h>

@implementation UIView (Additional)
- (void)addShadowWithColor:(UIColor *)color radius:(float)radius{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = radius;
    self.layer.shouldRasterize = YES;
    self.layer.shadowOpacity = 1;
    self.layer.rasterizationScale = kScreenScale;
}

@end
