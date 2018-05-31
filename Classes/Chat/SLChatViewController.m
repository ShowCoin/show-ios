//
//  SLChatViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatViewController.h"
#import "SLChatViewController+BlankView.h"
// Views
#import "SLMessageListCell.h"
#import "SLConvListSystemTableViewCell.h"

static NSString * const TABLEVIEW_CELL_REUSEKEY_CONV = @"TABLEVIEW_CELL_REUSEKEY_CONV";
static NSUInteger const CellAndSectionHeight = 75;  //cell的高度

@interface SLChatViewController ()<UITableViewDataSource,UITableViewDelegate>
/// 当前移动索引
@property (nonatomic, assign) int currentScrollIndex;

@end

@implementation SLChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setRightIconImage:[UIImage imageNamed:@"chat_userlist"] forState:UIControlStateNormal];
    [self.navigationBarView setNavigationTitle:@"私信"];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor = kBlackThemeBGColor;
    _dataArray = [NSMutableArray array];
    _searchResultsArray = [NSMutableArray array];
    
    [self setupViews];
    [self addNotifications];

    // Do any additional setup after loading the view.
}
- (void)clickRightButton:(UIButton *)sender;
{
    [PageMgr pushToFriendListViewController];
}
#pragma mark - Life Cycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header endRefreshing];
    
    //让聊天室恢复对键盘的响应
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChatRoomInput object:@(YES)];
    
    PageMgr.rootController.enableSimultaneouslyGesture = YES;
    self.tableView.hidden = NO;
    [self hideBlankView];
    [self loadConversationList];
    
    if (@available(iOS 11.0, *)) {
        [IMSer getTotalUnreadCount];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //让聊天室失去对键盘的响应
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChatRoomInput object:@(NO)];
    PageMgr.rootController.enableSimultaneouslyGesture = NO;
    if ([self.searchController isActive]) {
        [self.searchController setActive:NO];
    }
}
#pragma mark - Set up
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = YES;
        _tableView.backgroundColor = kBlackThemeBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(void)setupViews
{
    self.tableView.frame = CGRectMake(0, kNaviBarHeight, kMainScreenWidth,kMainScreenHeight - kNaviBarHeight);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SLMessageListCell class] forCellReuseIdentifier:TABLEVIEW_CELL_REUSEKEY_CONV];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setRefreshHeader];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
