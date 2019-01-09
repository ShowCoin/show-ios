//
//  SLLinkLabel.m
//  ShowLive
//
//  Created by vning on 2018/5/31.
//  Copyright © 2018年 vning. All rights reserved.
//


#import "UIColor+Equalable.h"

@implementation UIColor (Equalable)

- (BOOL)isEqualToColor:(UIColor *)otherColor {
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color) {
        if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            
    
    return [selfColor isEqual:otherColor];
    
  
}

@end
