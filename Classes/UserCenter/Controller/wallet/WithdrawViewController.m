//
//  WithdrawViewController.m
//  ShowLive
//
//  Created by vning on 2018/4/3.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "WithdrawViewController.h"
#import "WithdrawAddressViewController.h"
#import "SLwithdrawListViewController.h"
#import "SLPassWordAlert.h"
#import "SLGooglePassWordAlert.h"
#import "SLGetCoinInfo.h"

@interface WithdrawViewController ()<SLPassWordAlertDelegate,SLGooglePassWordAlertDelegate>
@property (nonatomic,retain )UIView * topView;
@property (nonatomic,retain)UILabel * numalertL;
@property (nonatomic,retain)UISlider *slider;
@property (nonatomic,retain)UILabel *addressNameL;
@property (nonatomic,retain)UILabel *addressStrL;
@property (nonatomic,retain)UITextField * numField;
@property (nonatomic,copy)UIButton *withDrawBtn;
@property (nonatomic,copy)NSString * addressID;
@property (nonatomic,copy)NSString * server_fee;
@property (nonatomic,copy)NSString * high_fee;
@property (nonatomic,copy)NSString * mid_fee;
@property (nonatomic,copy)NSString * low_fee;

@property (nonatomic,copy)NSString * moneyKey;
@property (nonatomic,copy)NSString * googleKey;

@property (nonatomic, strong)SLGetCoinInfo * getCoinInfoAction;
@property (nonatomic, strong)SLWithdrawFeeAction * refreshFeeAction;
@property (nonatomic,copy)NSString * coin_balance;
@property (nonatomic,copy)SLAddressList *addressModel;

@property (nonatomic,copy)UILabel * withdrawAlertC;
@property (nonatomic,copy)UILabel * withdrawAlertD;

@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationBarStyle:NavigationBarAll];
    [self.navigationBarView setNavigationColor:NavigationColor1717];
    [self.navigationBarView setNavigationTitle:STRING_WITHDRAW_TITLE_42];
    [self.navigationBarView setRightTitle:STRING_WITHDRAW_RECORD_43 titleColor:kTextWithF7 font:[UIFont systemFontOfSize:15]];
    self.moneyKey = @"";
    self.googleKey = @"";
    self.view.backgroundColor = kBlackWith1c;
    [self creatTopView];
    [self creatbottomViews];
    [self getCoinInfo];
    [self refreshFee];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if ([self.walletModel.typeCName isEqualToString:@"秀币"]) {
        [SLReportManager reportPageBegin:kReport_MySHOWWithdrawPage];
    }else{
        [SLReportManager reportPageBegin:kReport_MyETHWithdrawPage];

    }
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if ([self.walletModel.typeCName isEqualToString:@"秀币"]) {
        [SLReportManager reportPageEnd:kReport_MySHOWWithdrawPage];
    }else{
        [SLReportManager reportPageEnd:kReport_MyETHWithdrawPage];

    }
}


/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
