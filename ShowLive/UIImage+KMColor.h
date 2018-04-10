//
//  UIImage+KMColor.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KMColor)

+ (UIImage *)createImageWithColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius;

@end
