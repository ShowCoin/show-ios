//
//  SLPrivateChatViewController+TableView.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController.h"
#import "SLChatTableView.h"
#import "SLChatMessageCellProtocol.h"
@interface SLPrivateChatViewController()
@property (strong, nonatomic) SLChatTableView *tableView;
@end

@interface SLPrivateChatViewController (TableView)<SLChatMessageCellDelegate>
- (void)setupChatTableView;
- (void)reloadTableViewWithData:(NSArray<id<SLChatMessageBaseCellViewModel>> *)dataArray;

// TableView actions
- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)scrollToRow:(NSInteger)row animated:(BOOL)animated position:(UITableViewScrollPosition)position;
- (void)reloadRow:(NSUInteger)row animated:(BOOL)animated;
- (void)insertRow:(NSUInteger)row animated:(BOOL)animated newDataArray:(NSArray *)dataArray;
- (void)deleteCellAtRow:(NSUInteger)row animation:(BOOL)animation;

// refresh header
- (void)updateTableRefreshHeaderWithEachRefreshCount:(NSInteger)count;
- (void)endTableRefreshAnimation;

- (NSArray<id<SLChatMessageBaseCellViewModel>> *)dataArray;

@end
