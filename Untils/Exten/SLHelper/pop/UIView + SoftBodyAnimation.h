//
//  UIView + SoftBodyAnimation.h
//  ButtonAnimation
//
//  Created by show on 2017/6/13.
//  Copyright © 2017年 show. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SoftBodyAnimation)
#pragma private property


/*
 是否开启软体动画
 */
@property(nonatomic,assign) BOOL isPlayBodyAnimation;
/*
 是否正在缩放X轴
 */
@property(nonatomic,assign) BOOL isAnimationZoomX;

@property(nonatomic,assign) BOOL isScaleXY;

/*
 开始软体动画
 */
-(void)startSoftBodyAnimation;

/*
 停止软体动画
 */
-(void)stopSoftBodyAnimation;

-(void)touchDownBodyAnimation;

//正常等比放大
-(void)startScaleMotion;
-(void)stopScaleMotion;

// =======================================================
// 按钮跳动动效
// =======================================================
- (void)startSoftBodyAnimationWithView:(UIView *)view;


@end

