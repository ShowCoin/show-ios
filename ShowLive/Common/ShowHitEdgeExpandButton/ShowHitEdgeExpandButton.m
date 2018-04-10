//
//  ShowHitEdgeExpandButton.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHitEdgeExpandButton.h"
#import <objc/runtime.h>

static const NSString *kExpandHitEdgeKey = @"kExpandHitEdgeKey";

@implementation ShowHitEdgeExpandButton
@dynamic expandHitEdge;

#pragma mark - Property
- (UIEdgeInsets)expandHitEdge
{
    NSValue *value = objc_getAssociatedObject(self, &kExpandHitEdgeKey);
    if(value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (void)setExpandHitEdge:(UIEdgeInsets)expandHitEdge
{
    NSValue *value = [NSValue value:&expandHitEdge withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &kExpandHitEdgeKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - PointInside
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(UIEdgeInsetsEqualToEdgeInsets(self.expandHitEdge, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    CGRect originalBounds = self.bounds;
    UIEdgeInsets expandInsets = self.expandHitEdge;
    CGFloat x = originalBounds.origin.x - expandInsets.left;
    CGFloat y = originalBounds.origin.y - expandInsets.top;
    CGFloat width = originalBounds.size.width + expandInsets.left + expandInsets.right;
    CGFloat height = originalBounds.size.height + expandInsets.top + expandInsets.bottom;
    CGRect hitFrame = CGRectMake(x, y, width, height);
    //    NSLog(@"hitFrame:%@,\noriginalBounds: %@", NSStringFromCGRect(hitFrame), NSStringFromCGRect(originalBounds));
    return CGRectContainsPoint(hitFrame, point);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
