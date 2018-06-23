//
//  UIView+JKConstraints.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
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

- (NSLayoutConstraint *)jk_leadingConstraint;
- (NSLayoutConstraint *)jk_trailingConstraint;
- (NSLayoutConstraint *)jk_widthConstraint;
- (NSLayoutConstraint *)jk_heightConstraint;
- (NSLayoutConstraint *)jk_centerXConstraint;
- (NSLayoutConstraint *)jk_centerYConstraint;
- (NSLayoutConstraint *)jk_baseLineConstraint;

@end
