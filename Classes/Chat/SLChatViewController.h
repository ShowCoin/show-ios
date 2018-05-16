//
//  SLChatViewController.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "SLMessageListHeader.h"

@interface SLChatViewController : BaseViewController
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *searchResultsArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (assign, nonatomic) BOOL shouldReloadAfterSearchResignActive;
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
