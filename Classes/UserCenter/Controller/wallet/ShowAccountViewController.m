//
//  ShowAccountViewController.m
//  ShowLive
//
//  Created by 周华 on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAccountViewController.h"
#import "ShowAccountCell.h"
#import "ShowAccountHead.h"
#import "CoinDetailVC.h"
#import "SLGetWalletInfoAction.h"
#import "SLWalletModel.h"
#import "ShowAccountTableHeader.h"
#import "PTTradeViewController.h"

@interface ShowAccountViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)SLGetWalletInfoAction * getWalletInfoAction;
@property (nonatomic, strong)SLWalletModel * walletModel;

@end

@implementation ShowAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HexRGBAlpha(0xffffff, 1);
    UIImageView * bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 250*Proportion375)];
    [bgImg setImage:[UIImage imageNamed:@"wallet_bg"]];
    bgImg.clipsToBounds = YES;
    [self.view addSubview:bgImg];
    
    [self.navigationBarView setNavigationTitle:@"钱包"];
    [self.navigationBarView setNavigationColor:NavigationWalletColorClear];
    
    [self.view bringSubviewToFront:self.navigationBarView];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18*Proportion375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWalletInfo) name:SLWalletToRefreshNotification object:nil];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 0, 60, 44);
    [button addTarget:self action:@selector(pushToPTViewControler) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBarView.rightView addSubview:button];
}

- (void)pushToPTViewControler {
    PTTradeViewController *pVC = [[PTTradeViewController alloc] init];
    [self.navigationController pushViewController:pVC animated:YES];
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
        
    }    [SLReportManager reportPageEnd:kReport_OthersWalletPage];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getWalletInfo];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}


@end
