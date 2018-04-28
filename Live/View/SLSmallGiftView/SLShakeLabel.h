//
//  SLShakeLabel.h
//  ShowLive
//
//  Created by gongxin on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShakeFinish)(BOOL finished); // 礼物数字跳动动画结束回调
@interface SLShakeLabel : UILabel


@property (nonatomic, copy) ShakeFinish finish; // 礼物数字跳动动画结束回调

// 动画时间
@property (nonatomic,assign) NSTimeInterval duration;

// 描边颜色
@property (nonatomic,strong) UIColor *borderColor;

- (void)startAnimWithDuration:(NSTimeInterval)duration;

@end
