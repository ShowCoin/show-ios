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
            
    }
}
@end
