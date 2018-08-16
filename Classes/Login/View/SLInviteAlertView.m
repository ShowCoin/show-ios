//
//  SLInviteAlertView.m
//  ShowLive
//
//  Created by chenyh on 2018/8/15.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLInviteAlertView.h"
#import "SLControlLabel.h"

FOUNDATION_EXPORT NSAttributedString *SLFuncServerAttributedString(BOOL isAlert);

@interface HIButton : UIButton

@property (nonatomic, strong) UIView *line;

@end

@interface SLInviteAlertView ()

@property (nonatomic, copy) SLSimpleBlock handler;
@property (nonatomic, copy) NSAttributedString *attr;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) SLControlLabel *titleControl;
@property (nonatomic, strong) SLControlLabel *serveControl;
@property (nonatomic, strong) HIButton *button;

@end

@implementation SLInviteAlertView


@end
