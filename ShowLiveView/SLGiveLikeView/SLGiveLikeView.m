//
//  SLGiveLikeView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLGiveLikeView.h"

@implementation SLGiveLikeView

-(id)init
{
    self=[super init];
    if (self) {
    }
    return self;
}


-(void)showAnimationOnView:(UIView*)view;
{

    UIImageView *applauseView = [[UIImageView alloc]initWithFrame:CGRectMake(view.width-45,view.height-(100+KTabbarSafeBottomMargin), [self getRandomImage].size.width, [self getRandomImage].size.height)];//增大y值可隐藏弹出动画
    [view addSubview:applauseView];
    
    UIImageView *applauseImage = [[UIImageView alloc]initWithImage:[self getRandomImage]];
    [applauseView addSubview:applauseImage];
    
    [self animation:applauseView applauseImage:applauseImage];
    
}

//动画
-(void)animation:(UIImageView *)applauseView
   applauseImage:(UIImageView*)applauseImage
{
    //    applauseView.image = img;
    CGFloat AnimH = 450/2; //动画路径高度,
    applauseView.transform = CGAffineTransformMakeScale(0, 0);
    applauseView.alpha = 0;
    
    //弹出动画
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        applauseView.transform = CGAffineTransformIdentity;
        applauseView.alpha = 0.9;
    } completion:NULL];
    
    //随机偏转角度
    NSInteger i = arc4random_uniform(2);
    NSInteger rotationDirection = 1- (2*i);// -1 OR 1,随机方向
    NSInteger rotationFraction = arc4random_uniform(10); //随机角度
    //图片在上升过程中旋转
    [UIView animateWithDuration:4 animations:^{
        
        applauseView.transform = CGAffineTransformMakeRotation(rotationDirection * M_PI/(4 + rotationFraction*0.2));
        applauseView.transform = CGAffineTransformMakeScale(2.2, 2.2);
        
    } completion:NULL];
    //动画路径
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:applauseView.center];
    
    //随机终点
    CGFloat ViewX = applauseView.center.x;
    CGFloat ViewY = applauseView.center.y;
    CGPoint endPoint = CGPointMake(ViewX + rotationDirection*10, ViewY - AnimH);
    
    //随机control点
    NSInteger j = arc4random_uniform(2);
    NSInteger travelDirection = 1- (2*j);//随机放向 -1 OR 1
    
    NSInteger m1 = ViewX + travelDirection*(arc4random_uniform(20) + 50);
    NSInteger n1 = ViewY - 60 + travelDirection*arc4random_uniform(20);
    NSInteger m2 = ViewX - travelDirection*(arc4random_uniform(20) + 50);
    NSInteger n2 = ViewY - 90 + travelDirection*arc4random_uniform(20);
    CGPoint controlPoint1 = CGPointMake(m1, n1);//control根据自己动画想要的效果做灵活的调整
    CGPoint controlPoint2 = CGPointMake(m2, n2);
    //根据贝塞尔曲线添加动画
    [heartTravelPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    //关键帧动画,实现整体图片位移
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    keyFrameAnimation.duration = 5 ;//往上飘动画时长,可控制速度
    [applauseView.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    
    //消失动画
    [UIView animateWithDuration:3 animations:^{
        applauseView.alpha = 0.0;
        
        applauseImage.width = 5.f;
        applauseImage.height = 5.f;

    } completion:^(BOOL finished) {
        [applauseView removeFromSuperview];
    }];
}

//获取随机图片
-(UIImage*)getRandomImage
{
    NSInteger index = arc4random_uniform(10)+1; //取随机图片
    NSString *imageName = [NSString stringWithFormat:@"sl_like_%ld",index];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

@end
