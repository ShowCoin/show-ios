//
//  SLShakeLabel.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/17.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLShakeLabel.h"

@implementation SLShakeLabel
- (void)startAnimWithDuration:(NSTimeInterval)duration {
    
    
    self.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.6
                        options:UIViewAnimationOptionAllowUserInteraction animations:^{
                            
                            //                            self.springView.center = targetCenter;
                            self.transform = CGAffineTransformMakeScale(1, 1);
                            
                        } completion:^(BOOL finished) {
                            
                            if (finished) {
                                
                                self.finish(finished);
                            }
                            
                        }];
}

//  重写 drawTextInRect 文字描边效果
- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 3);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = _borderColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
    
}

@end
