//
//  SLWalletHomePageViewController.m
//  ShowLive
//
//  Created by vning on 2018/10/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLWalletHomePageViewController.h"
#import "ShowAccountCell.h"
#import "SLWalletHomePageHeader.h"
#import "SLGetWalletInfoAction.h"
#import "SLWalletModel.h"
#import "OTCChatRoom.h"

@interface SLWalletHomePageViewController ()
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)UIView * navBgView;
@property (nonatomic, strong)SLGetWalletInfoAction * getWalletInfoAction;
@property (nonatomic, strong)SLWalletModel * walletModel;
@property (nonatomic, strong)NSArray * dataArray;
@property (nonatomic, strong)SLWalletHomePageHeader * headerView;
@property (nonatomic, assign)BOOL Littleishiden;


@end

@implementation SLWalletHomePageViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
    [OTCChatRoom.shared quitRoom];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBlackWith17;
    _dataArray = [NSArray array];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.naviView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWalletInfo) name:SLWalletToRefreshNotification object:nil];

    [OTCChatRoom.shared joinRoom];
    [OTCChatRoom.shared registerListenerForDataRenew:self withFunction:@selector(updateData)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if ([self.user.uid isEqualToString:AccountUserInfoModel.uid]) {
        [SLReportManager reportPageBegin:kReport_MyWalletPage];
        
    }else{
        [SLReportManager reportPageBegin:kReport_OthersWalletPage];
        
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if ([self.user.uid isEqualToString:AccountUserInfoModel.uid]) {
        [SLReportManager reportPageEnd:kReport_MyWalletPage];
        
    }else{
       [SLReportManager reportPageEnd:kReport_OthersWalletPage];
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getWalletInfo];
    _Littleishiden = NO;
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)getWalletInfo
{
    if (self.getWalletInfoAction ) {
        [self.getWalletInfoAction cancel];
        self.getWalletInfoAction = nil;
    }
    [HDHud showHUDInView:self.view title:@""];
    
    self.getWalletInfoAction = [SLGetWalletInfoAction action];
    self.getWalletInfoAction.uid = self.user.uid?:AccountUserInfoModel.uid;
    self.getWalletInfoAction.modelClass = SLWalletModel.self;
    @weakify(self)
    self.getWalletInfoAction.finishedBlock = ^(SLWalletModel *model)
    {
        [model newCoinList];
        @strongify(self)
        if ([self.user.uid isEqualToString:AccountUserInfoModel.uid]) {
            
            if (model.coinList.count >0) {
                SLWalletCoinModel * show =model.coinList[0];
                AccountUserInfoModel.showCoinNum = show.balance;
            }
            if (model.coinList.count>1) {
                SLWalletCoinModel * eth =model.coinList[1];
                AccountUserInfoModel.ethCoinNumber = eth.balance;
            }
            [AccountUserInfoModel save];
        }
        
        [HDHud hideHUDInView:self.view];
        self.walletModel = model;
        self.dataArray = self.walletModel.coinList;
        [self reloadUI];
        //  初始化用户单例
    };
    self.getWalletInfoAction.failedBlock = ^(NSError *error) {
        @strongify(self)
        [HDHud hideHUDInView:self.view];
        [HDHud showMessageInView:self.view title:error.userInfo[@"msg"]];
    };
    [self.getWalletInfoAction start];
    
}
-(void)reloadUI
{
    [self.tableView reloadData];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight) style:UITableViewStyleGrouped];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}
-(UIView *)naviView
{
    if (!_naviView) {
        _naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kNaviBarHeight)];
        _navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kNaviBarHeight)];
        _navBgView.backgroundColor = HexRGBAlpha(0x171717, 1);
        [_naviView addSubview:_navBgView];
        _navBgView.alpha = 0;
        UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(6, 20+KNaviBarSafeBottomMargin, 44, 44)];
        [leftBtn setImage:[UIImage imageNamed:@"account_navBack"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"account_navBack"] forState:UIControlStateHighlighted];
//        [leftBtn setImage:[UIImage imageNamed:@"account_navBack"] forState:UIControlStateSelected];
        [_naviView addSubview:leftBtn];
        @weakify(self)
        [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        }];

        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20 + KNaviBarSafeBottomMargin, kMainScreenWidth, 44)];
        [titleLab setText:@"钱包账户"];
        [titleLab setFont:[UIFont systemFontOfSize:18]];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [titleLab setTextColor:kThemeWhiteColor];
        [_naviView addSubview:titleLab];

    }
    return _naviView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableView

@end
