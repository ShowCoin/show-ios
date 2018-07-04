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

@end
