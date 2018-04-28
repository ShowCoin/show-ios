//
//  SLLiveBaseViewController.h
//  ShowLive
//
//  Created by gongxin on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//
//

#import "BaseViewController.h"
#import "SLLiveRightView.h"
#import "SLGiftKeyboardView.h"
#import "SLControlView.h"
#import "SLLiveListModel.h"
#import "SLLiveStartModel.h"
#import "SLShoutModel.h"
#import "SLLiveChatVC.h"
#import "SLLiveBottomView.h"

#import "SLBarrageView.h"
@interface SLLiveBaseViewController : BaseViewController

@property(nonatomic,strong)UIButton * backButton;

@property(nonatomic,strong)SLLiveRightView * rightView;

@property(nonatomic,strong)SLLiveBottomView * bottomView;

@property(nonatomic,strong)SLGiftKeyboardView * keyboardView;

@property(nonatomic,strong)SLBarrageView * barrageView;

//直播间类型
@property(nonatomic,assign)SLLiveContollerType controllerType;

//清屏视图
@property(nonatomic,strong)SLControlView * controlView;

@property(nonatomic,strong)ShowUserModel * masterModel;

@property(nonatomic,strong)SLLiveChatVC *privateChatVC;

//页面配置
-(void)initConfig;

//添加子视图
-(void)addChildView;

//移除子视图
-(void)removeChildView;

//添加在window上面的视图需要隐藏
-(void)disMissView;

//发送弹幕
-(void)sendBarrage:(NSString*)content;

//清屏
-(void)clearScreen;

//礼物动画
- (void)giftAnimation:(SLReceivedGiftModel *)model;

//弹幕动画
-(void)danmu:(SLShoutModel*)model;

//记录两个全局参数
-(void)setliveId:(NSString*)liveId
        anchorId:(NSString*)anchorId;
-(void)selectBottomViewAtIndex:(NSInteger)index ;

@end
