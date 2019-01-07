//
//  UIView+JKConstraints.h
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKConstraints)
- (NSLayoutConstraint *)jk_constraintForAttribute:(NSLayoutAttribute)attribute;

//左边的约束
- (NSLayoutConstraint *)jk_leftConstraint;
//右边的约束
- (NSLayoutConstraint *)jk_rightConstraint;
//顶上的约束
- (NSLayoutConstraint *)jk_topConstraint;
//底部的约束
- (NSLayoutConstraint *)jk_bottomConstraint;

//头部的约束
- (NSLayoutConstraint *)jk_leadingConstraint;
//落后的约束
- (NSLayoutConstraint *)jk_trailingConstraint;
//宽度的约束
- (NSLayoutConstraint *)jk_widthConstraint;
//高度的约束
- (NSLayoutConstraint *)jk_heightConstraint;
//中间X的约束
- (NSLayoutConstraint *)jk_centerXConstraint;
//中间Y的约束
- (NSLayoutConstraint *)jk_centerYConstraint;
//基准line的约束
- (NSLayoutConstraint *)jk_baseLineConstraint;

@end
