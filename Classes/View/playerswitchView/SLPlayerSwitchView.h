//
//  SLPlayerSwitchView.h
//  ShowLive
//
//  Created by showgx on 2018/5/1.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLLiveListModel.h"
@protocol SLPlayerSwitchViewDelegate <NSObject>
@optional

//翻页
-(void)turnPage;

//切换直播间
-(void)switchRoom:(NSMutableArray*)switchArray
        liveModel:(SLLiveListModel*)model;

-(void)touchBegin;

@end
@interface SLPlayerSwitchView :UIScrollView

@property (nonatomic,strong)  UIView           *currentView;

//协议
@property(nonatomic,weak)id<SLPlayerSwitchViewDelegate>protocol;

//初始化方法
- (instancetype)initWithSwitchArray:(NSMutableArray*)switchArray;

@end
