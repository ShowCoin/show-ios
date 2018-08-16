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

+ (void)showAlertMessage:(NSAttributedString *)attr handler:(SLSimpleBlock)handler {
    SLInviteAlertView *alert = [[self alloc] init];
    alert.frame = UIScreen.mainScreen.bounds;
    alert.attr = attr;
    alert.handler = handler;
    alert.alpha = 0;
    [UIApplication.sharedApplication.keyWindow addSubview:alert];
    [UIView animateWithDuration:0.25 animations:^{
        alert.alpha = 1;
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleControl];
        [self.contentView addSubview:self.serveControl];
        [self.contentView addSubview:self.button];
    }
    return self;
}

@end
