//
//  SLShoutView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/27.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLShoutView.h"
#import "SLHeadPortrait.h"

@interface SLShoutView()
{
    CALayer *Icon;
    UILabel *nikenameLable;
    
    UILabel *words;
    SLShoutModel *shoutModel;
}

@end

@implementation SLShoutView

- (id)initWithModel:(SLShoutModel*)model
{
    shoutModel = model;
    //计算文字长度
    CGRect rect =CGRectMake(0, 0, model.text.length*8 + 33 + 1 + 6, 33);
  
    self = [super initWithFrame:rect];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
        
    }
    
    return self;
    
}


- (void)setupUI
{
    float height = self.frame.size.height;

    CAShapeLayer *iconMask = [CAShapeLayer layer];
    UIBezierPath *iconMaskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, height, height) cornerRadius:self.frame.size.height / 2.0];
    iconMask.path = iconMaskPath.CGPath;
    
    Icon = [CALayer layer];
    Icon.frame = CGRectMake(0, 0, height, height);
    Icon.backgroundColor = [UIColor grayColor].CGColor;
    
    Icon.mask = iconMask;

    CAShapeLayer *strokeMask = [CAShapeLayer layer];
    strokeMask.path = iconMaskPath.CGPath;
    
    CAShapeLayer *strokeLayer = [CAShapeLayer layer];
    strokeLayer.path = iconMaskPath.CGPath;
    strokeLayer.lineWidth = 2;
    strokeLayer.strokeColor = [UIColor whiteColor].CGColor;
    strokeLayer.mask = strokeMask;
    strokeLayer.fillColor = [UIColor clearColor].CGColor;
  
    SLHeadPortrait *tempImage = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(1, 1, 32, 32)];
    tempImage.userInteractionEnabled = YES;
    [tempImage setRoundStyle:YES imageUrl:shoutModel.avatar imageHeight:32 vip:NO attestation:NO];
    
    [self addSubview:tempImage];
    
    //用户名lable
    CGRect nicknameSize = CGRectMake(33, 0, shoutModel.nickname.length*6 + 33 + 1 + 6, 16);
    
    NSShadow * shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
    shadow.shadowBlurRadius = 1.5f;
    shadow.shadowOffset = CGSizeMake(0.3, 1);
    
    nikenameLable = [[UILabel alloc] initWithFrame:nicknameSize];
    nikenameLable.font = [UIFont systemFontOfSize:12];
    nikenameLable.textColor = [UIColor whiteColor];
    
    [nikenameLable setValue:shadow forKey:@"shadow"];

    nikenameLable.text = shoutModel.nickname;
    [self addSubview:nikenameLable];
    
  
    words = [[UILabel alloc] initWithFrame:CGRectMake(30,16, shoutModel.text.length*6 + 33 + 1 + 6, 16)];
    words.font =[UIFont systemFontOfSize:12];
    words.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    words.textColor = [UIColor whiteColor];
    words.text = [NSString stringWithFormat:@"  %@",shoutModel.text];
    words.layer.cornerRadius = 8;
    words.layer.masksToBounds = YES;
    CGFloat y = words.origin.y-.5;
    words.mj_y = y;
    
    [self addSubview:words];
    
    
}



- (void)animationWithDuration:(NSTimeInterval)duraiton
{
    self.center = CGPointMake([self superview].frame.size.width + self.frame.size.width / 2, self.center.y);
    
    CGPoint targetCenter =  CGPointMake(-self.bounds.size.width / 2.0, self.center.y);
    [UIView animateWithDuration:duraiton delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.center = targetCenter;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(shoutAnimationFinished:)]) {
            [self.delegate shoutAnimationFinished:self];
        }
        
    }];
}

- (void)setInitialPos:(float)y
{
    self.center = CGPointMake([self superview].frame.size.width + self.frame.size.width / 2, y);
    
}
@end
