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
    
    CGFloat locations[5];
    for (int i = 0; i < percents.count; i++) {
        locations[i] = [percents[i] floatValue];
    }
    
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, locations);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientFromTopToBottom:
            start = CGPointMake(imageSize.width/2, 0.0);
            end = CGPointMake(imageSize.width/2, imageSize.height);
            break;
        case GradientFromLeftToRight:
            start = CGPointMake(0.0, imageSize.height/2);
            end = CGPointMake(imageSize.width, imageSize.height/2);
            break;
        case GradientFromLeftTopToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imageSize.width, imageSize.height);
            break;
        case GradientFromLeftBottomToRightTop:
            start = CGPointMake(0.0, imageSize.height);
            end = CGPointMake(imageSize.width, 0.0);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)createCornerImageWithSize:(CGRect)imageRect gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GradientType)gradientType {
    NSAssert(percents.count <= 5, @"输入颜色数量过多，如果需求数量过大，请修改locations[]数组的个数");
    
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    
    CGFloat locations[5];
    for (int i = 0; i < percents.count; i++) {
        locations[i] = [percents[i] floatValue];
    }
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, locations);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientFromTopToBottom:
            start = CGPointMake(imageRect.size.width/2, 0.0);
            end = CGPointMake(imageRect.size.width/2, imageRect.size.height);
            break;
        case GradientFromLeftToRight:
            start = CGPointMake(0.0, imageRect.size.height/2);
            end = CGPointMake(imageRect.size.width, imageRect.size.height/2);
            break;
        case GradientFromLeftTopToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imageRect.size.width, imageRect.size.height);
            break;
        case GradientFromLeftBottomToRightTop:
            start = CGPointMake(0.0, imageRect.size.height);
            end = CGPointMake(imageRect.size.width, 0.0);
            break;
        default:
            break;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, imageRect.size.width / 2, imageRect.size.height / 2, imageRect.size.width / 2, 0, 2 * M_PI, NO);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGPathRelease(path);
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    [[[UIColor customColorWithString:@"FFFFFF"] colorWithAlphaComponent:0.5f] setStroke];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(imageRect, 4.f, 4.f) cornerRadius:imageRect.size.height / 2.f];
    path1.lineWidth = 1.5f;
    [path1 stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)purpleGradientColorPictureWithSize:(CGSize)size
{
    UIImage *image = [self createImageWithSize:CGSizeMake(size.width,size.height)
                                gradientColors:@[(id)kUIImageGradientARGB(1, 248, 54, 0), (id)kUIImageGradientARGB(1, 249, 212, 35)]
                                    percentage:@[@(0.3), @(1)]
                                  gradientType:GradientFromLeftToRight];
    return image;
}

- (UIImage *)purpleGradientColorHighlightedPictureWithSize:(CGSize)size
{
    UIImage *image = [[UIImage alloc] createImageWithSize:CGSizeMake(size.width, size.height)
                                           gradientColors:@[(id)kUIImageGradientARGB(0.8, 248, 54, 0), (id)kUIImageGradientARGB(0.8, 249, 212, 35)]
                                               percentage:@[@(0.3), @(1)]
                                             gradientType:GradientFromLeftToRight];
    return image;
}

@end
