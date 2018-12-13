//
//  ShowAddAddressViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAddAddressViewController.h"
#import "ShowAddressTextCell.h"
#import "SLAddWithdrawAddressAction.h"
#import "ShowVerifycodeAction.h"

@interface ShowAddAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)UIButton * sureButton;
@property (nonatomic, copy)NSString * walletName;
@property (nonatomic, copy)NSString * walletAddress;

@property (nonatomic, copy)NSString * walletPassword;
@property (nonatomic, copy)NSString * googlePassword;
@property (nonatomic, copy)NSString * messagePassword;
@property (nonatomic, copy)NSString * emailPassword;
@property (nonatomic, assign)BOOL  walletVerify;
@property (nonatomic, strong)SLAddWithdrawAddressAction * addWithdrawAddressAction;
@property (nonatomic, strong)ShowVerifycodeAction * getVerifyAction;

@end

@implementation ShowAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationTitle:@"添加地址"];
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    [self configSubView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [IQKeyboardManager sharedManager].enable = NO;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [IQKeyboardManager sharedManager].enable = YES;

}
- (void)configSubView{
    [self.view addSubview:self.tableView];
}
- (UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        _sureButton.clipsToBounds = YES;
        _sureButton.frame = CGRectMake(15*Proportion375, 20, kMainScreenWidth-30*Proportion375, 45*Proportion375);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
//        [_sureButton setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
//        [_sureButton setBackgroundImage:[UIImage imageNamed:@"wallet_withdraw_sure"] forState:UIControlStateNormal];
        [_sureButton setBackgroundImage:[UIImage imageNamed:@"wallet_withdraw_nomal"] forState:UIControlStateNormal];
        [_sureButton setTitleColor:kThemeWhiteColor  forState:UIControlStateNormal];
        _sureButton.userInteractionEnabled = NO;
//        [_sureButton roundHeightStyle];
        [_sureButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth, kMainScreenHeight - kNaviBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =kThemeWhiteColor;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kSeparationColor;

    }
    return _tableView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 100*Proportion375)];
    [view addSubview:self.sureButton];
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(15*Proportion375, 0, kMainScreenWidth - 15*Proportion375, 0.5)];
    line.backgroundColor = kSeparationColor;
    [view addSubview:line];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100*Proportion375;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        return 100*WScale ;
    }else if (self.walletVerify){
        return 50*WScale;

    }else{
        if (indexPath.row == 4) {
//            if (indexPath.row == 4 || indexPath.row == 5) {
            return 0;
        }else{
            return 50*WScale;
        }
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"ShowAddressTextCell";
    ShowAddressTextCell * settingCell=[tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!settingCell) {
        settingCell = [[ShowAddressTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        settingCell.backgroundColor = [UIColor clearColor];
        settingCell.selectionStyle = UITableViewCellSelectionStyleNone;
        settingCell.accessoryType = UITableViewCellAccessoryNone;
        
//    }
    switch (indexPath.row) {
        case 0:
            settingCell.titlelabel.frame = CGRectMake(0, 16*Proportion375, kMainScreenWidth, 18*Proportion375);
            settingCell.titlelabel.text = self.walletModel.typeCName;
            settingCell.titlelabel.font = Font_Regular(18*Proportion375);
            settingCell.titlelabel.textAlignment = NSTextAlignmentCenter;
            break;
        case 1:
        {
            settingCell.titlelabel.text = @"名称";
            [settingCell.contentView addSubview:settingCell.name];
            @weakify(self)
            settingCell.nameBlock = ^(NSString *name) {
                @strongify(self)
                self.walletName = name;
            };
        }
            break;
        case 2:
        {
            settingCell.titlelabel.text = @"提现地址/账户";
            [settingCell.contentView addSubview:settingCell.address];
            @weakify(self)
            settingCell.addressbBlock = ^(NSString *address) {
                @strongify(self)
                self.walletAddress = address;
//                self.sureButton.enabled = YES;
                if (!IsStrEmpty(self.messagePassword) && !IsStrEmpty(self.walletAddress)) {
                    [self.sureButton setBackgroundImage:[UIImage imageNamed:@"wallet_withdraw_sure"] forState:UIControlStateNormal];
                    [self.sureButton setTitleColor:kThemeWhiteColor  forState:UIControlStateNormal];
                    self.sureButton.userInteractionEnabled = YES;
                    
                }
            };
        }
            break;
        case 3:
        {
            settingCell.titlelabel.text = @"短信验证码";
            [settingCell.contentView addSubview:settingCell.password];
            [settingCell.contentView addSubview:settingCell.sendCodeBtn];
//            settingCell.password.keyboardType = UIKeyboardTypeASCIICapable;
            @weakify(self)
            settingCell.sendCodeBlock = ^(BOOL on) {
                @strongify(self)

                if (self.getVerifyAction ) {
                    [self.getVerifyAction cancel];
                    self.getVerifyAction = nil;
                }
                [HDHud showHUDInView:self.view title:@""];
                self.getVerifyAction = [ShowVerifycodeAction action];
                self.getVerifyAction.type = @"add_withdraw_address";
                self.getVerifyAction.mode = @"phone";
                @weakify(self)
                self.getVerifyAction.finishedBlock = ^(id result) {
                    @strongify(self)
                    [HDHud hideHUDInView:self.view];
                    //  初始化用户单例
                };
                self.getVerifyAction.failedBlock = ^(NSError *error) {
                    @strongify(self)
                    [HDHud hideHUDInView:self.view];
                    [HDHud showMessageInView:self.view title:error.userInfo[@"msg"]];

                };
                [self.getVerifyAction start];

            };
            settingCell.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"短信验证码" attributes:@{NSFontAttributeName: Font_Regular(15*Proportion375)}];
            
            settingCell.passwordBlock = ^(NSString *password) {
                @strongify(self)
                self.messagePassword = password;
                if (!IsStrEmpty(self.messagePassword) && !IsStrEmpty(self.walletAddress)) {
                    [self.sureButton setBackgroundImage:[UIImage imageNamed:@"wallet_withdraw_sure"] forState:UIControlStateNormal];
                    [self.sureButton setTitleColor:kThemeWhiteColor  forState:UIControlStateNormal];
                    self.sureButton.userInteractionEnabled = YES;

                }
            };
        }
            break;
//        case 4:
//        {
//            settingCell.titlelabel.text = @"谷歌验证码";
//            [settingCell.contentView addSubview:settingCell.password];
//            settingCell.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"谷歌验证码" attributes:@{NSFontAttributeName: Font_Regular(15*Proportion375)}];
//
//            @weakify(self)
//            settingCell.passwordBlock = ^(NSString *password) {
//                @strongify(self)
//                self.googlePassword = password;
//            };
//        }
//            break;
//        case 4:
//        {
//            if (self.walletVerify) {
//
//                settingCell.titlelabel.text = @"邮箱验证码";
//                [settingCell.contentView addSubview:settingCell.password];
//                [settingCell.contentView addSubview:settingCell.sendCodeBtn];
//                @weakify(self)
//                settingCell.sendCodeBlock = ^(BOOL on) {
//                    @strongify(self)
//                    if (self.getVerifyAction ) {
//                        [self.getVerifyAction cancel];
//                        self.getVerifyAction = nil;
//                    }
//                    [HDHud showHUDInView:self.view title:@""];
//                    self.getVerifyAction = [ShowVerifycodeAction action];
//                    self.getVerifyAction.type = @"add_withdraw_address";
//                    self.getVerifyAction.mode = @"email";
//                    @weakify(self)
//                    self.getVerifyAction.finishedBlock = ^(id result) {
//                        @strongify(self)
//                        [HDHud hideHUDInView:self.view];
//                        //  初始化用户单例
//                    };
//                    self.getVerifyAction.failedBlock = ^(NSError *error) {
//                        @strongify(self)
//                        [HDHud hideHUDInView:self.view];
//                    };
//                    [self.getVerifyAction start];
//
//                };
//                settingCell.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"邮箱验证码" attributes:@{NSFontAttributeName: Font_Regular(15*Proportion375)}];
//            }else{
//                [settingCell removeAllSubviews];
//            }
//            @weakify(self)
//            settingCell.passwordBlock = ^(NSString *password) {
//                @strongify(self)
//                self.emailPassword = password;
//            };
//        }
//            break;
        case 4:
        {
            if (self.walletVerify) {
            
                settingCell.titlelabel.text = @"资金密码";
                [settingCell.contentView addSubview:settingCell.password];
                settingCell.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"资金密码" attributes:@{NSFontAttributeName: Font_Regular(15*Proportion375)}];
            }else{
                [settingCell removeAllSubviews];
            }
            
            @weakify(self)
            settingCell.passwordBlock = ^(NSString *password) {
                @strongify(self)
                self.walletPassword = password;
            };
        }
            break;
        case 5:
        {
            settingCell.titlelabel.width = kMainScreenWidth -170*Proportion375;
            settingCell.titlelabel.text = @"将该账户设置为认证账户";
            [settingCell.contentView addSubview:settingCell.bottomLabel];
            settingCell.bottomLabel.width = kMainScreenWidth -110*Proportion375;
            settingCell.bottomLabel.textAlignment = NSTextAlignmentLeft;
            settingCell.bottomLabel.text = @"向认证账户提现将不用再输入资金密码、短信验证码以及谷歌验证";
            [settingCell.contentView addSubview:settingCell.certificationSwitch];
            settingCell.certificationSwitch.on = self.walletVerify;
            @weakify(self)
            settingCell.switchBlock = ^(BOOL on) {
                @strongify(self)
                self.walletVerify = on;
                
                NSIndexPath *tmpPath1 = [NSIndexPath indexPathForRow:4 inSection:0];
//                NSIndexPath *tmpPath2 = [NSIndexPath indexPathForRow:5 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:tmpPath1, nil] withRowAnimation:UITableViewRowAnimationFade];
            };
            settingCell.certificationSwitch.top = 40*Proportion375;
            settingCell.lineView.top = 99.5*Proportion375;
        }
            break;
            
    }
    return settingCell;
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
