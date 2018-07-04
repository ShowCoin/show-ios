//
//  SLFriendListViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLFriendListViewController.h"
#import "SLSearchBar.h"
#import "UIView+build.h"
#import "SLVMFriendList.h"
#import "SLFansModel.h"
#import "ShowUserModel.h"
#import "SLFollowUserAction.h"

@interface SLFriendListViewController ()<UITableViewDelegate,SLSearchBarDelegate>{
    UIView  *_searchBarView;
    BOOL     _bSearchTableView;
    UILabel *_lblFriendReqCount;
    UIView  *_vwFriendReqCount;
}

@property (nonatomic, strong) UILabel *lblFriendTotals;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SLSearchBar *searchBar;
@property (nonatomic, assign) BOOL isLoading;
@property (strong, nonatomic) NSString *friendTotal;
@property (nonatomic, strong) SLVMFriendList *vmFrieldList;
@property (nonatomic, strong) SLFollowUserAction *followUserAction;

@end

@implementation SLFriendListViewController

- (void)cancelOperation {
    [_searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
//    [self.navigationBarView setRightIconImage:[UIImage imageNamed:@"userhome_avatar_more"] forState:UIControlStateNormal];
    [self.navigationBarView setNavigationTitle:@"选择联系人"];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor =kthemeBlackColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupControls];
    [self loadData];
}

- (void)clickRightButton:(id)sender {

}

- (void)setupControls {
    
    // headerView
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44)];
    [headerView setBackgroundColor:HexRGBAlpha(0xffffff,1)];
    
    self.searchBar = [[SLSearchBar alloc]initWithFrame:CGRectMake(0, 0,kMainScreenWidth, 44)];
    _searchBar.delegate = self;
    [_searchBar setBackgroundColor:kBlackThemeColor];
    UITextField* textField=[_searchBar valueForKey:@"textField"];
    if (textField&&[textField isKindOfClass:[UITextField class]]) {
        [textField setBackgroundColor:HexRGBAlpha(0x141414, 1)];
        [textField setReturnKeyType:UIReturnKeyDone];
    }
    _searchBar.placeholderColor = RGBCOLOR(182, 182, 182);
    _searchBar.placeholder = @" 搜索好友";
    _searchBar.canHideCancelButton = YES;
    _searchBar.leadingOrTailMargin = 8;
    
    _searchBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44+5)];
    _searchBarView.backgroundColor = kBlackThemeColor;
    [_searchBarView addSubview:_searchBar];
    [headerView addSubview:_searchBarView];
    
    _lblFriendReqCount=[_vwFriendReqCount buildLabel:@"0" withFrame:CGRectZero withFont:[UIFont systemFontOfSize:10] withTextColor:kBlackThemetextColor withTextAlign:NSTextAlignmentCenter];
    [_lblFriendReqCount setBackgroundColor:[UIColor clearColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onObserverNotify:) name:kNotificationFriendRequestCount object:nil];
    NSNotification* notify=[[NSNotification alloc] initWithName:kNotificationFriendRequestCount object:nil userInfo:nil];
    [self onObserverNotify:notify];
    
    _vmFrieldList=[SLVMFriendList new];
    _vmFrieldList.uid=[AccountUserInfoModel.uid integerValue];
    _vmFrieldList.parentVC=(id)self;
    _vmFrieldList.isAt =YES;

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth, kMainScreenHeight-kNaviBarHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = (id)_vmFrieldList;
    _tableView.tableHeaderView = headerView;
    _tableView.tableFooterView=[self footView];
    [_tableView setBackgroundColor:kBlackThemeColor];
    if (@available(iOS 11, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    [self.view addSubview:_tableView];
    
    @weakify(self)
    _tableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self searchBarCancelButtonClicked:self.searchBar];
        if (self.isLoading) {
            return ;
        }
        self.isLoading=YES;
        [self.tableView.mj_footer resetNoMoreData];
        @weakify(self);
        [self.vmFrieldList refreshData:^(BOOL ikMastPage) {
            @strongify(self);
            
            self.isLoading = NO;
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            self.friendTotal = [NSString stringWithFormat:@"%lu个SHOW好友",[self.vmFrieldList.listAry count]];
            if ([self.vmFrieldList.listAry count]==0) {
                [self.tableView.tableFooterView setHidden:YES];
//                [self showNoDataViewInView:self.tableView noDataString:@"你没有SHOW好友哦" withOrigin:CGPointMake(0, 98*Proportion375)];
            }else{
                [self.tableView.tableFooterView setHidden:NO];
            }
            
            if (ikMastPage) {
                self.tableView.mj_footer.hidden = YES;
            } else {
                self.tableView.mj_footer.hidden = NO;
            }
            [self.tableView reloadData];
            self.tableView.tableFooterView = [self footView];
        } withFail:^(NSString *failDesc) {
            @strongify(self);
            self.isLoading = NO;
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.tableFooterView setHidden:NO];
            self.tableView.tableFooterView = [self footView];
        }];
    }];
    
    
    _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self searchBarCancelButtonClicked:self.searchBar];
        if (self.isLoading) {
            return ;
        }
        self.isLoading = YES;
        @weakify(self);
        [self.vmFrieldList loadMoreData:^(BOOL ikMastPage) {
            @strongify(self);
            self.isLoading = NO;
            [self.tableView.mj_footer endRefreshing];
            
            if (ikMastPage) {
                self.tableView.mj_footer.hidden = YES;
            } else {
                self.tableView.mj_footer.hidden = NO;
            }
            
            [self.tableView reloadData];
            self.tableView.tableFooterView = [self footView];
        } withFail:^(NSString *failDesc) {
            @strongify(self);
            self.isLoading = NO;
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = NO;
            [self.tableView.tableFooterView setHidden:NO];
            self.tableView.tableFooterView = [self footView];
        }];
    }];
}

- (void)onObserverNotify:(NSNotification*)notification {
    if ([notification.name isEqualToString:kNotificationFriendRequestCount]) {
        NSNumber* count=@0;
        if (!notification.object) {
            count=[UserDefaultsUtils valueWithKey:kNotificationFriendRequestCount];
        }
        else{
            [UserDefaultsUtils saveValue:notification.object forKey:kNotificationFriendRequestCount];
            count=notification.object;
        }
        
        if ([count integerValue]>0) {
            CGSize size=[[count stringValue] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
            size=CGSizeMake(size.width+6*Proportion375, size.height+6*Proportion375);
            if (size.height<16*Proportion375) {
                size.height=16*Proportion375;
            }
            if (size.width<size.height) {
                size.width=size.height;
            }
            _lblFriendReqCount.text=[count stringValue];
            _vwFriendReqCount.frame=CGRectMake(kMainScreenWidth-36*Proportion375-size.width-6*Proportion375, 27*Proportion375-3*Proportion375-size.height/2, size.width, size.height);
            
            [_vwFriendReqCount.layer setCornerRadius:size.height/2];
            [_vwFriendReqCount.layer masksToBounds];
            _lblFriendReqCount.frame=CGRectMake(0, 0, size.width, size.height);
            [_vwFriendReqCount setHidden:NO];
        }else{
            [_vwFriendReqCount setHidden:YES];
        }
    }
}

- (void)loadData {
    [_vmFrieldList loadFromLocal];
    
    [self searchBarCancelButtonClicked:self.searchBar];
    if (self.isLoading) {
        return ;
    }
    self.isLoading=YES;
    [self.tableView.mj_footer resetNoMoreData];
    @weakify(self)
    [self.vmFrieldList refreshData:^(BOOL ikMastPage) {
        @strongify(self)
        self.isLoading = NO;
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.friendTotal = [NSString stringWithFormat:@"%lu个SHOW好友",[self.vmFrieldList.listAry count]];
        if ([self.vmFrieldList.listAry count]==0) {
            [self.tableView.tableFooterView setHidden:YES];
//            [self showNoDataViewInView:self.tableView noDataString:@"你没有SHOW好友哦" withOrigin:CGPointMake(0, 98*Proportion375)];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
            [self.tableView.mj_footer endRefreshing];
        }
        if (ikMastPage) {
            self.tableView.mj_footer.hidden = YES;
        } else {
            self.tableView.mj_footer.hidden = NO;
        }
        [self.tableView reloadData];
        self.tableView.tableFooterView = [self footView];
        
    } withFail:^(NSString *failDesc) {
        @strongify(self)
        self.isLoading = NO;
        [self.tableView.mj_header endRefreshing];
        self.tableView.tableFooterView = [self footView];
    }];
}

- (void)btnApplicationClick:(id)sender{
    
}

- (void)btnAddressClick:(id)sender{
    
}

#pragma tableview
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_bSearchTableView) {
        return nil;
    } else {
        UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
        [headView setBackgroundColor:kBlackThemeBGColor];
        NSString* key=nil;
        if ([[_vmFrieldList.dataDict allKeys] count]>section) {
            key = [_vmFrieldList.sortArray objectAtIndex:section];
        } else {
            key = @"#";
        }
        NSString* title=@"我的联系人";
        CGSize size=[title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, size.width, 30)];
        lblTitle.font = [UIFont systemFontOfSize:14];
        lblTitle.backgroundColor = kBlackThemeBGColor;
        lblTitle.textAlignment = NSTextAlignmentLeft;
        lblTitle.textColor = kGrayWith999999;
        lblTitle.text = title;
        //        if (section < [_sortArray count]) {
        //            lblTitle.text = title;
        //        
        [headView addSubview:lblTitle];
        return headView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_bSearchTableView) {
        return 0;
    }else{
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_bSearchTableView) {
        
        _bSearchTableView = NO;
        [_tableView reloadData];
    }
}

#pragma mark SLFriendCellDelegate
- (void)onClickUser:(SLFansModel*)data{
    [PageMgr pushToUserCenterControllerWithUid:data.uid];
}

- (void)onClickChat:(SLFansModel*)data{

    
    ShowUserModel* user=[ShowUserModel new];
    user.uid=data.uid;
    user.nickname=data.nickname;
    user.avatar=data.avatar;
    user.gender=data.gender;
    user.age=data.age;
    user.remarkName=data.localRemarkName;
    
    [PageMgr pushToChatViewControllerWithTargetUser:user];
}

- (void)onClickFollow:(SuccessBlock)block withData:(SLFansModel*)data{
    _followUserAction = [SLFollowUserAction action];
    _followUserAction.to_uid =data.uid;
    _followUserAction.type = FollowTypeAdd;
    _followUserAction.finishedBlock = ^(id result) {
        if (block) {
            block(YES);
        }
    };
    _followUserAction.failedBlock = ^(NSError *error) {
        if (block) {
            block(NO);
        }
        [ShowWaringView waringView:error.userInfo[@"msg"] style:WaringStyleRed];
    };
    _followUserAction.cancelledBlock = ^{
        if (block) {
            block(NO);
        }
    };
    [_followUserAction start];
}

#pragma mark SLSearchBarDelegate
- (void)searchBarSearchButtonClicked:(SLSearchBar *)searchBar {
    [self searchBarCancelButtonClicked:searchBar];
}

- (void)searchBar:(SLSearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length]>0) {
        _bSearchTableView=YES;
        _vmFrieldList.searchKey=searchText;
        self.lblFriendTotals.hidden = YES;
    }
    else
    {
        _bSearchTableView=NO;
        _vmFrieldList.searchKey=searchText;
        self.lblFriendTotals.hidden = NO;
    }
}

- (void)searchBarCancelButtonClicked:(SLSearchBar *)searchBar {
    [searchBar setText:@""];
    [searchBar resignFirstResponder];
    _bSearchTableView=NO;
    _vmFrieldList.searchKey=@"";
}


@end
