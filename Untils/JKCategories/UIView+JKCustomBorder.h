//
//  UIView+CustomBorder.h
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//
/**
 * 视图添加边框
 */

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, JKExcludePoint) {
    JKExcludeStartPoint = 1 << 0,
    JKExcludeEndPoint = 1 << 1,
    JKExcludeAllPoint = ~0UL
};


@interface UIView (JKCustomBorder)

//添加顶部边框
- (void)jk_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
//添加左边边框
- (void)jk_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
//添加底部边框
- (void)jk_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
//添加右边的边框
- (void)jk_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;

//移除顶部边框
- (void)jk_removeTopBorder;
//移除左边的边框
- (void)jk_removeLeftBorder;
//移除底部边框
- (void)jk_removeBottomBorder;
//移除右边的边框
- (void)jk_removeRightBorder;


- (void)jk_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge;
- (void)jk_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge;
- (void)jk_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge;
- (void)jk_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(JKExcludePoint)edge;
@end
