 //
//  CoinDetailVC.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "CoinDetailVC.h"

#import "CoinDetailCell.h"
#import "ShowAccountTableHeader.h"

#import "TransactionRecordsModel.h"
#import "ShowAddAddressViewController.h"
#import "ShowCollectViewController.h"
#import "WithdrawViewController.h"
#import "SLGetTransactionListAction.h"
#import "SLCoinDetailInfoVC.h"
#import "SLGetWalletInfoAction.h"
#import "SLWithdrawAlert.h"
#import "SLPhoneBindVC.h"
#import "SLAuthIdentityViewController.h"
#import "SLChangeCoinPasswordController.h"

@interface CoinDetailVC ()<SLWithdrawAlertDelegate>

@property (nonatomic, strong) SLGetTransactionListAction * getTransacitonListAction;
@property (nonatomic, strong) SLGetWalletInfoAction * getWalletInfoAction;
//dataSource
@property (nonatomic, strong) NSMutableArray * tableArray;
@property (nonatomic, weak) ShowAccountTableHeader *headerView;
@property (nonatomic, strong) SLWithdrawAlert *withdrawAlertView;
@property (nonatomic, strong) UIButton *withDrawBtn;

@end

@implementation CoinDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationBarView setNavigationTitle:self.walletModel.typeCName];
    [self getWalletInfo];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if ([self.user.uid isEqualToString:AccountUserInfoModel.uid]) {
        if ([self.walletModel.typeCName isEqualToString:@"秀币"]) {
            [SLReportManager reportPageBegin:kReport_MySHOWTransactionRecordPage];
        }else if ([self.walletModel.typeCName isEqualToString:@"以太"]){
            [SLReportManager reportPageBegin:kReport_MyETHTransactionRecordPage];
        }
        
    }else{
        if ([self.walletModel.typeCName isEqualToString:@"秀币"]) {
            [SLReportManager reportPageBegin:kReport_OthersSHOWTransactionRecordPage];
        }else if ([self.walletModel.typeCName isEqualToString:@"以太"]){
            [SLReportManager reportPageBegin:kReport_OthersETHTransactionRecordPage];
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTheKycStatue) name:SLKYCRefreshNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if ([self.user.uid isEqualToString:AccountUserInfoModel.uid]) {
        
        if ([self.walletModel.typeCName isEqualToString:@"秀币"]) {
            [SLReportManager reportPageEnd:kReport_MySHOWTransactionRecordPage];
        }else if ([self.walletModel.typeCName isEqualToString:@"以太"]){
            [SLReportManager reportPageEnd:kReport_MyETHTransactionRecordPage];
        }
    }else{
        if ([self.walletModel.typeCName isEqualToString:@"秀币"]) {
            [SLReportManager reportPageEnd:kReport_OthersSHOWTransactionRecordPage];
        }else if ([self.walletModel.typeCName isEqualToString:@"以太"]){
            [SLReportManager reportPageEnd:kReport_OthersETHTransactionRecordPage];
        }
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (BOOL)shouldRequestWhenViewDidLoad{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBarView setNavigationColor:NavigationColor1717];
    [self.navigationBarView setNavigationTitle:@"钱包"];
    self.view.backgroundColor = kBlackThemeBGColor;
    
    UIImageView * bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 200*Proportion375)];
    [bgImg setImage:[UIImage imageNamed:@"wallet_bg"]];
    bgImg.clipsToBounds = YES;
    [self.view addSubview:bgImg];
    [self configSubView];
    [self.tableView.mj_header beginRefreshing];
    self.cursor = @"0";
    

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
        SLWalletCoinModel * show =model.coinList[0];
        AccountUserInfoModel.showCoinNum = show.balance;
        if (model.coinList.count>3) {
            SLWalletCoinModel * eth =model.coinList[3];
            AccountUserInfoModel.ethCoinNumber = eth.balance;
        }
        [AccountUserInfoModel save];
        
        for (int i = 0; i<model.coinList.count; i++) {
            SLWalletCoinModel * coinmodel = model.coinList[i];
            if ([coinmodel.typeCName isEqualToString:self.walletModel.typeCName]) {
                self.walletModel = coinmodel;
            }
        }
        [HDHud hideHUDInView:self.view];
        self.headerView.walletModel = self.walletModel;
        //  初始化用户单例
    };
    self.getWalletInfoAction.failedBlock = ^(NSError *error) {
        @strongify(self)
        [HDHud hideHUDInView:self.view];
    };
    [self.getWalletInfoAction start];
}

@end
