//
//  UIImageView+Category.h
//  show
//
//  Created by show on 16/6/21.
//  Copyright © 2016年 show. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Category)

//模糊加黑色蒙层在window 上
+(UIImageView*)blurImageWithView:(UIView*)view;

//生成gif图       名字  帧数
+(UIImageView*)imageViewWithGifFileName:(NSString*)name gifCount:(NSInteger)giftCount frame:(CGRect)frame;

/**
 序列帧动画生成 imageView
 
 @param imagesArray 序列帧数组
 @param duration 动画时间
 @param frame 坐标
 @return UIImageView
 */
+(UIImageView*)imageWithAnimationImages:(NSArray*)imagesArray animationDuration:(double)duration frame:(CGRect)frame;
@end
