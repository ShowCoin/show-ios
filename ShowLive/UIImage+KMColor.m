//
//  UIImage+KMColor.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UIImage+KMColor.h"

@implementation UIImage (KMColor)

+ (UIImage *)createImageWithColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius{
    CGRect rect = CGRectMake(0.0f, 0.0f, width, width);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillEllipseInRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
