//
//  SLGiftKeyboardView.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLBaseModalView.h"
#import "SLReceivedGiftModel.h"
#import "SLLiveListModel.h"
#import "SLGiftListManager.h"
@protocol SLGiftKeyBoardSendDelegate <NSObject>

@required
/**
 礼物送出成功的代理方法
 
 @param model 展示礼物信息的model
 */
- (void)sendOutGiftSuccess:(SLReceivedGiftModel *)model;


@end
@interface SLGiftKeyboardView :SLBaseModalView

@property (nonatomic, weak) id<SLGiftKeyBoardSendDelegate>delegate;

@property(nonatomic,strong)SLLiveListModel * liveModel;

@end
