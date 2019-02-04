//
//  SLChatViewController.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "SLMessageListHeader.h"

//聊天相关
@interface SLChatViewController : BaseViewController

//搜索条目
@property (strong, nonatomic) UISearchController *searchController;
//聊天视图
@property (nonatomic, strong) UITableView *tableView;
//结果集合
@property (strong, nonatomic) NSMutableArray *searchResultsArray;
//数据
@property (nonatomic, strong) NSMutableArray *dataArray;
//是否搜索在搜索结果完事后刷新
@property (assign, nonatomic) BOOL shouldReloadAfterSearchResignActive;
//搜索朋友的tip
@property (nonatomic, strong) UIView *navFriendRequestTipsView;

// Private
- (void)stopLoadData;
- (void)setRefreshHeader;
- (void)hideRefreshHeader;

// Public
@property(nonatomic, assign)BOOL isHideTabbar;
// Public
- (void)doubleTapAction;

@end
