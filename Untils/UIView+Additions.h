//show

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define UIViewAutoresizingFlexibleAll (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)

@interface UIView (TTCategory)

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

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;



@end


@interface UIView (MarkBorderWithRandomColor)


/* 你懂得~ 造福人类
 */

- (void)markBorderWithColor:(UIColor *)color;

/*  mark view's layer border with random color
 */
- (void)markBorderWithRandomColor;

/*   mark view's layer border with random color Recursive meam mark the all view tree
 */
- (void)markBorderWithRandomColorRecursive;

- (void)markBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

@end


@interface UIView (AppliedAffineTransform)

@property (nonatomic, readonly) CGRect frameAppliedAffineTransform;

@property (nonatomic, readonly) CGFloat widthAppliedAffineTransform;

@property (nonatomic, readonly) CGFloat heightAppliedAffineTransform;

@end
