//
//  SLLoginInviteView.m
//  ShowLive
//
//  Created by chenyh on 2018/8/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLoginInviteView.h"
#import "SLRightTextField.h"
#import "SLQRScanViewController.h"
#import "SLAppMediaPerssion.h"
#import "SLGetInviteInfoAction.h"
#import "SLControlLabel.h"

@interface SLLoginInviteView () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *invLabel;
@property (nonatomic, strong) SLRightTextField *textField;
@property (nonatomic, strong) SLControlLabel *contentLabel;
@property (nonatomic, strong) SLControlLabel *serverLabel;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) SLCheckInviteExistAction *existAction;

@end

@implementation SLLoginInviteView


@end
