//
//  SLVolumeView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/28.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLVolumeView : UIView

@property(nonatomic,strong)UIView * fillView;

//设置最大值和当前值
- (void)setProgressMaxValue:(float)maxValue
               CurrentValue:(float)currentValue;
@end
