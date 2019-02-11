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

// Load
- (void)loadMessageData;
- (void)loadMoreMessageData;

// Add
/// Add a new row: will scroll to bottom animated
- (void)addNewMessageDataAtEndWithMessageId:(long)messageId;
- (void)addNewMessageDataAtEndWithMessageId:(long)messageId scrollToBottom:(BOOL)scrollToBottom scrollToBottomAnimated:(BOOL)animated;

// Update
- (void)updateMessageReadStateBeforeLastSentTime:(long)time;
- (void)updateCurrentDataViewModelTimeHiddenAndGiftTag;
- (void)updateCellDataWithMessageId:(long)messageId;
- (void)updateCellDataAtRow:(NSUInteger)row messageId:(long)messageId;

// Find
- (id)findViewModelInDataArrayWithRCMessageId:(long)messageId;
- (NSInteger)indexOfDataArrayWithMessageId:(long)messageId;
- (long)findLastReceivedMessageSentTime;

// Draft
- (void)saveInputTextToDraft;
- (NSString *)getInputTextDraft;

// Unread State
- (void)clearConversationMessageUnreadState;
- (void)setLastestMessageToReadState;
- (void)findAndSetUnreadMessageAfterViewDidApperar;

// Delete
- (void)deleteCellDataAndMessageAtRow:(NSUInteger)row animation:(BOOL)animation;

/// Replace:Delete old with messageId, add new one to the end
- (void)replaceWithOldMessageId:(NSInteger)oldMessageId ofNewMessageIdAtEnd:(NSInteger)newMessageId scrollToBottom:(BOOL)scrollToBottom scrollToBottomAnimated:(BOOL)animated;
@end
