//
//  UIView + SoftBodyAnimation.m
//  ButtonAnimation
//
//  Created by show on 2017/6/13.
//  Copyright © 2017年 showgx. All rights reserved.
//
#import <objc/runtime.h>
#import "UIView + SoftBodyAnimation.h"

static const char *kisPlayBodyAnimation = "kisPlayBodyAnimation";
static const char *kisAnimationZoomX = "kisAnimationZoomX";
static const char *kisScaleXY = "kisScaleXY";

@implementation UIView(SoftBodyAnimation)

-(void)startSoftBodyAnimation{
    
    self.isPlayBodyAnimation = YES;
    self.isAnimationZoomX = YES;
    [self softBodyMotion];
}

-(void)softBodyMotion{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction  animations:^{
        if(weakSelf.isAnimationZoomX){
            weakSelf.transform = CGAffineTransformMakeScale(1.04, 0.96);
        }else{
            weakSelf.transform = CGAffineTransformMakeScale(0.96, 1.04);
        }
        
    } completion:^(BOOL finished) {
        if(finished){
            if(weakSelf.isPlayBodyAnimation == NO){
                return;
            }
            weakSelf.isAnimationZoomX = !self.isAnimationZoomX;
            [weakSelf softBodyMotion];
        }
        
    }];
}
-(void)startScaleMotion{
    self.isScaleXY  = YES;
    [self scaleMotion];
}
-(void)scaleMotion{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction| UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat  animations:^{
        if(weakSelf.isScaleXY == NO){
            return;
        }
        weakSelf.transform = CGAffineTransformMakeScale(1.03, 1.03);
    } completion:^(BOOL finished) {
    }];
}
-(void)stopScaleMotion{
    self.isScaleXY  = NO;
}

-(void)stopSoftBodyAnimation{
    self.isPlayBodyAnimation = NO;
}


-(void)setIsPlayBodyAnimation:(BOOL)isPlayBodyAnimation{
    objc_setAssociatedObject(self, kisPlayBodyAnimation, [NSNumber numberWithBool:isPlayBodyAnimation], OBJC_ASSOCIATION_ASSIGN);
    
}
-(BOOL)isPlayBodyAnimation{
    NSNumber * num = (NSNumber*) objc_getAssociatedObject(self, kisPlayBodyAnimation);
    return num.boolValue;
}

-(void)setIsAnimationZoomX:(BOOL)isAnimationZoomX{
    objc_setAssociatedObject(self, kisAnimationZoomX, [NSNumber numberWithBool:isAnimationZoomX], OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)isAnimationZoomX{
 
}

-(void)setIsScaleXY:(BOOL)isScaleXY{
    objc_setAssociatedObject(self, kisScaleXY, [NSNumber numberWithBool:isScaleXY], OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)isScaleXY{
    NSNumber * num = (NSNumber *)objc_getAssociatedObject(self, kisScaleXY);
    return num.boolValue;
    
}

-(void)touchDownBodyAnimation{
    [self stopSoftBodyAnimation];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.15 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:.1 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        if(finished){
            [weakSelf touchDownBodyAnimationFinish];
        }
    }];
}

-(void)touchDownBodyAnimationFinish{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.15 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:.1 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        if(finished){
            
        }
    }];
}


- (void)startSoftBodyAnimationWithView:(UIView *)view {
    [self startSoftBodyAnimationWithView:view isZoom:YES];
}

- (void)startSoftBodyAnimationWithView:(UIView *)view isZoom:(BOOL)isZoom {
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction  animations:^{
        if(isZoom){
            view.transform = CGAffineTransformMakeScale(1.04, 0.96);
        }else{
            view.transform = CGAffineTransformMakeScale(0.96, 1.04);
        }
    } completion:^(BOOL finished) {
        if(finished){
            [self startSoftBodyAnimationWithView:view isZoom:!isZoom];
        }
    }];
}
@end
