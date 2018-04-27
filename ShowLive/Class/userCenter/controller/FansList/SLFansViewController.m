//
//  SLFansViewController.m
//  ShowLive
//
//  Created by 周华 on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLFansViewController.h"
#import "SLUserListCell.h"
#import "SLFansModel.h"
#import "SLMeFansListAction.h"

@interface SLFansViewController ()<UITableViewDataSource,UITableViewDelegate,SLUserListCellDelegate>
@property (nonatomic,strong)UITableView * TableView;

//页面参数
@property (nonatomic,copy)NSString * cursor;

//dataSource
@property (nonatomic,strong)NSMutableArray * tableArray;

@property (nonatomic,strong)NSMutableArray * tableModelArray;

@property (nonatomic,strong)NSMutableArray * tableListArray;

@property (nonatomic,strong)NSString * uid;

@property (nonatomic,strong)UIImage * backimage;

@property (nonatomic, assign)BOOL network;

@property (nonatomic, strong) SLMeFansListAction *fansListAction;

@end

@implementation SLFansViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _network =YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFollowStatus:) name:kNotificationChangeFollowStatus object:nil];
    [self setupViews];
}
-(void)setupViews
{
    [self.navigationBarView setNavigationTitle:@"粉丝"];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TableView];
}
#pragma mark - ********************** Functions **********************

//请求数据的方法
-(void)requestDataWithPage:(int)Type
{
    
    __weak typeof(self) weakSelf = self;
    _fansListAction = [SLMeFansListAction action];
    _fansListAction.uid = AccountUserInfoModel.uid;
    _fansListAction.cursor = self.cursor;
    _fansListAction.count = @"20";
    _fansListAction.finishedBlock = ^(id result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (IS_ARRAY_CLASS([result valueForKey:@"list"])) {
                weakSelf.tableArray = [result valueForKey:@"list"];
                weakSelf.tableModelArray = [SLFansModel mj_objectArrayWithKeyValuesArray:weakSelf.tableArray];
                if (Type == 1) {
                    weakSelf.tableListArray = [NSMutableArray arrayWithArray:weakSelf.tableModelArray];
                    [weakSelf stopLoadData];
                    [weakSelf.TableView reloadData];
                }else if(Type == 2){
                    NSMutableArray * Array = [[NSMutableArray alloc] init];
                    [Array addObjectsFromArray:weakSelf.tableListArray];
                    [Array addObjectsFromArray:weakSelf.tableModelArray];
                    weakSelf.tableListArray = Array;
                    [weakSelf stopLoadData];
                    [weakSelf.TableView reloadData];
                }
            }
            weakSelf.cursor = [result valueForKey:@"next_cursor"];
            NSString * page = [NSString stringWithFormat:@"%@", weakSelf.cursor];
            if (![page isEqualToString:@"-1"]) {
                weakSelf.TableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
                    [weakSelf loadMoreData];
                }];
            }else if ([page isEqualToString:@"-1"]) {
                if([weakSelf.tableListArray count]==0) {
                    [ShowWaringView waringView:@"还没有粉丝，完善信息让更多人关注你" style:WaringStyleRed];
                }else {
                    [weakSelf.TableView.mj_footer endRefreshingWithNoMoreData];
                    if (Type == 2) {
                        weakSelf.TableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                    }
                }
            }
        }
    };
    _fansListAction.failedBlock = ^(NSError *error) {
        if([weakSelf.tableListArray count]==0) {
            [ShowWaringView waringView:weakSelf.network?@"还没有粉丝，完善信息让更多人关注你":@"唔唔唔，没有网了" style:WaringStyleRed];
        }
        [weakSelf stopLoadData];
    };
    [_fansListAction start];
}

//停止刷新
-(void)stopLoadData
{
    [_TableView.mj_header endRefreshing];
    [_TableView.mj_footer endRefreshing];
}

//设置请求参数
-(void)addParameter
{
    _cursor = @"0";
}

//加载更多数据
-(void)loadMoreData
{
    
    [self requestDataWithPage:2];
}


- (UITableView *)TableView
{
    if (!_TableView)
    {
        
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth,kMainScreenHeight-kNaviBarHeight) style:UITableViewStylePlain];
        _TableView.dataSource = self;
        _TableView.delegate = self;
        _TableView.scrollEnabled = YES;
        _TableView.backgroundColor = [UIColor clearColor];
        _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        @weakify(self)
        self.TableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self)
//            if (self.uid)
//            {
                [self addParameter];
                [self requestDataWithPage:1];
//            }
        }];
        [self.TableView.mj_header beginRefreshing];
    }
    return _TableView;
}
- (void)notifi:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    
    //获取网络状态
    NSInteger status = [[dic objectForKey:@"AFNetworkingReachabilityNotificationStatusItem"] integerValue];
    
    if(status == AFNetworkReachabilityStatusNotReachable) {
        //无网络连接
        _network =NO;
        
    }else if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
        //蜂窝网络或者Wi-Fi连接
        _network =YES;
    }
}
#pragma TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [SLUserListCell rowHeightForObject:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_tableListArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    static NSString * cellID = @"BKUserListCell";
    
    SLFansModel * userModel = _tableListArray[indexPath.row];
    
    SLUserListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[SLUserListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.type = Fans;
    }
    
    cell.userListModel = userModel;
    
    
    return cell;
    
}


#pragma Cell delegate
-(void)SLUserlistCellFollowToast:(NSString *)toastStr withIndex:(NSInteger)index
{
    [ShowWaringView waringView:toastStr style:WaringStyleGreen];
    SLFansModel * userModel = _tableListArray[index];
    if ([[NSString stringWithFormat:@"%@",userModel.isFollowed] isEqualToString:@"0"]) {
        userModel.isFollowed = @"1";
    }else{
        userModel.isFollowed = @"0";
        
    }
}
-(void)SLUserlistCellToChatWithId:(NSString *)userId;
{
    [PageMgr pushToChatViewControllerWithTargetUserId:userId];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
}
-(void)SLUserListCellAttentionBtn:(UIButton *)attentionBtn clickedWithData:(id)celldata;
{
    SLFansModel * userModel = (SLFansModel*)celldata;
    
    NSString * userId  = userModel.uid;
    
    
    
    if ([AccountUserInfoModel.uid isEqualToString:userId]) {
        [ShowWaringView waringView:@"您不能关注自己" style:WaringStyleRed];
    }else
    {
        UIButton * btn = (UIButton*)attentionBtn;
        
        [btn setTitle:@"已关注" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
        [btn borderStyleWithColor:kGrayTextColor width:1];
        
        
        userModel.isFollowed = @"1";
        
        if (IS_EXIST_STR(userId)) {
            SLFollowUserAction *followAction = [SLFollowUserAction action];
            followAction.to_uid = userId;
            followAction.type = FollowTypeAdd;
            followAction.failedBlock = ^(NSError *error) {
                if (![error.userInfo[@"msg"] isEqualToString:@"你已经关注过人家了"]) {
                    [btn setTitle:@"已关注" forState:UIControlStateNormal];
                }
            };
            [followAction start];
        }
    }
}

- (void)refreshFollowStatus:(NSNotification *)notification {
    NSDictionary *notifyDic = notification.object;
    
    for (SLUserListCell *cell in _TableView.visibleCells) {
        if ([cell.userListModel.uid isEqualToString:notifyDic[@"uid"]]) {
            SLFansModel *model = cell.userListModel;
            model.isFollowed = [NSString stringWithFormat:@"%@", notifyDic[@"isFollowed"]];
            cell.userListModel = model;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
