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

@end
