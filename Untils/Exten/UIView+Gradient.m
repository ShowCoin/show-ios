//
//  UIView+Gradient.m
//  show
//
//  Created by show on 16/10/26.
//  Copyright © 2016年 Beijing show. All rights reserved.
//

#import "UIView+Gradient.h"

@implementation UIView (Gradient)

- (CAGradientLayer *)addGradientStart:(CGPoint)startPoint
                                  end:(CGPoint)endPoint
                               colors:(NSArray *)corlors
                            locations:(NSArray *)locations
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = startPoint;
    gradient.endPoint   = endPoint;
    gradient.frame = self.bounds;
    gradient.colors = corlors;
    gradient.locations = locations;
    
    [self.layer insertSublayer:gradient atIndex:0];
    return gradient;
}
- (void)removeGraDient {
    
    NSArray *array =  self.layer.sublayers;
    
    if ([[array objectAtIndex:0] isKindOfClass:[CAGradientLayer class]]) {
        
        CALayer *layer = [array objectAtIndex:0];
        
        [layer removeFromSuperlayer];
    }
    
}

@end
