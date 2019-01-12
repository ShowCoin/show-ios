//
//  SLPrivateChatViewController+Business.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController.h"
#import "SLChatBusiness.h"

@interface SLPrivateChatViewController()
@property (nonatomic, strong) dispatch_queue_t messageWorkQueue;
@property (strong, nonatomic) SLChatBusiness *business;
/**
 标记加载更多的dataArray.count
 */
@property (assign, nonatomic) NSInteger priorCount;

/**
 自从进入，是否发送过消息，这个用来监控vip隐身状态下，已读回执的显示
 */
@property (assign, nonatomic) BOOL neverSendMessageSinceCome;
@end

@interface SLPrivateChatViewController (Business)
- (void)setupBusiness;


@end
