//
//  SLPrivateChatViewController+Business.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController+Business.h"
#import "SLPrivateChatViewController+TableView.h"
#import "SLPrivateChatViewController+InputView.h"
#import "SLChatMessageCellHeader.h"
#import "SLChatMessageCellConfig.h"

@implementation SLPrivateChatViewController (Business)
- (void)setupBusiness
{
    if (!self.business) {
        self.business = [[SLChatBusiness alloc] initWithTargetUid:self.targetUid eachPageMaxCount:20];
    }
    
    if (!self.messageWorkQueue) {
        self.messageWorkQueue = dispatch_queue_create("com.PrivateChatViewController.Show", DISPATCH_QUEUE_SERIAL);
    }
}

#pragma mark - Load Messages
- (void)loadMessageData
{
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        NSArray<RCMessage*> *messages = [self.business fetchLatestMessages];
        if (!ValidArray(messages)){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self endTableRefreshAnimation];
                self.tableView.dataArray = nil;
                [self.tableView reloadData];
            });
            return;
        }
        
        NSMutableArray *dataArray = [NSMutableArray array];
        NSArray<id<SLChatMessageBaseCellViewModel>> *viewModels = [self viewModelsWithRCMessages:messages];
        
        [dataArray addObjectsFromArray:viewModels];
        
        [self updateViewModelTimeAndSizeWithDataArray:dataArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadTableViewWithData:dataArray];
            [self updateTableRefreshHeaderWithEachRefreshCount:dataArray.count];
            [self endTableRefreshAnimation];
            [self scrollToBottomAnimated:NO];
        });
    });
}

- (void)loadMoreMessageData
{
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        self.priorCount = self.dataArray.count;
        long oldestMessageId = 0;
        if (self.dataArray.count > 0) {
            id<SLChatMessageBaseCellViewModel> first = [self.dataArray firstObject];
            oldestMessageId = first.rcMessage.messageId;
        }
        
        NSArray<RCMessage*> *messages = [self.business fetchMessagesWithOldestMessageId:oldestMessageId];
        if (!ValidArray(messages)){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self endTableRefreshAnimation];
            });
            return;
        }
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSArray *viewModels = [self viewModelsWithRCMessages:messages];
        [dataArray addObjectsFromArray:viewModels];
        [dataArray addObjectsFromArray:self.dataArray];
        
        [self updateViewModelTimeAndSizeWithDataArray:dataArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self endTableRefreshAnimation];
            [self reloadTableViewWithData:dataArray];
            [self updateTableRefreshHeaderWithEachRefreshCount:dataArray.count];
            if (self.priorCount > 0 && dataArray.count > self.priorCount) {
                NSInteger row = dataArray.count - self.priorCount;
                [self scrollToRow:row animated:NO position:UITableViewScrollPositionTop];
            }
        });
    });
}

#pragma mark - Update
- (void)updateCurrentDataViewModelTimeHiddenAndGiftTag
{
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        NSArray *dataArray = self.dataArray;
        [self markViewModelTimeHiddenAndGiftModelTag:dataArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadTableViewWithData:dataArray];
        });
    });
}

- (void)updateCellDataWithMessageId:(long)messageId
{
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        id<SLChatMessageBaseCellViewModel> viewModel = [self findViewModelInDataArrayWithRCMessageId:messageId];
        if (!viewModel) {
            return;
        }
        NSInteger index = [self.dataArray indexOfObject:viewModel];
        [self updateCellDataAtRow:index messageId:messageId];
    });
}

- (void)updateCellDataAtRow:(NSUInteger)row messageId:(long)messageId
{
    if (self.dataArray.count <= row) {
        return;
    }
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        NSMutableArray *dataArray = [NSMutableArray array];
        [dataArray addObjectsFromArray:self.dataArray];
        
        // create new viewModel
        RCMessage *rcMessage = [self.business getMessageWithMessageId:messageId];
        id<SLChatMessageBaseCellViewModel> viewModel = [[self viewModelsWithRCMessages:@[rcMessage]] firstObject];
        
        // replace
        [dataArray replaceObjectAtIndex:row withObject:viewModel];
        [self updateViewModelTimeAndSizeWithDataArray:dataArray];
        self.tableView.dataArray = dataArray;
        // update dataArray
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            [self reloadRow:row animated:YES];
            [self endTableRefreshAnimation];
            [self scrollToBottomAnimated:YES];
        });
        
    });
}

- (void)updateMessageReadStateBeforeLastSentTime:(long)time
{
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        NSMutableArray *dataArray = [NSMutableArray array];
        [dataArray addObjectsFromArray:self.dataArray];
        
        for (NSInteger i = dataArray.count - 1; i >= 0; i--) {
            id<SLChatMessageBaseCellViewModel> viewModel = dataArray[i];
            if (!viewModel.showSentMessageReadState) {
                continue;
            }
            
            // find lastest read message,all before this was read
            if (viewModel.isSentMessageRead) {
                break;
            }
            
            // before this time, set to read
            RCMessage *message = viewModel.rcMessage;
            if (message.sentTime <= time) {
                viewModel.isSentMessageRead = YES;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadTableViewWithData:dataArray];
        });
    });
}

#pragma mark - Add
- (void)addNewMessageDataAtEndWithMessageId:(long)messageId
{
    [self addNewMessageDataAtEndWithMessageId:messageId scrollToBottom:YES scrollToBottomAnimated:YES];
}

- (void)addNewMessageDataAtEndWithMessageId:(long)messageId scrollToBottom:(BOOL)scrollToBottom scrollToBottomAnimated:(BOOL)animated
{
    RCMessage *rcMessage = [self.business getMessageWithMessageId:messageId];
    if (!rcMessage) {
        return;
    }
    @weakify(self);
    dispatch_async(self.messageWorkQueue, ^{
        @strongify(self);
        id<SLChatMessageBaseCellViewModel> viewModel = [[self viewModelsWithRCMessages:@[rcMessage]] firstObject];
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        [dataArray addObjectsFromArray:self.dataArray];
        [dataArray addObject:viewModel];
        
        [self updateViewModelTimeAndSizeWithDataArray:dataArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self insertRow:self.dataArray.count animated:NO newDataArray:dataArray];
            [self endTableRefreshAnimation];
            if (scrollToBottom) {
                [self scrollToBottomAnimated:animated];
            }
        });
    });
}

#pragma mark - Find
- (NSInteger)indexOfDataArrayWithMessageId:(long)messageId
{
    // because last message will use this method,we find from last one
    NSInteger index = -1;
    for (NSInteger i = self.dataArray.count - 1; i >= 0; i--) {
        id<SLChatMessageBaseCellViewModel> viewModel = self.dataArray[i];
        RCMessage *rcMessage = viewModel.rcMessage;
        if (rcMessage.messageId == messageId) {
            index = i;
            break;
        }
    }
    return index;
}

- (id<SLChatMessageBaseCellViewModel>)findViewModelInDataArrayWithRCMessageId:(long)messageId
{
    NSInteger index = [self indexOfDataArrayWithMessageId:messageId];
    if (index >= 0) {
        id<SLChatMessageBaseCellViewModel> viewModel = self.dataArray[index];
        return viewModel;
    }
    return nil;
}

- (void)findAndSetUnreadMessageAfterViewDidApperar
{
    NSInteger unreadCount = [self.business getUnreadMessageCount];
    if (!unreadCount) {
        return;
    }
    
    unreadCount = MIN(self.dataArray.count, unreadCount);
    
}

- (long)findLastReceivedMessageSentTime
{
    // find last sentTime
    __block long lastSentTime = 0;
    [self.dataArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<SLChatMessageBaseCellViewModel>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id<SLChatMessageBaseCellViewModel> viewModel = obj;
        if (viewModel.messageDirection == SLChatMessageDirectionReceived) {
            RCMessage *message = viewModel.rcMessage;
            lastSentTime = message.sentTime;
            *stop = YES;
        }
    }];
    return lastSentTime;
}

#pragma mark - Private Filter
- (void)updateViewModelTimeAndSizeWithDataArray:(NSMutableArray *)dataArray
{
    [self markViewModelTimeHiddenAndGiftModelTag:dataArray];
    
    id<SLChatMessageBaseCellViewModel> lastViewModel = [dataArray lastObject];
    [self markLastViewModel:lastViewModel];
    
    // re calculate cell height
    for (id<SLChatMessageBaseCellViewModel> viewModel in dataArray) {
        [viewModel updateCachedHeightIfNeed];
    }
}
- (void)markViewModelTimeHiddenAndGiftModelTag:(NSArray<id<SLChatMessageBaseCellViewModel>>*)viewModels
{
    for (NSInteger i = 0; i < viewModels.count; i++) {
        id<SLChatMessageBaseCellViewModel> viewModel = viewModels[i];
        viewModel.hideTime = NO;
        // Compare eatch two message`s sentTime
        if (i > 0) {
            id<SLChatMessageBaseCellViewModel> preViewModel = viewModels[i-1];
            // Interval 5 minutes, hidden (*1000 calculation seconds, cloud in milliseconds)
            if (viewModel.rcMessage.sentTime - preViewModel.rcMessage.sentTime >= 5*60*1000){
                viewModel.hideTime = NO;
            } else {
                viewModel.hideTime = YES;
            }
        }
        
    }
    
}
- (void)markLastViewModel:(id<SLChatMessageBaseCellViewModel>)lastViewModel
{
    // > 3分钟，不是好友，接受的消息，最后一条提示 免打扰信息
    BOOL isReceivedMessage = (lastViewModel.rcMessage.messageDirection == MessageDirection_RECEIVE);
    if (!isReceivedMessage) {
        return;
    }
    
    // 可能没有请求到数据，此时不展示
    
    
    // sent time since now
    NSTimeInterval lastSentTimeInterval = lastViewModel.rcMessage.sentTime/1000;
    NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:lastSentTimeInterval];
    NSTimeInterval sinceNowInterval = [[NSDate date] timeIntervalSinceDate:lastDate];
    // > 3 min
    if (sinceNowInterval > 3*60)  {
        lastViewModel.showNotDisturbTips = YES;
    }
}
- (NSArray<id<SLChatMessageBaseCellViewModel>> *)viewModelsWithRCMessages:(NSArray<RCMessage*> *)messages
{
    NSMutableArray<id<SLChatMessageBaseCellViewModel>> *dataArray = [NSMutableArray array];
    for (NSInteger i = messages.count -1; i >= 0; i--) {
        RCMessage *message = messages[i];
        NSString *className = [SLChatMessageCellConfig cellViewModelImpClassNameWithRCMessage:message];
        id<SLChatMessageBaseCellViewModel> viewModel = [NSClassFromString(className) viewModelWithRcMessage:message];
        
        
        [dataArray addObject:viewModel];
    }
    return dataArray;
}

#pragma mark - Text Draft
- (void)saveInputTextToDraft
{
    NSString *draft = [self.chatInputView.inputTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self.business saveTextToDraft:draft];
}

- (NSString *)getInputTextDraft
{
    return [self.business getTextDraft];
}
#pragma mark - Clear Unread State
- (void)clearConversationMessageUnreadState
{
    [self.business clearConversationMessageUnreadState];
}

- (void)setLastestMessageToReadState
{
    id<SLChatMessageBaseCellViewModel> lastModel = [self.dataArray lastObject];
    RCMessage *message = lastModel.rcMessage;
    [self.business setMessageReceivedStatusWithMessageId:message.messageId rcReceivedStatus:ReceivedStatus_READ];
}

- (NSInteger)getUnreadMessageCount
{
    return [self.business getUnreadMessageCount];
}
#pragma mark - Delete

- (void)deleteCellDataAndMessageAtRow:(NSUInteger)row animation:(BOOL)animation
{
    if (row >= self.dataArray.count) {
        return;
    }
    
    id<SLChatMessageBaseCellViewModel> viewModel = self.dataArray[row];
    
    RCMessage *message = viewModel.rcMessage;
    [self.business deleteMessageWithId:message.messageId];
    
    [self deleteCellAtRow:row animation:animation];
}
@end
