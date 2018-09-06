
//
//  UIImage+DLImage.h
//  videoTest
//
//  Created by show on 17/3/14.
//  Copyright © 2017年 show. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DLImage)
// 高效创建任何背景图
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)cornerImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius lineWidth:(CGFloat)lineWidth;


@end
