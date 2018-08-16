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

inline NSAttributedString *SLFuncInvitaAttributedString(NSString *text, NSString *r, BOOL isAlert) {
    NSString *aText = [NSString stringWithFormat:@"邀请您注册SHOW 的用户名为: %@，使用此邀请码，意味着您在SHOW直播的收入的%@%%定期奖励给 “%@”", text, r, text];
    NSString *bText = @"。不可更改不可取消。";
    NSString *fText = [NSString stringWithFormat:@"%@%@", aText, bText];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 4;
    
    UIColor *wColor = isAlert ? [UIColor blackColor] : kGrayWith676767;
    UIColor *sColor = isAlert ? [UIColor blueColor] : kBlackThemetextColor;

    UIFont *font = isAlert ? [UIFont systemFontOfSize:14] : [UIFont systemFontOfSize:12];
    
    NSDictionary *aDict = @{NSFontAttributeName : font,
                            NSForegroundColorAttributeName : wColor,
                            NSParagraphStyleAttributeName : style,
                            };
    NSMutableAttributedString *aAttr = [[NSMutableAttributedString alloc] initWithString:fText attributes:aDict];
    
    NSDictionary *nDict = @{NSFontAttributeName : font,
                            NSForegroundColorAttributeName : sColor,
                            NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]
                            };
    NSUInteger len = text.length + 2;
    NSUInteger loc = fText.length - bText.length - len;
    [aAttr addAttributes:nDict range:NSMakeRange(loc, len)];
    
    return aAttr;
}

inline NSAttributedString *SLFuncServerAttributedString(BOOL isAlert) {
    
    NSString *text = @"注册即您同意分成协议。";
    
    UIColor *wColor = isAlert ? [UIColor blackColor] : kGrayWith676767;
    UIColor *sColor = isAlert ? [UIColor blueColor] : kBlackThemetextColor;

    UIFont *font = isAlert ? [UIFont systemFontOfSize:14] : [UIFont systemFontOfSize:12];

    NSDictionary *dict = @{NSFontAttributeName : font,
                           NSForegroundColorAttributeName : wColor,
                           };
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text attributes:dict];
    
    dict = @{NSForegroundColorAttributeName : sColor,
             NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]
             };
    
    NSUInteger len = 4;
    NSUInteger loc = text.length - len - 1;
    [attr addAttributes:dict range:NSMakeRange(loc, len)];
    
    return attr;
}

@interface SLLoginInviteView () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *invLabel;
@property (nonatomic, strong) SLRightTextField *textField;
@property (nonatomic, strong) SLControlLabel *contentLabel;
@property (nonatomic, strong) SLControlLabel *serverLabel;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) SLCheckInviteExistAction *existAction;

@end

@implementation SLLoginInviteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.invLabel];
    [self addSubview:self.textField];
    [self addSubview:self.button];
    [self addSubview:self.contentLabel];
    [self addSubview:self.serverLabel];
    
    _inviteCode = @"胡震生";
    _inviteRatio = @"1";
    self.textField.text = self.inviteCode;
    [NSUserDefaults.standardUserDefaults setObject:self.inviteCode forKey:kSLInviteCodeKey];
    self.contentLabel.attributedText = SLFuncInvitaAttributedString(_inviteCode, _inviteRatio, NO);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = CGRectGetWidth(self.frame);
    
    CGFloat margin = 42;
    CGFloat maxW = w - margin * 2;
    
    self.invLabel.frame = CGRectMake(margin, 0, maxW, self.invLabel.font.lineHeight);
    
    CGFloat fieldY = CGRectGetMaxY(self.invLabel.frame) + 14;
    CGFloat fieldH = kSLRightTextFieldH;
    self.textField.frame = CGRectMake(margin, fieldY, maxW, fieldH);
    
    CGFloat buttonWH = 33;
    CGFloat buttonY = CGRectGetMinY(self.textField.frame) + (fieldH - buttonWH) / 2;
    CGFloat buttonX = CGRectGetMaxX(self.textField.frame) - buttonWH;
    self.button.frame = CGRectMake(buttonX, buttonY, buttonWH, buttonWH);
    
    CGFloat tipY = CGRectGetMaxY(self.textField.frame) + 16;
    CGFloat tipH = SLFuncGetAttributedStringHeight(self.contentLabel.attributedText, maxW);
    self.contentLabel.frame = CGRectMake(margin, tipY, maxW, tipH);
    
    CGFloat serY = CGRectGetMaxY(self.contentLabel.frame) + 4;
    CGFloat serH = SLFuncGetAttributedStringHeight(self.serverLabel.attributedText, maxW);
    self.serverLabel.frame = CGRectMake(margin, serY, maxW, serH);
}


@end
