//
//  UIImageView+guideAnimation.h
//  ShowLive
//
//  Created by wl on 2017/10/17.
//  Copyright © 2017年 show. All rights reserved.
//

@interface UIImageView (guideAnimation)
/**
 * 初始化
 * @frame 尺寸
 * @scale 动画缩放比例，默认0.05
 */
- (instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame image:(NSString *)imgStr scale:(CGFloat)scale completion:(void (^)(void))completion;

/**
 * 初始化
 * @frame 尺寸
 * @scale 动画缩放比例，默认0.05
 * @direction 动画方向，默认从右往左放大（0从右往左，1中间向两边，2从左往右）
 */
- (instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame image:(NSString *)imgStr scale:(CGFloat)scale direction:(NSInteger)direction completion:(void (^)(void))completion;

@end
