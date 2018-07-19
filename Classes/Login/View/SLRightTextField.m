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

@implementation SLRightTextField {
    SLVerificationButton *vButton__;
}

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

@end
