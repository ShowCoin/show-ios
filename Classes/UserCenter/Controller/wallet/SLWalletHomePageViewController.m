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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ;
    if ([self.user.uid isEqualToString:AccountUserInfoModel.uid]) {
        _headerView = [[SLWalletHomePageHeader alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 681*Proportion375 + KNaviBarSafeBottomMargin)];

    }
    else
    {
       _headerView = [[SLWalletHomePageHeader alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 621*Proportion375)];
    }
    _headerView.user = self.user;
    _headerView.walletModel = self.walletModel;
    _headerView.hideBtn.selected = self.Littleishiden;
    @weakify(self)
    _headerView.switchBlock = ^(BOOL on) {
        @strongify(self)

        [self MakeTableDataWithSwitch:on];
        self.Littleishiden = on;
        
    };
    _headerView.showclickBlock = ^(BOOL on) {
        @strongify(self)
        if (self.dataArray.count) {
            
            SLWalletCoinModel * model =self.dataArray[0];
            if ([self.user.uid isEqualToString:AccountUserInfoModel.uid]) {
                [SLReportManager reportEvent:kReport_MyWallet andSubEvent:kReport_MyWallet_SHOWTransactionRecord];
            }else{
                [SLReportManager reportEvent:kReport_OthersWallet andSubEvent:kReport_OthersWallet_SHOWTransactionRecord];
            }
            [PageMgr pushToWalletDetailsController:model.type wallet:model user:self.user viewcontroller:self];//测试- 秀     演示-以太
        }

    };
    return _headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.user.uid isEqualToString:AccountUserInfoModel.uid])
        return 681*Proportion375 + KNaviBarSafeBottomMargin;
    else
        return 621*Proportion375;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*Proportion375;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowAccountCell * Cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!Cell) {
        Cell = [[ShowAccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SLWalletCoinModel * model =self.dataArray[indexPath.row];
    if (indexPath.row>2) {
        Cell.type = 1;
        Cell.coinNamelabel.text=model.typeCName;

    }else{
        Cell.type = 2;
        Cell.coinNamelabel.text=model.typeCName;
        Cell.coinDetailNamelabel.text=model.type;
    }
    [Cell.coinImage yy_setImageWithURL:[NSURL URLWithString:model.icon] placeholder:[UIImage imageNamed:@"account_eth"]];
    Cell.coinNumLabel.text = [NSString stringChangeMoneyWithStr:model.balance?:@"0" numberStyle:NSNumberFormatterDecimalStyle];
    Cell.RmbNumLabel.text = [NSString stringWithFormat:@"￥%@",[NSString stringChangeMoneyWithStr:model.balance_rmb?:@"0" numberStyle:NSNumberFormatterDecimalStyle]];
    Cell.FreezeNumLabel.text = [model.freeze_balance isEqualToString:@"0"]?@"":[NSString stringWithFormat:@"冻结 %@",[NSString stringChangeMoneyWithStr:model.freeze_balance numberStyle:NSNumberFormatterDecimalStyle]];
    Cell.percent = [[NSString stringWithFormat:@"%.2f",model.balance_rmb.floatValue/self.walletModel.rmb_num.floatValue] floatValue];
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLWalletCoinModel * model =self.dataArray[indexPath.row];
    
    if ([self.user.uid isEqualToString:AccountUserInfoModel.uid]) {
        [SLReportManager reportEvent:kReport_MyWallet andSubEvent:kReport_MyWallet_SHOWTransactionRecord];
    }else{
        [SLReportManager reportEvent:kReport_OthersWallet andSubEvent:kReport_OthersWallet_SHOWTransactionRecord];
    }
    [PageMgr pushToWalletDetailsController:model.type wallet:model user:self.user viewcontroller:self];//测试- 秀     演示-以太
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //    cell.alpha = 0;
    //    [UIView animateWithDuration:0.1 animations:^{
    //        cell.alpha = 1;
    //    }];
}

- (void)updateData {
    /// refresh
    NSLog(@"%s", __func__);
    SLWalletModel * model =[OTCChatRoom shared].model;

    self.walletModel.chg = model.chg;
    self.walletModel.high = model.high;
    self.walletModel.low = model.low;
    self.walletModel.last = model.last;
    self.walletModel.volcny = model.volcny;
    self.walletModel.val = model.val;
    self.walletModel.list = model.list;
    
    [self.tableView reloadData];
}
-(void)MakeTableDataWithSwitch:(BOOL)Switch
{
    if (Switch) {
        if (SysConfig.coin_limit_num.floatValue>0) {
            NSMutableArray * arr = [NSMutableArray array];
            for (int i= 0; i< self.walletModel.coinList.count; i++) {
                SLWalletCoinModel * model =self.walletModel.coinList[i];
                if (model.balance_rmb.floatValue> SysConfig.coin_limit_num.floatValue) {
                    [arr addObject:model];
                }
            }
            _dataArray = [NSArray arrayWithArray:arr];

        }else{
            
            NSMutableArray * arr = [NSMutableArray array];
            for (int i= 0; i< self.walletModel.coinList.count; i++) {
                SLWalletCoinModel * model =self.walletModel.coinList[i];
                if (model.balance.floatValue>0) {
                    [arr addObject:model];
                }
            }
            _dataArray = [NSArray arrayWithArray:arr];
        }
//        [_headerView refreshState];
    }else{
        _dataArray = self.walletModel.coinList;
    }
    [self.tableView reloadData];
   
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>0 && scrollView.contentOffset.y<100) {
        _navBgView.alpha = scrollView.contentOffset.y/100;
    }
    if (scrollView.contentOffset.y == 0) {
        _navBgView.alpha = 0;
    }
    if (scrollView.contentOffset.y > 100) {
        _navBgView.alpha = 1;
    }
}
@end
