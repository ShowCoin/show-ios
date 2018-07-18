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
     
    }
}
@end
