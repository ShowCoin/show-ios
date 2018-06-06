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

@end
