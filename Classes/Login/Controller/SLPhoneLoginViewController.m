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

- (void)setupNavigation {
    self.navigationBarView.backgroundColor = [UIColor clearColor];
    [self.navigationBarView setRightTitle:@"注册新用户" titleColor:[UIColor whiteColor]
                                     font:[UIFont systemFontOfSize:12]];
    [self.navigationBarView sl_adjustPhoneLogin];
    [self.navigationBarView setNavigationLineHidden:YES];
}

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (SLRightTextField *)sl_createTextFieldWithPlaceholder:(NSString *)placeholder {
    SLRightTextField *textField = [[SLRightTextField alloc] init];
    textField.placeholder = placeholder;
    [textField addTarget:self action:@selector(al_textFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:textField];
    return textField;
}

@end
