//
//  UIColor+sLExtend.h
//  Dreamer
//
//  Created by show on 16/8/30.
//  Copyright © 2016年 show. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DLExtend)

/**
 *  将字符串颜色（RGB格式）转换成 UIColor
 *
 *  @param rgb RGB颜色格式: 234,234,234 或 #FF66CC
 *
 *  @return 返回 UIColor
 */
+ (UIColor* _Nonnull)colorWithRGB:(NSString* _Nonnull)rgb;

/**
 *  反回颜色的 RBG 格式字符串，如：#FFFFCC
 *
 *  @param color 颜色对象
 *
 *  @return 颜色字符串
 */
+ (NSString* _Nonnull)rgbFromColor:(UIColor* _Nonnull)color;

@end
