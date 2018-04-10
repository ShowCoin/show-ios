//
//  ShowLoginViewController.m
//  ShowLive
//
//  Created by 周华 on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowLoginViewController.h"
#define buttonInterval (kMainScreenWidth -80*Proportion375- 45*Proportion375*4)/3

@interface ShowLoginViewController ()
@property (nonatomic, strong) UIImageView * logoImg;
@property (nonatomic, strong) UIButton *wechatButton;
@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) UIButton *QQButton;
@property (nonatomic, strong) UIButton *sinaButton;
@property (nonatomic, strong) UIButton *protocolButton;
@property (nonatomic, strong) UILabel * wayLabel;

@end

@implementation ShowLoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationBarView setNavigationBarHidden:YES animted:NO] ;
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationBarView setNavigationBarHidden:NO animted:NO] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}
-(void)setupView
{
    
}
-(void)setupViews
{
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.wayLabel];
    [self.view addSubview:self.wechatButton];
    [self.view addSubview:self.phoneButton];
    [self.view addSubview:self.QQButton];
    [self.view addSubview:self.sinaButton];
    [self.view addSubview:self.protocolButton];
    
    self.logoImg.frame = (CGRect){0,0,kScreenWidth,kScreenHeight};
    self.protocolButton.frame = (CGRect){0,kScreenHeight - 20 -14-KBottomHeight,kScreenWidth,14};
}
-(UILabel*)wayLabel
{
    if(!_wayLabel)
    {
        _wayLabel = [UILabel labelWithFrame: CGRectMake(kMainScreenWidth/2-50,kMainScreenHeight-115*WScale-KBottomHeight, 100, 14*WScale) text:@"选择登录方式" textColor:HexRGBAlpha(0xfffefe,1) font:[UIFont fontWithName:KTitleFont size:14*WScale] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _wayLabel;
}
-(UIButton*)wechatButton
{
    if (!_wechatButton) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = (CGRect){40*Proportion375,kMainScreenHeight-86*Proportion375-KBottomHeight ,45*Proportion375,45*Proportion375};
        [button setBackgroundImage:[UIImage imageNamed:@"login_WX"] forState:UIControlStateNormal];
        _wechatButton = button;
    }
    [[_wechatButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    return _wechatButton;
}

-(UIImageView *)logoImg{
    if (!_logoImg) {
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:self.view.frame];
        imageview.image = [UIImage imageNamed: @"login_bg"];
        _logoImg = imageview;
    }
    return _logoImg;
}


-(UIButton*)phoneButton
{
    if (!_phoneButton) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = (CGRect){_wechatButton.right + buttonInterval,kMainScreenHeight-86*Proportion375-KBottomHeight ,45*Proportion375,45*Proportion375};
        [button setBackgroundImage:[UIImage imageNamed:@"login_phone"] forState:UIControlStateNormal];
        _phoneButton = button;
    }
    [[_phoneButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    return _phoneButton;
}

-(UIButton*)protocolButton
{
    if (!_protocolButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"登录即代表同意 SHOW服务和隐私条款" forState:UIControlStateNormal];
        [button setTitleColor:Color(@"ffffff") forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:KTitleFont size:12*WScale];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"登录即代表同意 SHOW服务和隐私条款"];
        NSRange strRange = {str.length-11,11};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [str addAttribute:NSForegroundColorAttributeName value:kThemeYellowColor range:strRange];
        [button setAttributedTitle:str forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        _protocolButton = button;
    }
    [[_protocolButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    return _protocolButton;
}

-(UIButton *)QQButton{
    if (!_QQButton) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = (CGRect){_phoneButton.right + buttonInterval,kMainScreenHeight-86*Proportion375-KBottomHeight ,45*Proportion375,45*Proportion375};
        [button setBackgroundImage:[UIImage imageNamed:@"login_QQ"] forState:UIControlStateNormal];
        _QQButton = button;
    }
    [[_QQButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    return _QQButton;
}
-(UIButton *)sinaButton{
    if (!_sinaButton) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = (CGRect){_QQButton.right + buttonInterval,kMainScreenHeight-86*Proportion375-KBottomHeight ,45*Proportion375,45*Proportion375};
        [button setBackgroundImage:[UIImage imageNamed:@"login_sina"] forState:UIControlStateNormal];
        _sinaButton = button;
    }
    [[_sinaButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];

    return _sinaButton;
}
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
