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

#pragma mark - Views    
    
    UIView * whiteBG2 = [[UIView alloc] initWithFrame:CGRectMake(0, whiteBG1.bottom, kMainScreenWidth, 60*Proportion375)];
    whiteBG2.backgroundColor = kBlackWith1c;
    [_topView addSubview:whiteBG2];
    
    UILabel *countL = [[UILabel alloc]initWithFrame:CGRectMake(16*Proportion375, 0, 100, 60*Proportion375)];
    countL.textAlignment = NSTextAlignmentLeft;
    countL.text = STRING_WITHDRAW_COUNT_47;
    countL.font = [UIFont systemFontOfSize:16];
    countL.textColor = kTextWith8b;
    [whiteBG2 addSubview:countL];
    
    _numField = [[UITextField alloc]initWithFrame:CGRectMake(detailTypeL.left,0, 150*Proportion375,60*Proportion375)];
    _numField.centerY = 30*Proportion375;
    CGFloat numfielNum = self.walletModel.minWithdraw.floatValue;
    _numField.placeholder = [NSString stringWithFormat:@"最小提现额度%@",[NSString stringWithFormat:@"%.2f",numfielNum]];
    _numField.font = [UIFont fontWithName:KContentFont size:15];
    _numField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _numField.autocorrectionType = UITextAutocorrectionTypeNo;
    _numField.keyboardType = UIKeyboardTypeDecimalPad;
    _numField.returnKeyType = UIReturnKeyDone;
    _numField.delegate = self;
    _numField.textAlignment = NSTextAlignmentLeft;
    _numField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _numField.textColor = kTextWithF7;
//    _numField.tintColor = kTextWhitef7f7f7;
    [_numField setValue:kTextWith5b forKeyPath:@"_placeholderLabel.textColor"];

    _numField.adjustsFontSizeToFitWidth = YES;
//    [numField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [whiteBG2 addSubview:_numField];
//    [numField becomeFirstResponder];

    UILabel *DWL = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 60*Proportion375)];
    DWL.right  = kMainScreenWidth - 16*Proportion375;
    DWL.textAlignment = NSTextAlignmentRight;
    DWL.text = self.walletModel.typeCName;
    DWL.font = [UIFont systemFontOfSize:16];
    DWL.textColor = kTextWith8b;
    [whiteBG2 addSubview:DWL];
    
    
    UILabel * openNumLab1 = [UILabel labelWithText:@"可转额度" textColor:kTextWith8b font:Font_Regular(12) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    openNumLab1.frame = CGRectMake(15, whiteBG2.bottom+ 25*Proportion375, 50, 12*Proportion375);
    [_topView addSubview:openNumLab1];
    
    UILabel * openNumLab2 = [UILabel labelWithText:[AccountModel shared].showCoinNum textColor:kTextWith8b font:Font_Regular(12) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    openNumLab2.text = self.walletModel.balance;
    openNumLab2.frame = CGRectMake(15, whiteBG2.bottom+ 25*Proportion375, kMainScreenWidth - 160 *Proportion375, 12*Proportion375);
    openNumLab2.left = _numField.left;
    [_topView addSubview:openNumLab2];

    UILabel *withdrawAlltip = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth - 126*Proportion375, 0, 110*Proportion375, 13)];
    withdrawAlltip.centerY  = openNumLab2.centerY;
    withdraw

-(void)sliderChangeAction:(UISlider *)slider{
    NSLog(@"------%f",slider.value);
//    _numalertL.text = [NSString stringWithFormat:@"%f SHOW",slider.value];
    if (slider.value<0.25) {
        _numalertL.text = [NSString stringWithFormat:@"%@ %@",_low_fee,self.walletModel.typeCName];
        _server_fee = _low_fee;
        slider.value = 0;

    }else if (slider.value >0.75){
        _numalertL.text = [NSString stringWithFormat:@"%@ %@",_high_fee,self.walletModel.typeCName];
        _server_fee = _high_fee;
        slider.value = 1;
  
    }else {
        _numalertL.text = [NSString stringWithFormat:@"%@ %@",_mid_fee,self.walletModel.typeCName];
        _server_fee = _mid_fee;

        slider.value = 0.5;
    }
}
- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:_slider];
    CGFloat value = (_slider.maximumValue - _slider.minimumValue) * (touchPoint.x / _slider.frame.size.width );
    if (value<0.25) {
        _numalertL.text = [NSString stringWithFormat:@"%@ %@",_low_fee,self.walletModel.typeCName];
        _server_fee = _low_fee;
        [_slider setValue:0 animated:YES];

    }else if (value >0.75){
        _numalertL.text = [NSString stringWithFormat:@"%@ %@",_high_fee,self.walletModel.typeCName];
        _server_fee = _high_fee;
        [_slider setValue:1 animated:YES];

    }else {
        _numalertL.text = [NSString stringWithFormat:@"%@ %@",_mid_fee,self.walletModel.typeCName];
        _server_fee = _mid_fee;
        [_slider setValue:0.5 animated:YES];
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
