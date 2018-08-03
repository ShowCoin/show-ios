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
