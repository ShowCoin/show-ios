//
//  SLBottomAimationView.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/5/22.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabbarController.h"
#import "SLLiveBottomView.h"



@interface SlCenterView:UIView

@property(nonatomic,strong)UIImageView *centerImageView;

@end

@interface SLBottomAimationView : UIView

@property(nonatomic,strong)UIView *barView;

@property(nonatomic,strong)SLLiveBottomView *liveView;
@property(nonatomic,strong)UILabel *homelabel;
@property(nonatomic,strong)UIView *userCenterLabel;

@property(nonatomic,strong)SlCenterView *centerView;

@property(nonatomic,strong)UIView *chatView;
@property(nonatomic,strong)UIView *shareView;
@property(nonatomic,strong)UIView *zanView;

@property (nonatomic, assign) BOOL isShowHeader;


+(SLBottomAimationView *)showInView:(UIView *)view;

-(void)hideTabbarAnimation;

+(instancetype)shared;

+(BOOL)isAnimatioing;

+(BOOL)isShowingTabbar;

@end
