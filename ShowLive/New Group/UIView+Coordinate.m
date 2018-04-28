//
//  UIView+Extent.m
//  QinChat
//
//  Created by IFChat-iOS on 2017/2/22.
//  Copyright © 2017年 zero. All rights reserved.
//

#import "UIView+Coordinate.h"

@implementation UIView (Coordinate)

+ (CGPoint)convertPointTo0_1:(CGPoint)point{
    float editViewWidth = kScreenWidth;
    float editViewHeight = kScreenHeight;
    point.x = (point.x / editViewWidth - 0.5) * 2;
    point.y = (point.y / editViewHeight - 0.5) * 2;
    return point;
}

+ (CGPoint)convertPointToScreen:(CGPoint)point{
    float editViewWidth = kScreenWidth;
    float editViewHeight = kScreenHeight;
    point.x = (point.x / 2.0 + 0.5) * editViewWidth;
    point.y = (point.y / 2.0 + 0.5) * editViewHeight;
    return point;
}

@end
