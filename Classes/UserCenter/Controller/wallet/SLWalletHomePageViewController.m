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


@end
