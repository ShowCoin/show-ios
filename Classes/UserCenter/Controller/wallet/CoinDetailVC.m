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

- (void)configSubView{//:@"0"
    
    ShowAccountTableHeader *headView = [[ShowAccountTableHeader alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 217.5*Proportion375)];
    headView.user = self.user;
    headView.walletModel = self.walletModel;
    [self.view addSubview:headView];
    self.headerView = headView;
    
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:kTextWhitef7f7f7 forState:UIControlStateNormal];
    [rechargeBtn setBackgroundColor:HexRGBAlpha(0x4eb871, 1) forState:UIControlStateNormal];
    rechargeBtn.hidden =[_user.uid isEqualToString:AccountUserInfoModel.uid]?NO:YES;
    rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f*WScale];
    [self.view addSubview:rechargeBtn];
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44));
        make.bottom.equalTo(self.view).with.offset(-KTabbarSafeBottomMargin);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(0.5);
    }];
    
    _withDrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _withDrawBtn.titleLabel.font = [UIFont  systemFontOfSize:16.0f*WScale];
    [_withDrawBtn setBackgroundColor:HexRGBAlpha(0xff3b68, 1) forState:UIControlStateNormal];
    [_withDrawBtn setTitle:@"提现" forState:UIControlStateNormal];
    [_withDrawBtn setTitleColor:kTextWhitef7f7f7 forState:UIControlStateNormal];
    _withDrawBtn.hidden =[_user.uid isEqualToString:AccountUserInfoModel.uid]?NO:YES;
    [self.view addSubview:_withDrawBtn];
  
    [_withDrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44));
        make.bottom.equalTo(self.view).with.offset(-KTabbarSafeBottomMargin);//-KTabbarSafeBottomMargin
        make.right.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(0.5);
    }];
    
    BOOL isMe = [self.user.uid isEqualToString:AccountUserInfoModel.uid];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.navigationBarView.mas_bottom);
        make.left.width.equalTo(self.view);
        make.bottom.equalTo(isMe?rechargeBtn.mas_top:self.view.mas_bottom).with.offset(isMe?0:KTabbarSafeBottomMargin);
    }];
    [self.tableView registerClass:[CoinDetailCell class] forCellReuseIdentifier:NSStringFromClass([CoinDetailCell class])];
    self.tableView.tableHeaderView  =  headView;
    self.tableView.backgroundColor = kBlackWith1c;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view bringSubviewToFront:self.tableView];
    [self.view bringSubviewToFront:self.navigationBarView];
    //充值按钮事件
    [[rechargeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        [PageMgr pushToRechargeViewControllerWithModel:self.walletModel ];
    }];
    //提现按钮事件
    [[_withDrawBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
//        [PageMgr pushToWithDrawController:self.walletModel.typeCName andUserModel:self.user];

//        if (AccountUserInfoModel.showCoinRmb.floatValue>10.0) {
            if (IsValidString([AccountModel shared].phoneNumber) && AccountUserInfoModel.authStatus.integerValue == 3 && AccountUserInfoModel.is_cashPassword.boolValue == YES) {
                [PageMgr pushToWithDrawController:self.walletModel.typeCName andUserModel:self.user wallCoinModel:self.walletModel];
            }else{
                self.withDrawBtn.userInteractionEnabled = NO;
                [self ShowWithDrawAlert];
                
            }
//        } else {
//            [ShowWaringView waringView:@"资产不足10元，不能提现。" style:WaringStyleRed];
//        }
    }];
}
//展示提现认证弹窗
-(void)ShowWithDrawAlert
{
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        self.withdrawAlertView= [SLWithdrawAlert authView];
        self.withdrawAlertView.delegate = self;
        self.withdrawAlertView.alpha = 1;
        self.withdrawAlertView.mainView.transform =CGAffineTransformMakeScale(0.5, 0.5);
        [self.view addSubview:self.withdrawAlertView];
        //            [[HWPopTool sharedInstance] showGiftTipsWithPresentView:_adAlertView];
        //        [ServiceMgr.adService saveLaunchAlertAd];
        [UIView animateWithDuration:0.25 animations:^{
            self.withdrawAlertView.alpha = 1;
            self.withdrawAlertView.mainView.transform =CGAffineTransformMakeScale(1, 1);

        }];
    
    });
}

-(void)SLWithdrawAlertsureClick
{
    if (_withdrawAlertView) {
        [_withdrawAlertView removeFromSuperview];
        _withdrawAlertView.delegate = nil;
        _withdrawAlertView = nil;
    }
    if (_withdrawAlertView) {
        //        [PageMgr pushToOtherVcWithmodel:ServiceMgr.adService.launchAlertAdmodel];
    }
    _withDrawBtn.userInteractionEnabled = YES;

}
-(void)SLWithdrawAlertCancelClick
{
    if (_withdrawAlertView) {
        [_withdrawAlertView removeFromSuperview];
        _withdrawAlertView.delegate = nil;
        _withdrawAlertView = nil;
    }
    _withDrawBtn.userInteractionEnabled = YES;

}

- (void)requestWithPage:(NSInteger)page perPage:(NSInteger)perpage paramters:(NSDictionary *)paramters SuccessBlock:(void(^)(BOOL sucess))successBlock FaildBlock:(void(^)(NSError *error))faildBlock{
    @weakify(self);
    
    self.getTransacitonListAction = [SLGetTransactionListAction action];
    if([self.tableView.mj_header isRefreshing])
    {
        self.cursor = @"0";
    }
    self.getTransacitonListAction.cursor = self.cursor;
    self.getTransacitonListAction.count = @"10";
    self.getTransacitonListAction.coin_type = self.walletModel.type;
    if(![self.user.uid isEqualToString:[AccountModel shared].uid]){
        self.getTransacitonListAction.uid = self.user.uid ;
    }
    self.getTransacitonListAction.finishedBlock = ^(id result) {
        @strongify(self);
        successBlock(YES);
        //请求成功
        NSDictionary * response=(NSDictionary *)result;
        if ([response isKindOfClass:[NSDictionary class]])
        {
            [self parseSucessData:response];
            //model转换或其他处理
        }
    };
    self.getTransacitonListAction.failedBlock = ^(NSError *error) {
        @strongify(self);
        self.error = error ;
        faildBlock(error);
    };
    [self.getTransacitonListAction start];
}

- (void)parseSucessData:(id)data{
    NSDictionary * result = (NSDictionary *)data;
    self.tableArray = [result valueForKey:@"list"];
    self.cursor = [NSString stringWithFormat:@"%@",[result objectForKey:@"next_cursor"]];

    if ([self.tableView.mj_header isRefreshing]) {
        self.dataSource =  @[[TransactionRecordsModel mj_objectArrayWithKeyValuesArray:self.tableArray]];
    }else{
        NSArray * dataArr = [TransactionRecordsModel mj_objectArrayWithKeyValuesArray:self.tableArray];
        NSMutableArray * oldArray = [NSMutableArray arrayWithArray:self.dataSource[0]];
        [oldArray addObjectsFromArray:dataArr];
        self.dataSource = @[[NSArray arrayWithArray:oldArray]];
    }
//    [self.tableView reloadData];
}

- (BOOL)shouldInfiniteScrolling{
    return YES;
}

//加载更多数据
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be d.
}


#pragma mark -tableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CoinDetailCell class])];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(TransactionRecordsModel *)object {
    [(CoinDetailCell *)cell bindModel:object withType:self.walletModel.typeCName];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{return 42.0f*WScale;};

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerSectionView = [[UIView alloc]init];
    headerSectionView.frame = CGRectMake(0, 0, kScreenWidth, 44*WScale);
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*WScale, 0, 100*WScale, 44*WScale)];
    headerLabel.text = @"最近交易记录";
    headerLabel.font = [UIFont boldSystemFontOfSize:14*WScale];
    headerLabel.textColor = kTextWith5b;
//    headerSectionView.backgroundColor = kBlackWith1c;
    [headerSectionView addSubview:headerLabel];
    return headerSectionView ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLCoinDetailInfoVC * vc = [SLCoinDetailInfoVC initVC];
     TransactionRecordsModel * model =self.dataSource[indexPath.section][indexPath.row];
    vc.tModel = model;
    vc.user = self.user;
    vc.walletModel = self.walletModel;
    [vc.navigationBarView setNavigationTitle:@"交易记录"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)configureCellHeightWithTableViewCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath withObject:(id)object{return 79.0f*Proportion375;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"skkskk ==   %f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -80*Proportion375) {
        scrollView.contentOffset = CGPointMake(0, -80*Proportion375);
    }
    if (scrollView.contentOffset.y > 100*Proportion375 && self.dataSource.count<1) {
        scrollView.contentOffset = CGPointMake(0, 100*Proportion375);
        
    }
}

#pragma mark - **********************withdrawAlert delegates **********************
- (void)SLWithdrawGoToPhoneVC;
{
    SLPhoneBindVC *bindPhoneVC = [[SLPhoneBindVC alloc]init];
    @weakify(self);
    bindPhoneVC.refresh = ^{
        @strongify(self);
        [self.withdrawAlertView checkSafeStatue];
        [self.withdrawAlertView.TabelView reloadData];
    };
    [self.navigationController pushViewController:bindPhoneVC animated:YES];

}
- (void)SLWithdrawGoToKYC;
{
//    if (AccountUserInfoModel.showCoinRmb.floatValue >= SysConfig.kyc_service_fee) {
        SLAuthIdentityViewController *authVC = [[SLAuthIdentityViewController alloc] init];
        authVC.userModel = self.user;
        @weakify(self);
        authVC.refresh = ^{
            @strongify(self);
            [self.withdrawAlertView checkSafeStatue];
            [self.withdrawAlertView.TabelView reloadData];
        };
        [self.navigationController pushViewController:authVC animated:YES];
//    }else{
//        NSString *strValue=[NSString stringWithFormat:@"%0.2f", SysConfig.kyc_service_fee];
//        UIAlertView *CoinAlert = [[UIAlertView alloc] initWithTitle:@"余额不足" message:[NSString stringWithFormat:@"每次提交KYC认证，系统扣除约等于%@元的SHOW币",strValue] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"充值", nil];
//        CoinAlert.tag = 2000;
//        [CoinAlert show];
//    }
}
@end
