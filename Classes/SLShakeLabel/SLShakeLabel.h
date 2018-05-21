//
//  SLShakeLabel.h
//  ShowLive
//
//  Created by showgx on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLShakeLabel;
@protocol SLShakeLabelDelegate <NSObject>

@required

-(void)shakeLabelFinish:(SLShakeLabel*)shakeLabel;


@end



@interface SLShakeLabel : UILabel

@property (nonatomic, weak) id<SLShakeLabelDelegate>delegate;

// 动画时间
@property (nonatomic,assign) NSTimeInterval duration;

// 描边颜色
@property (nonatomic,strong) UIColor *borderColor;

- (void)startAnimWithDuration:(NSTimeInterval)duration;

@end
