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

- (void)layoutSubviews {
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    CGFloat contentW = w * 0.8;
    
    CGFloat titleX = 20;
    CGFloat titleW = contentW - titleX * 2;
    CGFloat titleH = SLFuncGetAttributedStringHeight(self.titleControl.attributedText, titleW);
    CGFloat titleY = 20;
    self.titleControl.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat serveH = SLFuncGetAttributedStringHeight(self.serveControl.attributedText, titleW);
    CGFloat serveY = CGRectGetMaxY(self.titleControl.frame) + 4;
    self.serveControl.frame = CGRectMake(titleX, serveY, titleW, serveH);
    
    CGFloat buttonY = CGRectGetMaxY(self.serveControl.frame) + 21;
    CGFloat buttonH = 44;
    self.button.frame = CGRectMake(0, buttonY, contentW, buttonH);
    
    CGFloat contentH = CGRectGetMaxY(self.button.frame);
    self.contentView.bounds = CGRectMake(0, 0, contentW, contentH);
    self.contentView.center = CGPointMake(w / 2, h / 2);
}

@end

@implementation HIButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"确定" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.line];
    }
    return self;
}

@end
