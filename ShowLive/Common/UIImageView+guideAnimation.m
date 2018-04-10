//
//  UIImageView+guideAnimation.m
//  ShowLive
//
//  Created by wl on 2017/10/17.
//  Copyright © 2017年 show. All rights reserved.
//

#import "UIImageView+guideAnimation.h"

@implementation UIImageView (guideAnimation)

- (instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame image:(NSString *)imgStr scale:(CGFloat)scale completion:(void (^)(void))completion {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:imgStr];
        self.alpha = 0;
        [superView addSubview:self];
        //动画
        [self startAnimationWithScale:scale direction:0 completion:completion];
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame image:(NSString *)imgStr scale:(CGFloat)scale direction:(NSInteger)direction completion:(void (^)(void))completion {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:imgStr];
        self.alpha = 0;
        [superView addSubview:self];
        //动画
        [self startAnimationWithScale:scale direction:direction completion:completion];
    }
    return self;
}

- (void)startAnimationWithScale:(CGFloat)scale direction:(NSInteger)direction completion:(void (^)(void))completion{
    if (!scale) {
        scale = 0.05;
    }
    CGRect initailFrame = self.frame;
    CGRect scaleFrame = CGRectZero;
    switch (direction) {//0从右往左，1中间向两边，2从左往右
        case 0:
            scaleFrame = CGRectMake(initailFrame.origin.x-initailFrame.size.width*scale,
                                    initailFrame.origin.y-initailFrame.size.height*scale*0.5,
                                    initailFrame.size.width*(1+scale),
                                    initailFrame.size.height*(1+scale));
            break;
        case 1:
            scaleFrame = CGRectMake(initailFrame.origin.x-initailFrame.size.width*scale*0.5,
                                    initailFrame.origin.y-initailFrame.size.height*scale*0.5,
                                    initailFrame.size.width*(1+scale),
                                    initailFrame.size.height*(1+scale));
            break;
        case 2:
            scaleFrame = CGRectMake(initailFrame.origin.x,
                                    initailFrame.origin.y-initailFrame.size.height*scale*0.5,
                                    initailFrame.size.width*(1+scale),
                                    initailFrame.size.height*(1+scale));
            break;
        default:
            break;
    }
    CGRect endFrame = CGRectZero;
    switch (direction) {//0从右往左，1中间向两边，2从左往右
        case 0:
            endFrame = CGRectMake(initailFrame.origin.x+initailFrame.size.width,
                                  initailFrame.origin.y+initailFrame.size.height*0.5,
                                  0, 0);
            break;
        case 1:
            endFrame = CGRectMake(initailFrame.origin.x+initailFrame.size.width*0.5,
                                  initailFrame.origin.y+initailFrame.size.height*0.5,
                                  0, 0);
            break;
        case 2:
            endFrame = CGRectMake(initailFrame.origin.x,
                                  initailFrame.origin.y+initailFrame.size.height*0.5,
                                  0, 0);
            break;
        default:
            break;
    }
    CGRect startFrame = CGRectZero;
    switch (direction) {//0从右往左，1中间向两边，2从左往右
        case 0:
            startFrame = CGRectMake(initailFrame.origin.x+initailFrame.size.width,
                                    initailFrame.origin.y+initailFrame.size.height*0.5,
                                    0, 0);
            break;
        case 1:
            startFrame = CGRectMake(initailFrame.origin.x+initailFrame.size.width*0.5,
                                    initailFrame.origin.y+initailFrame.size.height*0.5,
                                    0, 0);
            break;
        case 2:
            startFrame = CGRectMake(initailFrame.origin.x,
                                    initailFrame.origin.y+initailFrame.size.height*0.5,
                                    0, 0);
            break;
        default:
            break;
    }
    
    self.frame = startFrame;
    
    __weak typeof(self) weakSelf = self;
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:0 animations:^{
        weakSelf.frame = initailFrame;
        weakSelf.alpha = 0.99;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            weakSelf.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                weakSelf.frame = scaleFrame;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 animations:^{
                    weakSelf.frame = initailFrame;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:1 animations:^{
                        weakSelf.frame = scaleFrame;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:1 animations:^{
                            weakSelf.frame = initailFrame;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.2 animations:^{
                                weakSelf.frame = endFrame;
                                weakSelf.alpha = 0;
                            } completion:^(BOOL finished) {
                                [weakSelf removeFromSuperview];
                                if (completion) {
                                    completion();
                                }
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];
}


@end
