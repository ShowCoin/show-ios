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



@end


@interface UIView (AppliedAffineTransform)

@property (nonatomic, readonly) CGRect frameAppliedAffineTransform;

@property (nonatomic, readonly) CGFloat widthAppliedAffineTransform;

@property (nonatomic, readonly) CGFloat heightAppliedAffineTransform;

@end
