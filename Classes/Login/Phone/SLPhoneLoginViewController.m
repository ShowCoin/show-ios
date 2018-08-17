//
//  SLPhoneLoginViewController.m
//  ShowLive
//
//  Created by chenyh on 2018/7/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPhoneLoginViewController.h"
#import "SLPhoneRegisterViewController.h"
#import "SLRightTextField.h"
#import "NSString+MD5.h"
#import "SLConfirmButton.h"

/**
 SLPhoneLoginViewController
 */
@interface SLPhoneLoginViewController () <ShowNavigationBarDelegate, UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *loginLabel;
@property (nonatomic, weak) SLRightTextField *phoneField;
@property (nonatomic, weak) SLRightTextField *pwdField;
@property (nonatomic, weak) UIButton *forgetButton;
@property (nonatomic, weak) UIButton *loginButton;

@end

@implementation SLPhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self setupUI];
}

/**
 setupNavigation
 */
- (void)setupNavigation {
    self.navigationBarView.backgroundColor = [UIColor clearColor];
    [self.navigationBarView setRightTitle:@"注册新用户" titleColor:[UIColor whiteColor]
                                     font:[UIFont systemFontOfSize:12]];
    [self.navigationBarView sl_adjustPhoneLogin];
    [self.navigationBarView setNavigationLineHidden:YES];
}

/**
 setupUI
 */
- (void)setupUI {
    self.view.backgroundColor = kBlackThemeBGColor;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"login_background"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view insertSubview:imageView atIndex:0];
    self.imageView = imageView;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"登录";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:label];
    self.loginLabel = label;
    
    SLRightTextField *textField = [self sl_createTextFieldWithPlaceholder:@"请输入手机号"];
    textField.showTopLine = YES;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    textField.lineColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.phoneField = textField;
    
    textField = [self sl_createTextFieldWithPlaceholder:@"密码"];
    textField.rightType = SLFieldRightTypePwd;
    textField.lineColor = [UIColor colorWithWhite:1 alpha:0.2];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    self.pwdField = textField;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(sl_forgetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.forgetButton = button;
    
    button = [SLConfirmButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sl_loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.loginButton = button;
    
#if kCYHTestCode
    
    button.enabled = YES;
    self.phoneField.text = @"18612573593";
    self.pwdField.text   = @"A12334@zz";
    
#endif
}

/**
 viewWillLayoutSubviews
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    self.imageView.frame = CGRectMake(0, 0, w, h);
    
    CGFloat labelY = h * 0.4;
    self.loginLabel.frame = CGRectMake(0, labelY, w, self.loginLabel.font.lineHeight);
    
    CGFloat kMargin = 15;
    CGFloat maxW = w - kMargin * 2;
    CGFloat phoneY = CGRectGetMaxY(self.loginLabel.frame) + 8;
    self.phoneField.frame = CGRectMake(kMargin, phoneY, maxW, kSLRightTextFieldH*Proportion375);
    CGFloat pwdY = CGRectGetMaxY(self.phoneField.frame);
    self.pwdField.frame = CGRectMake(kMargin, pwdY, maxW, kSLRightTextFieldH*Proportion375);
    
    CGFloat forgetW = 70;
    CGFloat forgetX = w - forgetW - kMargin;
    CGFloat forgetY = CGRectGetMaxY(self.pwdField.frame);
    CGFloat forgetH = self.forgetButton.titleLabel.font.lineHeight + 20 * 2;
    self.forgetButton.frame = CGRectMake(forgetX, forgetY, forgetW, forgetH);
    
    CGFloat loginY = CGRectGetMaxY(self.forgetButton.frame) + 32;
    self.loginButton.frame = CGRectMake(kMargin, loginY, maxW, kSLConfirmButtonH);
}

/**
 touchesBegan

 @param touches touches
 @param event event
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/**
 sl_createTextFieldWithPlaceholder

 @param placeholder <#placeholder description#>
 @return SLRightTextField
 */
- (SLRightTextField *)sl_createTextFieldWithPlaceholder:(NSString *)placeholder {
    SLRightTextField *textField = [[SLRightTextField alloc] init];
    textField.placeholder = placeholder;
    [textField addTarget:self action:@selector(al_textFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:textField];
    return textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.pwdField == textField) {
        [self sl_loginAction];
    }
    return YES;
}

#pragma mark - Action

- (void)al_textFieldTextDidChange:(UITextField *)textField {
    if (self.phoneField.text.length > kPhoneMaxLength) {
        self.phoneField.text = [self.phoneField.text substringToIndex:kPhoneMaxLength];
    }
    if (self.pwdField.text.length > kPasswordMaxLength) {
        self.pwdField.text = [self.pwdField.text substringToIndex:kPasswordMaxLength];
    }
    if (self.phoneField.text.length > 0 && self.pwdField.text.length > 0) {
        self.loginButton.enabled = YES;
        self.loginButton.backgroundColor = HexRGBAlpha(0x1e1e1e, 1);
    } else {
        self.loginButton.enabled = NO;
        self.loginButton.backgroundColor = HexRGBAlpha(0x333333, 1);
    }
}

- (void)sl_forgetAction {
    [SLReportManager reportEvent:kReport_PhoneLogin andSubEvent:kReport_PhoneLogin_ForgetPWD];
    [HDHud sl_showRedTextInView:self.view title:@"忘记密码，敬请期待"];

}

- (void)sl_loginAction {
    [self.view endEditing:YES];
    
    [SLReportManager reportEvent:kReport_PhoneLogin andSubEvent:kReport_PhoneLogin_Login];
    NSString *phone = self.phoneField.text;
    NSString *pwd = self.pwdField.text;
    if (![phone isValidPhone]) {
        [HDHud sl_showRedTextInView:self.view title:@"请输入正确手机号"];
        return;
    }
    NSString *md5 = [NSString MD5AndSaltString:pwd];
    [LoginManager.manager phoneLogin:phone password:md5 currentController:self];
}

- (void)clickRightButton:(UIButton *)sender {
    [SLReportManager reportEvent:kReport_PhoneLogin andSubEvent:kReport_PhoneLogin_Register];
    SLPhoneRegisterViewController *vc = [[SLPhoneRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)clickLeftButton:(UIButton *)sender {
//    NSLog(@"[xx] -- %s", __func__);
//    [SLReportManager reportEvent:kReport_PhoneLogin andSubEvent:kReport_PhoneLogin_Return];
//}

@end
