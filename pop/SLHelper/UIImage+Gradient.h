//
//  UIImage+Gradient.h
//  show
//
//  Created by showgx on 2017/12/18.
//  Copyright © show. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kUIImageGradientARGB(a,r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

typedef NS_ENUM(NSInteger, GradientType) {
    GradientFromTopToBottom = 1,
    GradientFromLeftToRight,
    GradientFromLeftTopToRightBottom,
    GradientFromLeftBottomToRightTop
};

@interface UIImage (Gradient)

- (UIImage *)purpleGradientColorPictureWithSize:(CGSize)size;


- (UIImage *)purpleGradientColorHighlightedPictureWithSize:(CGSize)size;


/**
 *  根据给定的颜色，生成渐变色的图片
 *  @param imageSize        要生成的图片的大小
 *  @param colorArr         渐变颜色的数组
 *  @param percents          渐变颜色的占比数组
 *  @param gradientType     渐变色的类型
 */
- (UIImage *)createImageWithSize:(CGSize)imageSize
                  gradientColors:(NSArray *)colorArr
                      percentage:(NSArray *)percents
                    gradientType:(GradientType)gradientType;

- (UIImage *)createCornerImageWithSize:(CGRect)imageRect
                        gradientColors:(NSArray *)colors
                            percentage:(NSArray *)percents
                          gradientType:(GradientType)gradientType;


@end
