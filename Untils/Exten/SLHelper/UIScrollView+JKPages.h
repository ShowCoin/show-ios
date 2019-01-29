//
//  UIScrollView+JKPages.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (JKPages)

//总的页数
- (NSInteger)jk_pages;
//当前的野鼠
- (NSInteger)jk_currentPage;
//scrollPercent
- (CGFloat)jk_scrollPercent;
//page的Y坐标
- (CGFloat)jk_pagesY;
//page的X坐标


- (CGFloat)jk_pagesX;

//当前页面的Y
- (CGFloat)jk_currentPageY;
//当前页面的X
- (CGFloat)jk_currentPageX;

//设置页面的Y
- (void)jk_setPageY:(CGFloat)page;
//设置页面的X
- (void)jk_setPageX:(CGFloat)page;
//设置页面的Y 动画
- (void)jk_setPageY:(CGFloat)page animated:(BOOL)animated;
//设置页面的X 动画
- (void)jk_setPageX:(CGFloat)page animated:(BOOL)animated;
@end
