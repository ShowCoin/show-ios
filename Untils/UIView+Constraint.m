//
//  UIView+Constraint.m
//  showgx
//
//  Created by showgx on 16/8/14.
//  Copyright © 2016年 showgx. All rights reserved.
//

#import "UIView+Constraint.h"

@implementation UIView (Constraint)

- (void)constraintStickyWithView:(UIView*)view orientation:(JQconstraintType)orientation offset:(NSArray*)offsetArray
{
    float height = self.bounds.size.height / 2.0;
    float width = self.bounds.size.width / 2.0;
    
    
    switch (orientation) {
            //停靠中心
            //
            //     ---------
            //     |       |
            //     |   o   |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeCenter:
            self.center = CGPointMake(view.center.x + [offsetArray[0] integerValue], view.center.y + [offsetArray[0] integerValue]);
            break;
            
            //停靠内边-右边
            //
            //     ---------
            //     |       |
            //     |      o|
            //     |       |
            //     ---------
            //
        case constraintStickyTypeInsideRightEdge:{
            self.center = CGPointMake(CGRectGetMaxX(view.frame) - width - [offsetArray[0] integerValue], view.center.y + [offsetArray[1] integerValue]) ;
        }
            break;
            
            //停靠内边-上边
            //
            //     ---------
            //     |   o   |
            //     |       |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeInsideTopEdge:{
            self.center = CGPointMake(view.center.x + [offsetArray[1] integerValue], CGRectGetMinY(view.frame) + height + [offsetArray[0] integerValue]);
        }
            break;
            
            //停靠内边-左边
            //
            //     ---------
            //     |       |
            //     |o      |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeInsideLeftEdge:{
            self.center = CGPointMake(CGRectGetMinX(view.frame) + width + [offsetArray[0] integerValue], view.center.y + [offsetArray[1] integerValue]) ;
        }
            break;
            
            //停靠内边-下边
            //
            //     ---------
            //     |       |
            //     |       |
            //     |   o   |
            //     ---------
            //
        case constraintStickyTypeInsideBottomEdge:{
            self.center = CGPointMake(view.center.x + [offsetArray[1] integerValue],
                                      CGRectGetMaxY(view.frame) - height - [offsetArray[0] integerValue]);
        }
            break;
            
            //停靠外边-右边
            //
            //     ---------
            //     |       |
            //     |       |o
            //     |       |
            //     ---------
            //
        case constraintStickyTypeOutsideRightEdge:{
            self.center = CGPointMake(CGRectGetMaxX(view.frame) + width + [offsetArray[0] integerValue], view.center.y + [offsetArray[1] integerValue]) ;
        }
            break;
            //停靠外边-上边
            //         o
            //     ---------
            //     |       |
            //     |       |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeOutsideTopEdge:{
            self.center = CGPointMake(view.center.x + [offsetArray[1] integerValue], CGRectGetMinY(view.frame) - height - [offsetArray[0] integerValue]);
        }
            break;
            //停靠外边-左边
            //
            //     ---------
            //     |       |
            //    o|       |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeOutsideLeftEdge:{
            self.center = CGPointMake(CGRectGetMinX(view.frame) - width - [offsetArray[0] integerValue], view.center.y + [offsetArray[1] integerValue]) ;
        }
            break;
            //停靠外边-下边
            //
            //     ---------
            //     |       |
            //     |       |
            //     |       |
            //     ---------
            //         o
        case constraintStickyTypeOutsideBottomEdge:{
            self.center = CGPointMake(view.center.x + [offsetArray[1] integerValue], CGRectGetMaxY(view.frame) + height + [offsetArray[0] integerValue]);
        }
            break;
            
            //停靠右上角a
            //
            //     ---------
            //     |      o|
            //     |       |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeUpperRightCorner:{
            self.center = CGPointMake(CGRectGetMaxX(view.frame) - width - [offsetArray[0] integerValue], CGRectGetMinY(view.frame) + height + [offsetArray[1] integerValue]);
        }
            break;

            //停靠左上角b
            //
            //     ---------
            //     |o      |
            //     |       |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeUpperLeftCorner:{
            self.center = CGPointMake(CGRectGetMinX(view.frame) + width + [offsetArray[0] integerValue], CGRectGetMinY(view.frame) + height + [offsetArray[1] integerValue]);
        }
            break;
            
            //停靠左下角c
            //
            //     ---------
            //     |       |
            //     |       |
            //     |o      |
            //     ---------
            //
        case constraintStickyTypeLowerLeftCorner:{
            self.center = CGPointMake(CGRectGetMinX(view.frame) + width + [offsetArray[0] integerValue], CGRectGetMaxY(view.frame) - height - [offsetArray[1] integerValue]);
        }
            break;
            
            //停靠右下角d
            //
            //     ---------
            //     |       |
            //     |       |
            //     |      o|
            //     ---------
            //
        case constraintStickyTypeLowerRightCorner:{
            self.center = CGPointMake(CGRectGetMaxX(view.frame) - width - [offsetArray[0] integerValue], CGRectGetMaxY(view.frame) - height - [offsetArray[1] integerValue]);
        }
            break;
            
            //停靠右外边-吸顶
            //
            //     _________
            //     |       |o
            //     |       |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeOutsideRightEdgeTop:{
            self.center = CGPointMake(CGRectGetMaxX(view.frame) + width + [offsetArray[0] integerValue], CGRectGetMinY(view.frame) + height + [offsetArray[1] integerValue]);
        }
            break;
            
            //停靠右外边-吸底
            //
            //     _________
            //     |       |
            //     |       |
            //     |       |o
            //     ---------
            //
        case constraintStickyTypeOutsideRightEdgeBottom:{
            self.center = CGPointMake(CGRectGetMaxX(view.frame) + width + [offsetArray[0] integerValue], CGRectGetMaxY(view.frame) - height - [offsetArray[1] integerValue]);
        }
            break;
            
            //停靠外顶边-吸左边
            //     o
            //     ---------
            //     |       |
            //     |       |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeOutsideUpperEdgeLeft:{
            self.center = CGPointMake(CGRectGetMinX(view.frame) + width + [offsetArray[1] integerValue], CGRectGetMinY(view.frame) - height - [offsetArray[0] integerValue]);
        }
            break;
            
            //停靠外顶边-吸右边
            //             o
            //     ---------
            //     |       |
            //     |       |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeOutsideUpperEdgeRight:{
            self.center = CGPointMake(CGRectGetMaxX(view.frame) - width + [offsetArray[1] integerValue], CGRectGetMinY(view.frame) - height - [offsetArray[0] integerValue]);
        }
            break;
            
            //停靠外左边-吸顶
            //
            //     _________
            //    o|       |
            //     |       |
            //     |       |
            //     ---------
            //
        case constraintStickyTypeOutsideLeftEdgeTop:{
            self.center = CGPointMake(CGRectGetMinX(view.frame) - width - [offsetArray[0] integerValue], CGRectGetMinY(view.frame) + height + [offsetArray[1] integerValue]);
        }
            break;
            
            //停靠外左边-吸底
            //
            //     ---------
            //     |       |
            //     |       |
            //    o|       |
            //     ---------
            //
        case constraintStickyTypeOutsideLeftEdgeBottom:{
            self.center = CGPointMake(CGRectGetMinX(view.frame) - width - [offsetArray[0] integerValue], CGRectGetMaxY(view.frame) - height + [offsetArray[1] integerValue]);
        }
            break;
            
            //停靠外底边-吸左边
            //
            //     ---------
            //     |       |
            //     |       |
            //     |       |
            //     ---------
            //     o
        case constraintStickyTypeOutsideLowerEdgeLeft:{
            self.center = CGPointMake(CGRectGetMinX(view.frame) + width + [offsetArray[1] integerValue], CGRectGetMaxY(view.frame) + height + [offsetArray[0] integerValue]);
        }
            break;
            
            //停靠外底边-吸左边
            //
            //     ---------
            //     |       |
            //     |       |
            //     |       |
            //     ---------
            //             o
        case constraintStickyTypeOutsideLowerEdgeRight:{
            self.center = CGPointMake(CGRectGetMaxX(view.frame) - width + [offsetArray[1] integerValue], CGRectGetMaxY(view.frame) + height + [offsetArray[0] integerValue]);
        }
            break;
            
        default:
            break;
    }
}

- (void)constraint2View:(NSArray<UIView *>*)views constraintType:(JQconstraint2ViewType)type offset:(NSArray*)offsetArray
{
    switch (type) {
        case constraint2ViewTypeDivideDistance:{
            CGPoint fistViewCenter = views[0].center;
            CGPoint secondViewCenter = views[1].center;
            
            self.center = CGPointMake((fistViewCenter.x + secondViewCenter.x) / 2.0 + [offsetArray[0] integerValue],
                                      (fistViewCenter.y + secondViewCenter.y) / 2.0 + [offsetArray[1] integerValue]);
        }
            break;
            
        case constraint2ViewTypeLowerEdge:{
            CGFloat lowerEdgeMaxY = CGRectGetMaxY(views[1].frame);
            NSLog(@"%f", lowerEdgeMaxY);
            self.center = CGPointMake(views[0].center.x + [offsetArray[0] integerValue],
                                      views[0].center.y + (lowerEdgeMaxY - views[0].center.y) / 2.0 + [offsetArray[1] integerValue]);
            
            NSLog(@"%@", NSStringFromCGPoint(self.center));
            
        }
            break;
            
        case constraint2ViewTypeUpperEdge:{
            CGFloat upperEdgeMinY = CGRectGetMaxY(views[1].frame);
            self.center = CGPointMake(views[0].center.x + [offsetArray[0] integerValue],
                                      views[0].center.y - (upperEdgeMinY - views[0].center.y) / 2.0);
            
        }
            break;
            
        case constraint2ViewTypeLeftEdge:{
            
        }
            break;
            
        case constraint2ViewTypeRightEdge:{
            
        }
            break;
        default:
            break;
    }
}
@end
