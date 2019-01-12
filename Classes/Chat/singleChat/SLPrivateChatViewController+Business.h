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


@end
