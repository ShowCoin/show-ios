//
//  CAAnimation+EasingEquations.h
//  OKEasingFunctions
//
//  Created by Bryan Oltman on 12/18/12.
//  Copyright (c) 2012 Bryan Oltman. All rights reserved.
//  https://github.com/bryanoltman/CAAnimation-EasingEquations


//  A category on CAAnimation that provides a number of easing equations to add some zazz to your app (with examples!)

#import <QuartzCore/QuartzCore.h>

//动画类型相关
typedef NS_ENUM(NSInteger, CAAnimationEasingFunction) {
    CAAnimationEasingFunctionLinear,
    
    CAAnimationEasingFunctionEaseInQuad,
    CAAnimationEasingFunctionEaseOutQuad,
    CAAnimationEasingFunctionEaseInOutQuad,
    
    CAAnimationEasingFunctionEaseInCubic,
    CAAnimationEasingFunctionEaseOutCubic,
    CAAnimationEasingFunctionEaseInOutCubic,
    
    CAAnimationEasingFunctionEaseInQuartic,
    CAAnimationEasingFunctionEaseOutQuartic,
    CAAnimationEasingFunctionEaseInOutQuartic,

    CAAnimationEasingFunctionEaseInQuintic,
    CAAnimationEasingFunctionEaseOutQuintic,
    CAAnimationEasingFunctionEaseInOutQuintic,

    CAAnimationEasingFunctionEaseInSine,
    CAAnimationEasingFunctionEaseOutSine,
    CAAnimationEasingFunctionEaseInOutSine,

    CAAnimationEasingFunctionEaseInExponential,
    CAAnimationEasingFunctionEaseOutExponential,
    CAAnimationEasingFunctionEaseInOutExponential,

    CAAnimationEasingFunctionEaseInCircular,
    CAAnimationEasingFunctionEaseOutCircular,
    CAAnimationEasingFunctionEaseInOutCircular,

    CAAnimationEasingFunctionEaseInElastic,
    CAAnimationEasingFunctionEaseOutElastic,
    CAAnimationEasingFunctionEaseInOutElastic,
    
    CAAnimationEasingFunctionEaseInBack,
    CAAnimationEasingFunctionEaseOutBack,
    CAAnimationEasingFunctionEaseInOutBack,

    CAAnimationEasingFunctionEaseInBounce,
    CAAnimationEasingFunctionEaseOutBounce,
    CAAnimationEasingFunctionEaseInOutBounce
};

@interface CAAnimation (JKEasingEquations)
//transform动画
+ (CAKeyframeAnimation*)jk_transformAnimationWithDuration:(CGFloat)duration
                                                  from:(CATransform3D)startValue
                                                    to:(CATransform3D)endValue
                                        easingFunction:(CAAnimationEasingFunction)easingFunction;

//添加layer的动画
+ (void)jk_addAnimationToLayer:(CALayer *)layer
                   duration:(CGFloat)duration
                  transform:(CATransform3D)transform
             easingFunction:(CAAnimationEasingFunction)easingFunction;

//添加消失的动画
+ (CAKeyframeAnimation*)jk_animationWithKeyPath:(NSString *)keyPath
                                    duration:(CGFloat)duration
                                        from:(CGFloat)startValue
                                          to:(CGFloat)endValue
                              easingFunction:(CAAnimationEasingFunction)easingFunction;

//添加layer层的动画，keypath
+ (void)jk_addAnimationToLayer:(CALayer *)layer
                withKeyPath:(NSString *)keyPath
                   duration:(CGFloat)duration
                         to:(CGFloat)endValue
             easingFunction:(CAAnimationEasingFunction)easingFunction;


+ (void)jk_addAnimationToLayer:(CALayer *)layer
                withKeyPath:(NSString *)keyPath
                   duration:(CGFloat)duration
                       from:(CGFloat)startValue
                         to:(CGFloat)endValue
             easingFunction:(CAAnimationEasingFunction)easingFunction;
@end
