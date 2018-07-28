//show
#import "UIView+Additions.h"

//static   UIInterfaceOrientation TTInterfaceOrientation() {
//    return [UIApplication sharedApplication].statusBarOrientation;
//}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Additions.
 */

@implementation UIView (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}




@end
