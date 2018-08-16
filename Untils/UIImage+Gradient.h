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


@end
