//
//  SLInviteViewController.m
//  ShowLive
//
//  Created by vning on 2018/8/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLInviteViewController.h"
#import "SLInviteBottomAView.h"
#import "SLInviteChooseImageView.h"
#import "SLGetInviteInfoAction.h"
#import "SLChangeInviteCodeAction.h"
#import "SLChangeInviteRateAction.h"
#import "SLInviteInfoModel.h"
#import "SLQRTool.h"
#import "NSString+Validation.h"
#import "SLInviteInputViewController.h"

#import "SLInviteInputViewController.h"
#import "SLInvTextView.h"
#define bottomHeight        50*Proportion375
#define MAX_LIMIT_NUMS      16

@interface SLInviteViewController ()<HeadPortraitDelegate,SLInviteBottomAViewDelegate,SLInviteChooseImageViewDelegate,UIGestureRecognizerDelegate,SLInviteInputViewControllerDelegate>
@property (nonatomic, strong)  SLInviteInputViewController * textVC;
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIButton * bottomBtnFir;
@property (nonatomic, strong) UIButton * bottomBtnSec;
@property (nonatomic, strong) UIButton * bottomBtnthr;
@property (nonatomic, strong) UIButton * bottomBtnfour;

@property (nonatomic, strong) UIImageView * ContentView;
@property (nonatomic, strong) UIImageView * BGImgView;
@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) UIImageView * textIcon1;
@property (nonatomic, strong) UIImageView * textIcon2;
@property (nonatomic, strong) SLInviteBottomAView * InviteCodeView;
@property (nonatomic, strong) SLInviteChooseImageView * InviteImageView;

@property (nonatomic, strong) UIView * InviteCodeDragView;
@property (nonatomic, strong) UIView * percentDragView;

//
@property (nonatomic, strong) SLHeadPortrait * headportrait;
@property (nonatomic, strong) UILabel * nameLab;
@property (nonatomic, strong) UILabel * inviteCodeLab;
@property (nonatomic, strong) UILabel * percentLab;
@property (nonatomic, strong) UIImageView * iconImgeView;
@property (nonatomic, strong) UIImageView * codeImageView;
@property (nonatomic, strong) UILabel * codeLab;

@property (nonatomic, strong) SLGetInviteInfoAction * GetInviteInfoAction;
@property (nonatomic, strong) SLChangeInviteCodeAction * ChangeInviteCodeAction;
@property (nonatomic, strong) SLChangeInviteRateAction * ChangeInviteRateAction;
@property (nonatomic, strong) SLInviteInfoModel * inviteModel;

@property (nonatomic, assign) BOOL rate_upload_finish;
@property (nonatomic, assign) BOOL code_upload_finish;

@property (nonatomic, assign) BOOL isTopBottomHide;

@property (nonatomic,assign)  CGFloat ipxSize;
@end

@implementation SLInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [IQKeyboardManager sharedManager].enable = YES;
    _ipxSize = [[NSString stringWithFormat:@"%.2f",kMainScreenHeight*9/19.5/kMainScreenWidth] floatValue];
    self.navigationBarView.hidden = YES;
    self.view.backgroundColor = kBlackWith1c;
    
    self.GetInviteInfoAction = [SLGetInviteInfoAction action];
    @weakify(self);
    self.GetInviteInfoAction.finishedBlock = ^(NSDictionary * dic) {
        @strongify(self);
        self.inviteModel = [SLInviteInfoModel mj_objectWithKeyValues:dic];
        NSLog(@"sss");
        
        self.Invite_code = self.inviteModel.invite_code;
        float a = self.inviteModel.invite_ratio.floatValue;
        float b = self.inviteModel.invite_min_ratio.floatValue;
        self.Invite_ratio = [NSString stringWithFormat:@"%.4f", self.inviteModel.invite_ratio.floatValue == 0?b:a];
        self.Invite_link = [NSString stringWithFormat:@"%@%@",self.inviteModel.invite_link,self.inviteModel.invite_code];
        self.code_upload_finish = self.inviteModel.invite_code_status.integerValue == 1?YES:NO;
        
        [self CreatContentView];
        [self CreattopView];
        [self CreatBottomView];
        [self.view bringSubviewToFront:self.navigationBarView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        
        if (IsStrEmpty(AccountUserInfoModel.invite_FirstTime)) {
            AccountUserInfoModel.invite_FirstTime = @"1";
            [AccountUserInfoModel save];
            [self bottomBtnFirAction:self.bottomBtnFir];
        }

    };
    self.GetInviteInfoAction.failedBlock = ^(NSError *err) {
        
    };
    [self.GetInviteInfoAction start];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [IQKeyboardManager sharedManager].enable = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [IQKeyboardManager sharedManager].enable = NO;

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark---------UI VIEWS-----------

-(void)CreattopView{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, KNaviBarHeight)];
    _topView.backgroundColor = kBlackWith17;
    _topView.alpha = 0.9;
    [self.view addSubview:_topView];
    
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(6, 20+KNaviBarSafeBottomMargin, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"account_navBack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backaction) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:backBtn];
    
    UILabel * label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 20+KNaviBarSafeBottomMargin, kMainScreenWidth, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kTextWithF7;
    label.font = [UIFont systemFontOfSize:18.0f];
    label.text = @"推荐人海报";
    [_topView addSubview:label];
    
}
-(void)CreatContentView
{

    _BGImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenHeight*9/19.5, kMainScreenHeight)];
    _BGImgView.centerX = kMainScreenWidth/2;
    [_BGImgView setImage:[UIImage imageNamed:@"user_set_inviteCode_bg"]];
    _BGImgView.backgroundColor = kBlackWith1c;
    _BGImgView.userInteractionEnabled  = YES;
    _BGImgView.contentMode = UIViewContentModeScaleAspectFill;
    _BGImgView.clipsToBounds = YES;
    [self.view addSubview:_BGImgView];
    
    _ContentView = [[UIImageView alloc] initWithFrame:_BGImgView.bounds];
    [_ContentView setImage:[UIImage imageNamed:@"user_set_inviteCode_Graybg"]];
    _ContentView.contentMode = UIViewContentModeScaleAspectFill;
    _ContentView.clipsToBounds = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_ContentView addGestureRecognizer:tap];
    _ContentView.userInteractionEnabled= YES;
    [_BGImgView addSubview:_ContentView];
    

    UIView * headDragView = [[UIView alloc] initWithFrame:CGRectMake(20*Proportion375 *_ipxSize, 41*Proportion375*_ipxSize, 52*Proportion375*_ipxSize, 52*Proportion375*_ipxSize)];
    headDragView.draggingType = DraggingTypeNormal;
    headDragView.draggingInBounds = NO;
    [_ContentView addSubview:headDragView];
    //frame
    _headportrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(0, 0, 51*Proportion375*_ipxSize, 51*Proportion375*_ipxSize)];
    _headportrait.delegate = self;
    [headDragView addSubview:_headportrait];
    [_headportrait setRoundStyle:YES imageUrl:AccountUserInfoModel.avatar imageHeight:95 vip:NO attestation:NO];

    
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_headportrait.right + 18*Proportion375*_ipxSize, 0, 120*Proportion375, 51*Proportion375*_ipxSize)];
    _nameLab.top = _headportrait.bottom + 8*Proportion375;
    _nameLab.right = _ContentView.width - 6*Proportion375;
    _nameLab.textAlignment = NSTextAlignmentRight;
    _nameLab.font = Font_Regular(18*Proportion375*_ipxSize);
    _nameLab.text = AccountUserInfoModel.nickname;
    [_nameLab sizeToFit];
    _nameLab.left = _headportrait.right + 18*Proportion375*_ipxSize;
    _nameLab.centerY = _headportrait.centerY;
    _nameLab.textColor = kTextWhitef7f7f7;
    [headDragView addSubview:_nameLab];
    
    headDragView.width =headDragView.width + 18*Proportion375*_ipxSize + _nameLab.width + 2*Proportion375*_ipxSize;
    
    
    //虚线框
    _textView = [[SLInvTextView alloc] initWithFrame:CGRectMake(15*Proportion375*_ipxSize, headDragView.bottom + 8*Proportion375*_ipxSize, _ContentView.width - 30*Proportion375*_ipxSize, 85*Proportion375*_ipxSize)];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.font = Font_Medium(25*Proportion375*_ipxSize);
    _textView.backgroundColor = [UIColor clearColor];
    _textView.layer.borderWidth = 0;
    _textView.layer.borderColor = kThemeAlph70WhiteColor.CGColor;
    _textView.textColor = kTextWhitef7f7f7;
    _textView.clipsToBounds = NO;
    _textView.draggingType = DraggingTypeNormal;
    _textView.draggingInBounds = NO;
    _textView.scrollEnabled = NO;
    [_ContentView addSubview:_textView];
    _textView.hidden = NO;
    _textView.userInteractionEnabled = YES;
//    _textView.layoutManager.allowsNonContiguousLayout = NO;
    _textView.text = @"我的直播我做主";
    [_textView sizeToFit];
    _textView.top = headDragView.bottom + 8*Proportion375*_ipxSize;
    _textView.left = 15*Proportion375*_ipxSize;

//    _textView.backgroundColor = kNavigationBGColorALPH;
    UITapGestureRecognizer * textTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTouchAction)];
    [_textView addGestureRecognizer:textTap];
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    rotationGestureRecognizer.delegate = self;
    [_textView addGestureRecognizer:rotationGestureRecognizer];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    pinchGestureRecognizer.delegate = self;
    [_textView addGestureRecognizer:pinchGestureRecognizer];
    

    _textIcon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_poster_imageIcon_1"]];
    [_textView addSubview:_textIcon1];
    [_textIcon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textView.mas_top).with.offset(0);
        make.left.equalTo(self.textView).with.offset(self.textView.width - 11);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    _textIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_poster_imageIcon_2"]];
    [_textView addSubview:_textIcon2];
    [_textIcon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView).with.offset(self.textView.height -11);
        make.left.equalTo(self.textView).with.offset(self.textView.width - 11);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    _textIcon1.hidden = YES;
    _textIcon2.hidden = YES;

    _InviteCodeDragView = [[UIView alloc] initWithFrame:CGRectMake(0, 420*Proportion375, 200*_ipxSize, 59*Proportion375*_ipxSize)];
    _InviteCodeDragView.backgroundColor = HexRGBAlpha(0x0c0c0c, 0.12);
    _InviteCodeDragView.draggingType = DraggingTypeNormal;
    _InviteCodeDragView.draggingInBounds = NO;
    _InviteCodeDragView.layer.cornerRadius = 2*Proportion375;
    [_ContentView addSubview:_InviteCodeDragView];
    UITapGestureRecognizer * InviteCodeDragViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(InviteCodeDragViewTapAction)];
    [_InviteCodeDragView addGestureRecognizer:InviteCodeDragViewTap];

    
    UILabel * inviteLab = [UILabel labelWithFrame:CGRectMake(20*Proportion375*_ipxSize, 10*Proportion375*_ipxSize, 75*Proportion375*_ipxSize, 14*Proportion375*_ipxSize) text:@"我的推荐ID" textColor:kTextWhitef7f7f7alp08 font:Font_Regular(14*Proportion375*_ipxSize)];
    inviteLab.textAlignment = NSTextAlignmentLeft;
    [inviteLab sizeToFit];
    inviteLab.left = 20*Proportion375*_ipxSize;
    inviteLab.top = 10*Proportion375*_ipxSize;
    [_InviteCodeDragView addSubview:inviteLab];
    
    _inviteCodeLab = [[UILabel alloc] initWithFrame:CGRectMake(20*Proportion375*_ipxSize, 29*Proportion375*_ipxSize, 120*Proportion375, 19*Proportion375*_ipxSize)];
    _inviteCodeLab.font = Font_Regular(19*Proportion375*_ipxSize);
    _inviteCodeLab.text = [NSString stringWithFormat:@"%@",self.inviteModel.invite_code];
    _inviteCodeLab.textAlignment = NSTextAlignmentLeft;
    [_inviteCodeLab sizeToFit];
    _inviteCodeLab.top = 29*Proportion375*_ipxSize;
    _inviteCodeLab.left = 20*Proportion375*_ipxSize;
    _inviteCodeLab.textColor = kTextWhitef7f7f7;
    [_InviteCodeDragView addSubview:_inviteCodeLab];
    
    _InviteCodeDragView.width =  _inviteCodeLab.width + 40*Proportion375*_ipxSize;
    
    
    _percentDragView = [[UIView alloc] initWithFrame:CGRectMake(0, _InviteCodeDragView.bottom + 10*Proportion375*_ipxSize, 120*Proportion375, 59*Proportion375*_ipxSize)];
    _percentDragView.backgroundColor = HexRGBAlpha(0x0c0c0c, 0.12);
    _percentDragView.layer.cornerRadius = 2*Proportion375;
    _percentDragView.draggingType = DraggingTypeNormal;
    _percentDragView.draggingInBounds = NO;
    [_ContentView addSubview:_percentDragView];
    UITapGestureRecognizer * percentDragViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(percentDragViewTapAction)];
    [_percentDragView addGestureRecognizer:percentDragViewTap];


    _InviteCodeDragView.width = _InviteCodeDragView.width<_percentDragView.width?_percentDragView.width:_InviteCodeDragView.width;
    UILabel * percentLabT = [UILabel labelWithFrame:CGRectMake(20*Proportion375*_ipxSize, 10*Proportion375*_ipxSize, 75*Proportion375*_ipxSize, 14*Proportion375*_ipxSize) text:@"我的分红比例" textColor:kTextWhitef7f7f7alp08 font:Font_Regular(14*Proportion375*_ipxSize)];
    percentLabT.textAlignment = NSTextAlignmentLeft;
    [percentLabT sizeToFit];
    percentLabT.left = 20*Proportion375*_ipxSize;
    percentLabT.top = 10*Proportion375*_ipxSize;
    [_percentDragView addSubview:percentLabT];

    _percentLab = [[UILabel alloc] initWithFrame:CGRectMake(20*Proportion375*_ipxSize, 29*Proportion375*_ipxSize, 110*Proportion375*_ipxSize, 19*Proportion375*_ipxSize)];
    _percentLab.font = Font_condRegular(19*Proportion375*_ipxSize);
    float a = self.inviteModel.invite_ratio.floatValue*100;
    float b = self.inviteModel.invite_min_ratio.floatValue*100;
    _percentLab.text = [NSString stringWithFormat:@"%.2f%@",self.inviteModel.invite_ratio.floatValue == 0?b:a,@"%"];
    _percentLab.textAlignment = NSTextAlignmentLeft;
    _percentLab.top = 30*Proportion375*_ipxSize;
    _percentLab.left = 20*Proportion375*_ipxSize;
    _percentLab.textColor = kThemeRedColor;
    [_percentDragView addSubview:_percentLab];
    
    

    _iconImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - 98*Proportion375*_ipxSize - 25*Proportion375*_ipxSize , _ContentView.width, 85*Proportion375*_ipxSize)];
    _iconImgeView.contentMode = UIViewContentModeScaleAspectFill;
    if (SysConfig.invite_poster_tips_img_top.length) {
        [_iconImgeView yy_setImageWithURL:[NSURL URLWithString:SysConfig.invite_poster_tips_img_top] placeholder:[UIImage imageNamed:@"candy_logo"]];
    }
    [_ContentView addSubview:_iconImgeView];
    
    
    UIView * CodeWhiteView = [[UIView alloc] initWithFrame:CGRectMake(20*Proportion375*_ipxSize, kMainScreenHeight - 45*Proportion375, 70*Proportion375*_ipxSize, 90*Proportion375*_ipxSize)];
    CodeWhiteView.bottom =kMainScreenHeight - 45*Proportion375*_ipxSize;
    CodeWhiteView.backgroundColor= [UIColor whiteColor];
    CodeWhiteView.layer.cornerRadius = 4*Proportion375;
    [_ContentView addSubview:CodeWhiteView];
    
    _codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3*Proportion375*_ipxSize, 3*Proportion375*_ipxSize, 64*Proportion375*_ipxSize, 64*Proportion375*_ipxSize)];
    _codeImageView.layer.cornerRadius = 4*Proportion375;
    _codeImageView.clipsToBounds = YES;
    _codeImageView.image =[UIImage createNonInterpolatedUIImageFormStr:self.Invite_link type:1];// img;
    [CodeWhiteView addSubview:_codeImageView];
    
    _codeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _codeImageView.bottom + 10*Proportion375*_ipxSize, 120*Proportion375, 11*Proportion375*_ipxSize)];
    _codeLab.font = Font_Regular(11*Proportion375*_ipxSize);
    _codeLab.text = @"扫码下载";
    [_codeLab sizeToFit];
    _codeLab.textColor = kGrayWith676767;
    _codeLab.centerX = _codeImageView.centerX;
    _codeLab.top = _codeImageView.bottom + 4*Proportion375*_ipxSize;
    [CodeWhiteView addSubview:_codeLab];
    
  
    
    _percentDragView.bottom = CodeWhiteView.top - 16*Proportion375*_ipxSize;
    _InviteCodeDragView.bottom = _percentDragView.top -4*Proportion375*_ipxSize;

}
-(void)CreatBottomView{
    [self.view addSubview:self.InviteCodeView];
    
    [self.view addSubview:self.InviteImageView];

    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, bottomHeight + KTabbarSafeBottomMargin)];
    _bottomView.bottom = kMainScreenHeight;
    _bottomView.backgroundColor = HexRGBAlpha(0x171717, 0.9);
    [self.view addSubview:_bottomView];
    
    _bottomBtnFir = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth/4, bottomHeight)];
    [_bottomBtnFir setTitle:@"推荐人" forState:UIControlStateNormal];
    [_bottomBtnFir setTitle:@"推荐人" forState:UIControlStateSelected];
    [_bottomBtnFir setTitleColor:kThemeWhiteColor forState:UIControlStateSelected];
    [_bottomBtnFir setTitleColor:kTextWith8b  forState:UIControlStateNormal];
    [_bottomBtnFir addTarget:self action:@selector(bottomBtnFirAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_bottomBtnFir];
    
    _bottomBtnSec = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/4, 0, kMainScreenWidth/4, bottomHeight)];
    [_bottomBtnSec setTitle:@"背景" forState:UIControlStateNormal];
    [_bottomBtnSec setTitle:@"背景" forState:UIControlStateSelected];
    [_bottomBtnSec setTitleColor:kThemeWhiteColor forState:UIControlStateSelected];
    [_bottomBtnSec setTitleColor:kTextWith8b  forState:UIControlStateNormal];
    [_bottomBtnSec addTarget:self action:@selector(bottomBtnSecAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_bottomBtnSec];

    _bottomBtnthr = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/4*2, 0, kMainScreenWidth/4, bottomHeight)];
    [_bottomBtnthr setTitle:@"文字" forState:UIControlStateNormal];
    [_bottomBtnthr setTitle:@"文字" forState:UIControlStateSelected];
    [_bottomBtnthr setTitleColor:kThemeWhiteColor forState:UIControlStateSelected];
    [_bottomBtnthr setTitleColor:kTextWith8b  forState:UIControlStateNormal];
    [_bottomBtnthr addTarget:self action:@selector(bottomBtnthrAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_bottomBtnthr];

    _bottomBtnfour = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/4*3, 0, kMainScreenWidth/4, bottomHeight)];
    _bottomBtnfour.backgroundColor = kThemeBlueColor;
    [_bottomBtnfour setTitle:@"分享" forState:UIControlStateNormal];
    [_bottomBtnfour setTitleColor:kThemeWhiteColor forState:UIControlStateSelected];
    [_bottomBtnfour addTarget:self action:@selector(bottomBtnFourAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_bottomBtnfour];


}

-(SLInviteBottomAView *)InviteCodeView
{
    if (!_InviteCodeView) {
        _InviteCodeView = [[SLInviteBottomAView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 180*Proportion375)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_InviteCodeView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = _InviteCodeView.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        _InviteCodeView.layer.mask = maskLayer;
        _InviteCodeView.delegate = self;
        _InviteCodeView.inviteModel = self.inviteModel;
        
    }
    return _InviteCodeView;
}
-(SLInviteChooseImageView *)InviteImageView
{
    if (!_InviteImageView) {
        _InviteImageView = [[SLInviteChooseImageView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 217*Proportion375)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_InviteImageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = _InviteImageView.bounds;
        
        maskLayer.path = maskPath.CGPath;
        _InviteImageView.viewControl = self ;
        _InviteImageView.layer.mask = maskLayer;
        _InviteImageView.delegate = self;
    }
    return _InviteImageView;
}

#pragma mark---------gesture delegate-----------
-(void)backaction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textViewTouchAction{
    if (!_bottomBtnthr.selected) {
        [self bottomBtnthrAction:_bottomBtnthr];
    }else{
//        [_textView becomeFirstResponder];
        [self showInputView];
    }
    
        if (_bottomBtnFir.selected) {
            if (_InviteCodeView.textfieldB.isFirstResponder) {
                [_InviteCodeView.textfieldB resignFirstResponder];
            }else if (_InviteCodeView.textfieldA.isFirstResponder){
                [_InviteCodeView.textfieldA resignFirstResponder];
            }else{
                [self bottomBtnFirAction:_bottomBtnFir];
            }
        }
        if (_bottomBtnSec.selected) {
            [self bottomBtnSecAction:_bottomBtnSec];
        }
        if (_bottomBtnfour.selected) {
            //            [self bottomBtnFourAction:_bottomBtnfour];
            _bottomBtnfour.selected = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.BGImgView.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                self.BGImgView.layer.cornerRadius = 0;
                
            }];
            
        }
    
}

- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    
    UIView *view = rotationGestureRecognizer.view;
    
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged)
        
    {
        
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        
        [rotationGestureRecognizer setRotation:0];
        
    }
    
}
// 处理缩放手势

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
