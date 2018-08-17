//
//  UIImage+Gradient.m
//  SHOW
//
//  Created by show on 2017/12/18.
//  Copyright © 2017年 show All rights reserved.
//

#import "UIImage+Gradient.h"

@implementation UIImage (Gradient)

- (UIImage *)createImageWithSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GradientType)gradientType {
    
    NSAssert(percents.count <= 5, @"输入颜色数量过多，如果需求数量过大，请修改locations[]数组的个数");
    
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    


@end
