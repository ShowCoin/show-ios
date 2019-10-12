//
//  UIView+Gradient.h
//  show
//
//  Created by Show on 16/10/26.
//  Copyright © 2016年 Beijing show. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gradient)


//  坐标系

//        (0,0) -------(1,0)
//         |
//         |
//         |
//         |
//        (0,1)        (1,1)

/**
 geiView设置渐变色
 
 @param startPoint 其实坐标
 @param endPoint   结束坐标
 @param corlors    颜色数组
 @param locations    locations并不是表示颜色值所在位置,它表示的是颜色在Layer坐标系相对位置处要开始进行渐变颜色了.
 */
- (CAGradientLayer *)addGradientStart:(CGPoint)startPoint
                                  end:(CGPoint)endPoint
                               colors:(NSArray *)corlors
                            locations:(NSArray *)locations;

- (void)removeGraDient;

@end
