//
//  UIView+JKFrame.m
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+JKFrame.h"

@implementation UIView (JKFrame)
#pragma mark - Shortcuts for the coords

//顶
- (CGFloat)jk_top
{
    return self.frame.origin.y;
}
//设置顶
- (void)setJk_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
//右
- (CGFloat)jk_right
{
    return self.frame.origin.x + self.frame.size.width;
}
//设置右
- (void)setJk_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}
//底
- (CGFloat)jk_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
//设置底
- (void)setJk_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}
//左
- (CGFloat)jk_left
{
    return self.frame.origin.x;
}
//设置左
- (void)setJk_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)jk_width
{
    return self.frame.size.width;
}

- (void)setJk_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)jk_height
{
    return self.frame.size.height;
}

- (void)setJk_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)jk_origin {
    return self.frame.origin;
}

- (void)setJk_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)jk_size {
    return self.frame.size;
}

- (void)setJk_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)jk_centerX {
    return self.center.x;
}

- (void)setJk_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)jk_centerY {
    return self.center.y;
}

- (void)setJk_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end
