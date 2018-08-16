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
