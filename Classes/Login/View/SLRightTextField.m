//
//  SLRightTextField.m
//  test
//
//  Created by chenyh on 2018/7/10.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLRightTextField.h"
#import "ShowVerifycodeAction.h"

CGFloat const kSLRightTextFieldH = 50;

@interface SLRightTextField ()

@end

/**
 SLRightTextField
 */
@implementation SLRightTextField {
    SLVerificationButton *vButton__;
}

/**
 initWithFrame

 @param frame frame
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = kGrayWith808080;
        self.lineColor = [UIColor blackColor];
        self.showBottomLine = YES;
    }
    return self;
}

/**
 placeholderColor

 @param placeholderColor UIColor
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    if (self.placeholder.length == 0) {
        self.placeholder = @"p";
    }
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    label.textColor = placeholderColor;
}


- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 120, kSLRightTextFieldH);
    label.text = leftTitle;
    label.textColor = [UIColor whiteColor];
    label.font = self.font;
    self.leftView = label;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    [self setNeedsDisplay];
}

- (void)setShowTopLine:(BOOL)showTopLine {
    _showTopLine = showTopLine;
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (self.showBottomLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, 0, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        CGContextSetLineWidth(context, 1);
        [self.lineColor set];
        CGContextStrokePath(context);
    }
    if (self.showTopLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, rect.size.width, 0);
        CGContextSetLineWidth(context, 1);
        [self.lineColor set];
        CGContextStrokePath(context);
    }
}

- (void)sl_getVerifyCodeWithPhone:(NSString *)phone {
    if (self.rightType == SLFieldRightTypeVCode) {
        [SLReportManager reportEvent:kReport_PhoneREG andSubEvent:kReport_PhoneREG_GetVerifiCode];
    }
    [vButton__ sl_getVerifyCodeWithPhone:phone];
}

#pragma mark - Action

- (void)sl_buttonAction:(UIButton *)button {
    if (self.rightType == SLFieldRightTypePwd) {
        button.selected = !button.selected;
        self.secureTextEntry = !button.selected;
        return;
    }
    if (self.rightBlock) {
        self.rightBlock();
    }
}

@end

@interface SLVerificationButton ()
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, strong) ShowVerifycodeAction *action;
@end

@implementation SLVerificationButton{
    int count;
    NSTimer *timer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        //self.backgroundColor = [UIColor orangeColor];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kGrayWith808080;
        [self addSubview:line];
        self.lineView = line;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    [self.titleLabel sizeToFit];
    CGFloat titleW = self.titleLabel.frame.size.width;
    titleW = titleW < 35 ? 35 : titleW;
    CGFloat titleX = w - titleW;
    self.titleLabel.frame = CGRectMake(titleX, 0, titleW, h);
    
    CGFloat lineH = self.titleLabel.font.lineHeight;
    CGFloat lineY = (h - lineH) / 2;
    CGFloat lineX = w - titleW - 15;
    self.lineView.frame = CGRectMake(lineX, lineY, 1, lineH);
}


- (void)sl_timerAction {
    count--;
    if (count == 0) {
        [self setTitle:@"重发" forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        [self sl_destoryTimer];
        return;
    }
    NSString *title = [NSString stringWithFormat:@"%ds", count];
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)sl_destoryTimer {
    [timer invalidate];
    timer = nil;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self sl_destoryTimer];
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
