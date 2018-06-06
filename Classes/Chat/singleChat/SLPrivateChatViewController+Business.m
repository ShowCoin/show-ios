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


@end
