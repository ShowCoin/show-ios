//
//  SLPrivateChatViewController+TableView.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController+TableView.h"
#import "SLPrivateChatViewController+Business.h"
#import "SLPrivateChatViewController+MessageSend.h"
#import "SLPrivateChatViewController+Events.h"
#import "SLPrivateChatViewController+InputMoreCardView.h"
#import "SLChatMessageCellHeader.h"
#import "SLPrivateChatViewController+Common.h"

@implementation SLPrivateChatViewController (TableView)
#pragma mark - Setup
- (void)setupChatTableView
{
    self.tableView = [[SLChatTableView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight, kScreenWidth,  kScreenHeight - kNaviBarHeight - _GetChatInputViewHeight() - KTabbarSafeBottomMargin) style:UITableViewStylePlain];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.chatMessageCellDelegate = self;
    [self.view insertSubview:self.tableView atIndex:0];
    
    @weakify(self);
    self.tableView.tableViewWillBeginDragging = ^ {
        @strongify(self);
        [self setTableViewWillBeginDragging];
    };
}

- (void)reloadTableViewWithData:(NSArray<id<SLChatMessageBaseCellViewModel>> *)dataArray
{
    dispatch_main_async_safe(^{
        self.tableView.dataArray = dataArray;
        [self.tableView reloadData];
    });
}

- (void)setTableViewWillBeginDragging
{
    [self.view endEditing:YES];
    self.isInputMoreCardViewShow = NO;
}

#pragma mark - Refresh Header
- (void)updateTableRefreshHeaderWithEachRefreshCount:(NSInteger)count
{
    if (count >= self.business.eachPageMaxCount) {
        if (self.tableView.mj_header) {
            return;
        }
        @weakify(self);
        self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self loadMoreMessageData];
        }];
    } else {
        self.tableView.mj_header = nil;
    }
}

- (void)endTableRefreshAnimation
{
    if (self.tableView.mj_header) {
        [self.tableView.mj_header endRefreshing];
    }
}

#pragma mark - Scroll Actions
- (void)scrollToBottomAnimated:(BOOL)animated
{
    [self.tableView scrollToBottomAnimated:animated];
}

- (void)scrollToRow:(NSInteger)row animated:(BOOL)animated position:(UITableViewScrollPosition)position
{
    [self.tableView scrollToRow:row animated:animated position:position];
}

- (void)reloadRow:(NSUInteger)row animated:(BOOL)animated
{
    NSInteger count = [self.tableView numberOfRowsInSection:0];
    if (row >= count) {
        return;
    }
    dispatch_main_async_safe(^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animated ? UITableViewRowAnimationFade : UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    });
}

- (void)insertRow:(NSUInteger)row animated:(BOOL)animated newDataArray:(NSArray *)dataArray
{
    NSInteger count = dataArray.count;
    if (row >= count) {
        return;
    }
    
    dispatch_main_async_safe(^{
        self.tableView.dataArray = dataArray;
        [self.tableView beginUpdates];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animated ? UITableViewRowAnimationFade : UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    });
}

- (void)deleteCellAtRow:(NSUInteger)row animation:(BOOL)animation
{
    if (row >= self.dataArray.count) {
        return;
    }
    dispatch_main_async_safe(^{
        NSMutableArray *dataArray = [NSMutableArray array];
        [dataArray addObjectsFromArray:self.dataArray];
        [dataArray removeObjectAtIndex:row];
        self.tableView.dataArray = dataArray;
        
        [self.tableView beginUpdates];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        if (animation) {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        [self.tableView endUpdates];
    });
}

#pragma mark - Getter dataArray
- (NSArray<id<SLChatMessageBaseCellViewModel>> *)dataArray
{
    return self.tableView.dataArray;
}

#pragma mark - SLChatMessageCellDelegate
- (void)chatCell:(id<SLChatMessageCellProtocol>)cell didClickHeadProtraitWithViewModel:(id <SLChatMessageBaseCellViewModel>)viewModel
{
//    [self pushToUserCenter:viewModel];
}

- (void)chatCell:(id<SLChatMessageCellProtocol>)cell didClickContentViewWithViewModel:(id <SLChatMessageBaseCellViewModel>)viewModel
{
    switch (viewModel.cellType) {
        case SLChatMessageCellTypeVoice: {
            [self handleVoiceCellContentClickWithCell:(id<SLChatVoiceMessageCellProtocol>)cell viewModel:(id<SLChatVoiceMessageCellViewModel>)viewModel];
            break;
        }
        default:
            break;
    }
}

- (void)chatCell:(id<SLChatMessageCellProtocol>)cell didClickRetryButtonWithViewModel:(id <SLChatMessageBaseCellViewModel>)viewModel
{
    if ([viewModel conformsToProtocol:@protocol(SLChatTextMessageCellViewModel)]) {
        [self resendTextMessageWithViewModel:viewModel cell:cell];
    } else if ([viewModel conformsToProtocol:@protocol(SLChatVoiceMessageCellViewModel)]){
        [self resendVoiceMessageWithViewModel:viewModel cell:cell];
    }
}

- (void)chatCell:(id<SLChatMessageCellProtocol>)cell didClickBottomTipsLabelWithViewModel:(id <SLChatMessageBaseCellViewModel>)viewModel
{
    [self pushToConfigVC];
}



@end
