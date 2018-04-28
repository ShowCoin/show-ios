//
//  SLPlayerViewController.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/9.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "BaseViewController.h"
#import "SLLiveBaseViewController.h"
#import "SLPlayerManager.h"
#import "SLLiveListModel.h"
@interface SLPlayerViewController : SLLiveBaseViewController

@property(nonatomic,strong) SLPlayerManager * playerManager;

@property (nonatomic,assign) BOOL isAudioInterrupt; //音频标志

@property(nonatomic,strong)SLLiveListModel * listModel; //列表数据源

//离开直播间 需要处理的事情都在这个函数里
-(void)leavaRoom;

@end
