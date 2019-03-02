//
//  UIView+UIView_Additional.h
//  I500user
//
//  Created by shanWu on 15/4/9.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additional)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

@property (assign, nonatomic) CGFloat   backupAlpha;
@property (assign, nonatomic) CGPoint   backupCenter;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 * Calculates the offset of this view from another view in screen coordinates.
 *
 * otherView should be a parent view of this view.
 */
- (CGPoint)offsetFromView:(UIView*)otherView;

/**
 * @brief 从子视图往上查找父视图，直至找到UITableViewCell返回
 * @return 返回一个UITableViewCell对象，如果没有则返回nil
 */
- (UITableViewCell *)tableViewCell;

/**
 *  从子视图往上查找父视图，直至找到UITableView返回
 *
 *  @return UITableView对象，若是没有则返回nil
 */
- (UITableView *)tableView;

/**
 *@breif 动画的显示阴影
 *@note  原理是在当前视图的layer层改变view的背景色
 */
- (void)animatedShowShadow;
- (void)addShadowWithColor:(UIColor *)color radius:(float)radius;
-(void)addDefaultShadow1;
/**
 *  layer层改变某个背景颜色到另外一种背景颜色
 *
 *  @param color   源背景色
 *  @param toColor 目标背景色
 */
- (void)backgroundColorAnimationOnlayerColor:(UIColor *)color toColor:(UIColor *)toColor;

@property (nonatomic, copy) NSObject *attachment; //在视图中附加一个绑定数据
- (void)createMaskWithDuration:(NSTimeInterval)duration;
- (void)addDefaultShadow;
- (void)addShadow;
-(void)addEffect:(UIBlurEffectStyle)type;
-(void)addFullEffect:(UIBlurEffectStyle)type;
-(void)layerWithColor:(UIColor *)color width:(CGFloat)width;

@end

