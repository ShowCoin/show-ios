//
//  SLPrivateChatViewController+Business.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *dataArray = self.dataArray;
        [self markViewModelTimeHiddenAndGiftModelTag:dataArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadTableViewWithData:dataArray];
        });
    });
}

- (void)updateCellDataWithMessageId:(long)messageId
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataArray = [NSMutableArray array];
        [dataArray addObjectsFromArray:self.dataArray];
        
        // create new viewModel
        RCMessage *rcMessage = [self.business getMessageWithMessageId:messageId];
        id<SLChatMessageBaseCellViewModel> viewModel = [[self viewModelsWithRCMessages:@[rcMessage]] firstObject];
        
        // replace
        [dataArray replaceObjectAtIndex:row withObject:viewModel];
        
        [self updateViewModelTimeAndSizeWithDataArray:dataArray];
        
        // update dataArray
        self.tableView.dataArray = dataArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadRow:row animated:NO];
            [self endTableRefreshAnimation];
            [self scrollToBottomAnimated:YES];
        });
    });
}

- (void)updateMessageReadStateBeforeLastSentTime:(long)time
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
    dispatch_async(self.messageWorkQueue, ^{
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
            // 间隔5分钟,隐藏 （*1000 计算秒数， 融云以毫秒计算时间)
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

#pragma mark - Replace
- (void)replaceWithOldMessageId:(NSInteger)oldMessageId ofNewMessageIdAtEnd:(NSInteger)newMessageId scrollToBottom:(BOOL)scrollToBottom scrollToBottomAnimated:(BOOL)scrollToBottomAnimated
{
    NSInteger oldMessageIndex = [self indexOfDataArrayWithMessageId:oldMessageId];
    if (oldMessageIndex >= self.dataArray.count) {
        return;
    }
    
    RCMessage *newMessage = [self.business getMessageWithMessageId:newMessageId];
    if (!newMessage) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<SLChatMessageBaseCellViewModel> viewModel = [[self viewModelsWithRCMessages:@[newMessage]] firstObject];
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        [dataArray addObjectsFromArray:self.dataArray];
        [dataArray removeObjectAtIndex:oldMessageIndex];
        [dataArray addObject:viewModel];
        
        [self updateViewModelTimeAndSizeWithDataArray:dataArray];
        self.tableView.dataArray = dataArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *oldMessageIndexPath = [NSIndexPath indexPathForRow:oldMessageIndex inSection:0];
            NSIndexPath *newMessageIndexPath = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[oldMessageIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView insertRowsAtIndexPaths:@[newMessageIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self endTableRefreshAnimation];
            if (scrollToBottom) {
                [self scrollToBottomAnimated:scrollToBottomAnimated];
            }
        });
    });
}
@end
