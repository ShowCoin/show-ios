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
