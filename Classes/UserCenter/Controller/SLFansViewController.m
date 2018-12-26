//
//  SLFansViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLFansViewController.h"
#import "SLUserListCell.h"
#import "SLFansModel.h"
#import "SLMeFansListAction.h"
#import "SLMeConcernListAction.h"

static NSString * const kNoFansMessage = @"还没有粉丝，完善信息让更多人关注你";
static NSString * const kNoAttentionMessage = @"你还没有关注任何人呦";
static NSString * const kNoNetMessage = @"唔唔唔，没有网了";

@interface SLFansViewController ()<UITableViewDataSource,UITableViewDelegate,SLUserListCellDelegate>
@property (nonatomic,strong)UITableView * TableView;

//页面参数
@property (nonatomic,copy)NSString * cursor;

//dataSource
@property (nonatomic,strong)NSMutableArray * tableArray;

@property (nonatomic,strong)NSMutableArray * tableModelArray;

@property (nonatomic,strong)NSMutableArray * tableListArray;

@property (nonatomic,strong)UIImage * backimage;

@property (nonatomic, assign)BOOL network;

@property (nonatomic, strong) SLMeFansListAction *fansListAction;
@property (nonatomic, strong) SLMeConcernListAction *corcernListAction;

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
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (_type ==1) {
        if ([self.uid isEqualToString:AccountUserInfoModel.uid]) {
            [SLReportManager reportPageBegin:kReport_MyFansListPage];

        }else{
            [SLReportManager reportPageBegin:kReport_OthersFansListPage];

        }

    }else{
        if ([self.uid isEqualToString:AccountUserInfoModel.uid]) {
            [SLReportManager reportPageBegin:kReport_MyFollowListPage];

        }else{
            [SLReportManager reportPageBegin:kReport_OthersFollowListPage];

        }
    }
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if (_type ==1) {
        if ([self.uid isEqualToString:AccountUserInfoModel.uid]) {
            [SLReportManager reportPageEnd:kReport_MyFansListPage];
        }else{
            [SLReportManager reportPageEnd:kReport_OthersFansListPage];
        }
    }else{
        if ([self.uid isEqualToString:AccountUserInfoModel.uid]) {
            [SLReportManager reportPageEnd:kReport_MyFollowListPage];
            
        }else{
            [SLReportManager reportPageEnd:kReport_OthersFollowListPage];
            
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _network =YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFollowStatus:) name:kNotificationChangeFollowStatus object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(focusChange:) name:kFollowUserStatusWithUidNotification object:nil];

    [self.navigationBarView setNavigationLineHidden:YES];
//    [self setupViews];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setupViews
{
    [self.navigationBarView setNavigationTitle:_type == 1?@"粉丝":@"关注"];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];

    self.view.backgroundColor = kBlackThemeBGColor;
    [self.view addSubview:self.TableView];
}
#pragma mark - ********************** Functions **********************
-(void)setType:(NSInteger)type
{
    _type = type;
    [self setupViews];
}
//请求数据的方法
-(void)requestDataWithPage:(int)Type
{
    __weak typeof(self) weakSelf = self;
    if (_type == 1) {
        _fansListAction = [SLMeFansListAction action];
        _fansListAction.uid = self.uid;
        _fansListAction.cursor = self.cursor;
        _fansListAction.count = @"20";
        _fansListAction.finishedBlock = ^(id result) {
            [weakSelf stopLoadData];
            if ([result isKindOfClass:[NSDictionary class]]) {
                if (IS_ARRAY_CLASS((NSArray*)[result valueForKey:@"list"])) {
                    weakSelf.tableArray = [result valueForKey:@"list"];
                    weakSelf.tableModelArray = [ShowUserModel mj_objectArrayWithKeyValuesArray:weakSelf.tableArray];
                    if (Type == 1) {
                        weakSelf.tableListArray = [NSMutableArray arrayWithArray:weakSelf.tableModelArray];
//                        [weakSelf stopLoadData];
                        [weakSelf.TableView reloadData];
                    }else if(Type == 2){
                        NSMutableArray * Array = [[NSMutableArray alloc] init];
                        [Array addObjectsFromArray:weakSelf.tableListArray];
                        [Array addObjectsFromArray:weakSelf.tableModelArray];
                        weakSelf.tableListArray = Array;
                        [weakSelf.TableView reloadData];
                    }
                }
                weakSelf.cursor = [result valueForKey:@"next_cursor"];
                NSString * page = [NSString stringWithFormat:@"%@", weakSelf.cursor];
                if (![page isEqualToString:@"-1"]) {
                    weakSelf.TableView.mj_footer = [SLRefreshFooter footerWithRefreshingBlock:^{
                        [weakSelf loadMoreData];
                    }];
                }else if ([page isEqualToString:@"-1"]) {
                    if([weakSelf.tableListArray count]==0) {
                        if ([weakSelf.uid isEqualToString:AccountUserInfoModel.uid]) {
                            [ShowWaringView waringView:kNoFansMessage style:WaringStyleRed];
                        }
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
                [ShowWaringView waringView:weakSelf.network?kNoFansMessage:kNoNetMessage style:WaringStyleRed];
            }
            [weakSelf stopLoadData];
        };
        [_fansListAction start];
        
    }else{
        _corcernListAction = [SLMeConcernListAction action];
        _corcernListAction.uid = self.uid;
        _corcernListAction.cursor = self.cursor;
        _corcernListAction.count = @"20";
        _corcernListAction.finishedBlock = ^(id result) {
            [weakSelf stopLoadData];
            if ([result isKindOfClass:[NSDictionary class]]) {
                if (IS_ARRAY_CLASS((NSArray*)[result valueForKey:@"list"])) {
                    weakSelf.tableArray = [result valueForKey:@"list"];
                    weakSelf.tableModelArray = [ShowUserModel mj_objectArrayWithKeyValuesArray:weakSelf.tableArray];
                    if (Type == 1) {
                        weakSelf.tableListArray = [NSMutableArray arrayWithArray:weakSelf.tableModelArray];
//                        [weakSelf stopLoadData];
                        [weakSelf.TableView reloadData];
                    }else if(Type == 2){
                        NSMutableArray * Array = [[NSMutableArray alloc] init];
                        [Array addObjectsFromArray:weakSelf.tableListArray];
                        [Array addObjectsFromArray:weakSelf.tableModelArray];
                        weakSelf.tableListArray = Array;
//                        [weakSelf stopLoadData];
                        [weakSelf.TableView reloadData];
                    }
                }
                weakSelf.cursor = [result valueForKey:@"next_cursor"];
                NSString * page = [NSString stringWithFormat:@"%@", weakSelf.cursor];
                if (![page isEqualToString:@"-1"]) {
                    weakSelf.TableView.mj_footer = [SLRefreshFooter footerWithRefreshingBlock:^{
                        [weakSelf loadMoreData];
                    }];
                }else if ([page isEqualToString:@"-1"]) {
                    if([weakSelf.tableListArray count]==0) {
                        if ([weakSelf.uid isEqualToString:AccountUserInfoModel.uid]) {
                            [ShowWaringView waringView:kNoAttentionMessage style:WaringStyleRed];
                        }
                    }else {
                        [weakSelf.TableView.mj_footer endRefreshingWithNoMoreData];
                        if (Type == 2) {
                            weakSelf.TableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                        }
                    }
                }
            }
        };
        _corcernListAction.failedBlock = ^(NSError *error) {
            if([weakSelf.tableListArray count]==0) {
                [ShowWaringView waringView:weakSelf.network?kNoAttentionMessage:kNoNetMessage style:WaringStyleRed];
            }
            [weakSelf stopLoadData];
        };
        [_corcernListAction start];

    }
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
        self.TableView.mj_footer = [SLRefreshFooter footerWithRefreshingBlock:^{
            @strongify(self)
            if (self.cursor.integerValue!=-1) {
                [self loadMoreData];
            }
        }];

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
-(void)focusChange:(NSNotification *)noti
{
    id objcet = noti.object;
    NSString * uid = [objcet objectForKey:@"uid"];
    NSString * statue = [objcet objectForKey:@"type"];
    for (int i = 0; i < _tableListArray.count; i++) {
        ShowUserModel * userModel = _tableListArray[i];
        if ([userModel.uid isEqualToString:uid]) {
            userModel.isFollowed = statue;
            return;
        }
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
