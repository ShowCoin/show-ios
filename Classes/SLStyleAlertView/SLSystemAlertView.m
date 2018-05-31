//
//  SLSystemAlert.m
//  test
//
//  Created by 陈英豪 on 2018/5/21.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLSystemAlertView.h"

/**
 define color

 @param rgbValue red green blue
 @param a create 0xColor
 @return UIColor
 */
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

/**
 General Gray

 @param 0x999999 vaule
 @param 1 Gray
 @return Gray Color
 */
#define kGrayWith999999         HexRGBAlpha(0x999999, 1)

@interface SLSystemAlertView ()

@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation SLSystemAlertView

+ (instancetype)createAlert:(NSString *)msg {
    SLSystemAlertView *view = [[SLSystemAlertView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.message = msg;
    view.alpha = 0;
    [UIApplication.sharedApplication.windows.firstObject addSubview:view];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.contentView = [UIView new];
        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
        
        self.iconView = [UIImageView new];
        self.iconView.image = [UIImage imageNamed:@"system_header"];
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.iconView];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.text = @"重要通知";
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];
        
        self.messageLabel = [UILabel new];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.textColor = kGrayWith999999;
        self.messageLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.messageLabel];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setTitle:@"知道了" forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.button.backgroundColor = [UIColor blackColor];
        self.button.titleLabel.font = self.titleLabel.font;
        [self.button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat maxW = self.frame.size.width * 0.7;
    CGFloat iconWH = self.titleLabel.font.lineHeight + 28;
    
    CGFloat titleW = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.titleLabel.font.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleLabel.font} context:nil].size.width;
    
    CGFloat iconX = (maxW - titleW - iconWH - 5) / 2;
    CGFloat iconY = 13;
    self.iconView.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
    CGFloat titleX = CGRectGetMaxX(self.iconView.frame) + 5;
    self.titleLabel.frame = CGRectMake(titleX, CGRectGetMinY(self.iconView.frame), titleW, iconWH);
    
    CGFloat msgX = 15;
    CGFloat msgW = maxW - msgX * 2;
    CGFloat msgY = CGRectGetMaxY(self.titleLabel.frame) + 4;
    CGFloat msgH = [self.message boundingRectWithSize:CGSizeMake(msgW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.messageLabel.font} context:nil].size.height;
    self.messageLabel.frame = CGRectMake(msgX, msgY, msgW, msgH);
    
    self.button.frame = CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame) + iconY, maxW, 78 * 0.5);
    
    self.contentView.bounds = CGRectMake(0, 0, maxW, CGRectGetMaxY(self.button.frame));
    self.contentView.center = self.center;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.messageLabel.text = message;
    [self setNeedsLayout];
}

- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self hidden];
//}

- (void)buttonAction {
    [self hidden];
}

- (void)hidden {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
