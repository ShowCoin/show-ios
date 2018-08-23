//
//  UIScreen+JKFrame.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (JKFrame)

//获取SIZE
+ (CGSize)jk_size;
//获取Width
+ (CGFloat)jk_width;
//获取height
+ (CGFloat)jk_height;
//获取orientationSize
+ (CGSize)jk_orientationSize;
//获取orientationWidth
+ (CGFloat)jk_orientationWidth;
//获取orientationHeight
+ (CGFloat)jk_orientationHeight;
//获取DPISIZE
+ (CGSize)jk_DPISize;

@end
