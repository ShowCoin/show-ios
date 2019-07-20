//
//  UIColor+color.m
//  test
//
//  Created by chenyh on 2018/5/31.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "UIColor+color.h"
@implementation UIColor (color)
+ (UIColor *)sl_arc4randomColor {
    CGFloat r = arc4random_uniform(255.0) / 255.0;
    CGFloat g = arc4random_uniform(255.0) / 255.0;
    CGFloat b = arc4random_uniform(255.0) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
