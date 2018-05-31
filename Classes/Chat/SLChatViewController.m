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
-(void)loadConversationList
{
    NSMutableArray *historyMsgArray = [[IMSer conversationList] mutableCopy];
    RCConversation *conver2 = nil ;
    for (RCConversation * conver in historyMsgArray) {
        if (conver.conversationType==ConversationType_SYSTEM) {
            conver2 = conver;
            break;
        }
    }
    if(conver2){
        [historyMsgArray removeObject:conver2];
        [historyMsgArray insertObject:conver2 atIndex:0];
    }
    self.dataArray = historyMsgArray;
#if KMMessageList_Show_Online_Status
    [self startOnlineStatusAction];
#else
    [self stopLoadData];
    [self.tableView reloadData];
#endif
}

-(void)stopLoadData
{
    [self.tableView.mj_header endRefreshing];
}
-(void)setShowUnreadCount:(NSUInteger)slUnreadCount
{
    [BaseTabBarController shareTabBarController].slMsgUnreadCount = 1;
}

#pragma mark - RefreshHeader
- (void)setRefreshHeader
{
    @weakify(self);
    self.tableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadConversationList];
    }];
}

- (void)hideRefreshHeader
{
    _tableView.mj_header = nil;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100*WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SLMessageListHeader * headerView = [[SLMessageListHeader alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 100*WScale)];
    [headerView lineDockBottomWithColor:kBlackSeparationColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return CellAndSectionHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.searchController.active) {
        return self.searchResultsArray.count ;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = nil;
    @weakify_old(self)
    RCConversation *conv = nil;
    if (self.searchController.active) {
        conv = self.searchResultsArray[indexPath.row];
    } else {
        conv = self.dataArray[indexPath.row];
    }
    
    SLMessageListCell * convCell = [self.tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_REUSEKEY_CONV];
    if (convCell) {
        
        convCell.cellData = conv;
        [convCell setAvatarTapedBlock:^(SLMessageListCell *sender){
            [self tapedConvCellAvatar:sender];
        }];
        [convCell setLongPressBlock:^(SLMessageListCell *sender){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];
            NSString* topTitle=conv.isTop ? @"取消置顶" : @"置顶";
            UIAlertAction *actionTop = [UIAlertAction actionWithTitle:topTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [IMSer setConversationToTop:ConversationType_PRIVATE targetId:conv.targetId isTop:!conv.isTop];
                [weak_self loadConversationList];
                
            }];
            UIAlertAction *actionDel = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [IMSer removeConversation:ConversationType_PRIVATE targetId:conv.targetId];
                [IMSer clearMessages:ConversationType_PRIVATE targetId:conv.targetId];
                
                [weak_self loadConversationList];
                
            }];
            UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:actionTop];
            [alert addAction:actionDel];
            [alert addAction:actionCancle];
            [weak_self presentViewController:alert animated:YES completion:nil];
            
        }];
        cell = convCell;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    RCConversation *conv = nil;
    if (self.searchController.active) {
        conv = self.searchResultsArray[indexPath.row];
    } else {
        conv = self.dataArray[indexPath.row];
    }
    
    if (![conv isKindOfClass:[RCConversation class]]) {
        return;
    }
    [PageMgr pushToChatViewControllerWithTargetUserId:conv.targetId];
    
    if (conv.unreadMessageCount > 0) {
        SLMessageListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell && [cell isKindOfClass:[SLMessageListCell class]]) {
            cell.unreadCount = 0;
        }
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchController.active) {
        return @[];
    }
    
    // 兼容
    if (!self.dataArray || indexPath.row > self.dataArray.count) {
        return @[];
    }
    
    @weakify_old(self)
    RCConversation *conv = self.dataArray[indexPath.row];
    BOOL isTop = conv.isTop;
    NSString *targetId = conv.targetId;
    
    NSString *topString = conv.isTop ? @"取消置顶" : @"置顶";
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:topString handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [IMSer setConversationToTop:ConversationType_PRIVATE targetId:targetId isTop:!isTop];
        [weak_self loadConversationList];
        
    }];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (indexPath.row == 0) {
            [IMSer removeConversation:ConversationType_SYSTEM targetId:targetId];
            [IMSer clearMessages:ConversationType_SYSTEM targetId:targetId];
        }
        else
        {
            [IMSer removeConversation:ConversationType_PRIVATE targetId:targetId];
            [IMSer clearMessages:ConversationType_PRIVATE targetId:targetId];
        }
        
        [weak_self loadConversationList];
    }];
    return @[deleteAction,indexPath.row==0?nil:editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}
#pragma mark - Actions
-(void)tapedSystemCellHeader:(SLConvListSystemTableViewCell *)sender
{
    if (sender && [sender isKindOfClass:[SLConvListSystemTableViewCell class]]) {
        [PageMgr pushToUserCenterControllerWithUid:SysConfig.official_user_id];
    }
}
-(void)tapedConvCellAvatar:(SLMessageListCell *)sender
{
    if (sender && [sender isKindOfClass:[SLMessageListCell class]]) {
        [PageMgr pushToUserCenterControllerWithUid:sender.cellData.targetId];
        
    }
}
- (void)doubleTapAction
{
    
    if ([IMSer getTotalUnreadCount] > 0) {
        int index = 0;
        for (int i = 1; i < self.dataArray.count; i++){
            RCConversation *conversation = self.dataArray[i];
            if ([conversation isKindOfClass:[RCConversation class]]) {
                if (conversation.unreadMessageCount >0 && i >= self.currentScrollIndex && self.tableView.contentOffset.y < (self.tableView.contentSize.height - self.tableView.height)) {
                    index = i;
                    break;
                }
            }
        }
        if (index > 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        self.currentScrollIndex = index;
    }else{
        if (!self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header beginRefreshing];
        }
    }
}

#pragma mark - Notification
- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyReceivedConvMsg:) name:kNotify_Received_RongCloud_ConvMsg object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLogoutNotification:) name:kNotificationLogout object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRongCloudLoginSuccessNotification:) name:kKMRongCloudLoginSuccessNotification object:nil];
}

- (void)notifyReceivedConvMsg:(NSNotification *)notification
{
    id objcet = notification.object;
    if (objcet && [objcet isKindOfClass:[RCMessage class]]) {
        if (self.searchController.isActive) {
            self.shouldReloadAfterSearchResignActive = YES;
        } else {
            [self loadConversationList];
        }
    }
}

- (void)didReceiveLogoutNotification:(NSNotification *)notification
{
    [IMSer updateTotalUnreadCount];
    
    [self.dataArray removeAllObjects];
    [self stopLoadData];
    [self.tableView reloadData];
}

- (void)didReceiveRongCloudLoginSuccessNotification:(NSNotification *)notification
{
    [self loadConversationList];
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
