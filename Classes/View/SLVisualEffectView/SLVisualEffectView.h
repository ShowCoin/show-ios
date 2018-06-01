//
//  SLVisualEffectView.h
//  ShowLive
//
//  Created by show gx on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLVisualEffectView : UIView

/**
 创建毛玻璃view
 
 @param frame       frame
 @param stytle      毛玻璃样式
 @param effectColor 毛玻璃色值
 
 @return 返回毛玻璃特效VIew
 */
+ (instancetype)creatForstedClassViewFrame:(CGRect)frame
                              effectStytle:(UIBlurEffectStyle)stytle
                               effectColor:(UIColor *)effectColor;

@end
