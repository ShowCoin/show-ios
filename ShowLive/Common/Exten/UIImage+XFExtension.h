//
//  UIImage+XFExtension.h
//
//  Created by  JokeSmileZhang on 16/7/5.
//  Copyright © 2016年 JokeSmileZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};
@interface UIImage (XFExtension)

/**
 *  返回圆形图片
 */
- (instancetype)xf_circleImage;

+ (instancetype)xf_circleImage:(NSString *)name;

+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;
@end
