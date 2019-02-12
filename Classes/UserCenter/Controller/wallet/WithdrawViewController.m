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
-(void)creatTopView
{
    _topView =[[UIView alloc] init];
    _topView.backgroundColor = kBlackWith1c;
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBarView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 242*Proportion375));
    }];
//    UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1)];
//    topLine.backgroundColor = kSeparationColor;
//    [_topView addSubview:topLine];
    
    UILabel *coinTypeL = [[UILabel alloc]initWithFrame:CGRectMake(16*Proportion375, 0, 50, 44*Proportion375)];
    coinTypeL.text = STRING_WITHDRAW_COINTYPE_44;
    coinTypeL.font = [UIFont systemFontOfSize:16];
    coinTypeL.textColor = kTextWith8b;
    [_topView addSubview:coinTypeL];
    
    UILabel *detailTypeL = [[UILabel alloc]initWithFrame:CGRectMake(145*Proportion375, 0, 50, 44*Proportion375)];
    detailTypeL.textAlignment = NSTextAlignmentLeft;
    detailTypeL.text =self.walletModel.typeCName;
    detailTypeL.font = [UIFont systemFontOfSize:15];
    detailTypeL.textColor = kTextWithF7;
    [_topView addSubview:detailTypeL];
    
    UIView * whiteBG1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44 *Proportion375, kMainScreenWidth, 60*Proportion375)];
    whiteBG1.backgroundColor = kBlackWith1c;
    [_topView addSubview:whiteBG1];
    UITapGestureRecognizer * whiteTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whiteTopClick)];
    [whiteBG1 addGestureRecognizer:whiteTap1];
    
    UILabel *AccountL = [[UILabel alloc]initWithFrame:CGRectMake(16*Proportion375, 0, 150, 60*Proportion375)];
    AccountL.textAlignment = NSTextAlignmentLeft;
    AccountL.text = STRING_WITHDRAW_ADRESS_46;
    AccountL.font = [UIFont systemFontOfSize:16];
    AccountL.textColor = kTextWith8b;
    [whiteBG1 addSubview:AccountL];
    
    _addressNameL = [[UILabel alloc]initWithFrame:CGRectMake(detailTypeL.left, 15*Proportion375, 95, 14*Proportion375)];
    _addressNameL.textAlignment = NSTextAlignmentLeft;
//    addressNameL.text = @"Binantt Jia";
    _addressNameL.font = [UIFont systemFontOfSize:14*Proportion375];
    _addressNameL.textColor = kTextWithF7;
    [whiteBG1 addSubview:_addressNameL];
    
    _addressStrL = [[UILabel alloc]initWithFrame:CGRectMake(detailTypeL.left, 0, 95, 11*Proportion375)];
    _addressStrL.bottom = 60*Proportion375 - 15*Proportion375;
    _addressStrL.textAlignment = NSTextAlignmentLeft;
//    addressStrL.text = @"0xjsksjskskakjs.....................";
    _addressStrL.font = [UIFont systemFontOfSize:11*Proportion375];
    _addressStrL.textColor = kTextWithF7;
    [whiteBG1 addSubview:_addressStrL];
    
    UIButton * codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34*Proportion375, 34*Proportion375)];
    codeBtn.right = kMainScreenWidth - 38*Proportion375;
    codeBtn.centerY = 30*Proportion375;
    [codeBtn setBackgroundImage:[UIImage imageNamed:@"account_WD_scan"] forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.hidden = YES;
    [whiteBG1 addSubview:codeBtn];
    
    UIImageView * arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_arrow_right"]];
    arrowImg.centerY = codeBtn.centerY;
    arrowImg.right = kMainScreenWidth - 14*Proportion375;
    [whiteBG1 addSubview:arrowImg];
    
    
    
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
    withdrawAlltip.right  = kMainScreenWidth - 15*Proportion375;
    withdrawAlltip.textAlignment = NSTextAlignmentRight;
    withdrawAlltip.text = STRING_WITHDRAW_ALL_49;
    withdrawAlltip.font = [UIFont systemFontOfSize:12];
    withdrawAlltip.textColor = kTextWithF7;
    withdrawAlltip.userInteractionEnabled = YES;
    [_topView addSubview:withdrawAlltip];
    
    UIButton * withdrawAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 126*Proportion375, 0, 110*Proportion375, 13)];
    withdrawAllBtn.centerY  = openNumLab2.centerY;
    withdrawAllBtn.backgroundColor = [UIColor clearColor];
    //    [withdrawAllBtn setTitle:STRING_WITHDRAW_ALL_49 forState:UIControlStateNormal];
    //    [withdrawAllBtn setTitleColor:HexRGBAlpha(0x664996, 1) forState:UIControlStateNormal];
    //    withdrawAllBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    withdrawAllBtn.titleLabel.font = Font_Regular(12);
    [[withdrawAllBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        self.numField.text = openNumLab2.text;
    }];
    [_topView addSubview:withdrawAllBtn];
    
}

-(void)creatbottomViews
{
    _slider = [[UISlider alloc] init];
    _slider.minimumValue = 0;
    _slider.maximumValue = 1;
    _slider.value = 0.500;
    [_slider setThumbImage:[UIImage imageNamed:@"wallet_slider_img"] forState:UIControlStateNormal];
    _slider.maximumTrackTintColor = kGrayWith474747;
    _slider.minimumTrackTintColor = kTextWithF7;
    _slider.frame = (CGRect){35,242*Proportion375 + KNaviBarHeight + 30*Proportion375,kScreenWidth - 70,20};
//    [_slider addTarget:self action:@selector(sliderChangeAction:) forControlEvents:UIControlEventTouchUpInside | UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderChangeAction:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel];
    [self.view addSubview:_slider];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
    tapGesture.delegate = self;
    [_slider addGestureRecognizer:tapGesture];
    
    UILabel * tag1 = [UILabel labelWithText:STRING_WITHDRAW_LOW_50 textColor:kTextWith8b font:Font_Regular(11) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    tag1.frame = CGRectMake(35, _slider.bottom+ 10*Proportion375, 50, 11*Proportion375);
    [self.view addSubview:tag1];
    
    UILabel * tag2 = [UILabel labelWithText:STRING_WITHDRAW_NORMAL_51 textColor:kTextWith8b font:Font_Regular(11) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    tag2.frame = CGRectMake(35, _slider.bottom+ 10*Proportion375, 50, 11*Proportion375);
    tag2.centerX = kMainScreenWidth/2;
    [self.view addSubview:tag2];

    UILabel * tag3 = [UILabel labelWithText:STRING_WITHDRAW_HEIGH_52 textColor:kTextWith8b font:Font_Regular(11) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    tag3.frame = CGRectMake(35, _slider.bottom+ 10*Proportion375, 50, 11*Proportion375);
    tag3.right = kMainScreenWidth - 35;
    [self.view addSubview:tag3];

    _numalertL = [UILabel labelWithText:@"" textColor:kTextWith8b font:Font_Regular(15*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    [self.view addSubview:_numalertL];


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
