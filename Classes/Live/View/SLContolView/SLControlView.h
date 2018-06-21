//
//  SLControlView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLControlView : UIView

// 是广场的直播 default NO
@property (nonatomic, assign) BOOL isHome;

@property (nonatomic, strong)CAGradientLayer *gradiedtLayer;

-(void)removeMask;
@end
