//
//  LPAwardPopView.m
//  Edu
//
//  Created by chenyh on 2018/9/20.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "LPAwardPopView.h"

@interface LPAwardPopView ()

@property (nonatomic, strong) LPAwardButton *coinButton;
@property (nonatomic, strong) LPAwardButton *randomButton;
@property (nonatomic, strong) UIButton *explainButton;

@end

@implementation LPAwardPopView {
    UIButton *select_;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.coinButton];
        [self addSubview:self.randomButton];
        [self addSubview:self.explainButton];
        [self sl_selectType:LPAwardTypeCoin];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    CGFloat viewW = w / 2;
    CGFloat viewX = 0;
    CGFloat viewH = kLPSmallViewH;
    CGFloat viewY = 0;
    self.coinButton.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    viewX = CGRectGetMaxX(self.coinButton.frame);
    viewY = 0;
    viewW = viewW;
    viewH = viewH;
    self.randomButton.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    viewX = 0;
    viewY = CGRectGetMaxY(self.coinButton.frame);
    viewW = w;
    viewH = h - CGRectGetHeight(self.coinButton.frame);
    self.explainButton.frame = CGRectMake(viewX, viewY, viewW, viewH);
}

#pragma mark - Method

- (void)buttonAction:(LPAwardButton *)button {
    select_.selected = NO;
    button.selected = YES;
    select_ = button;
    if (self.popBlock) {
        self.popBlock(button.type);
    }
}

- (void)explainAction {
    [HDHud showMessageInView:self title:@"敬请期待"];
}

- (void)sl_selectType:(LPAwardType)type {
    select_.selected = NO;
    if (type == LPAwardTypeCoin) {
        select_ = self.coinButton;
    } else if (type == LPAwardTypeRandom) {
        select_ = self.randomButton;
    }
    select_.selected = YES;
}

#pragma mark - Life

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [LPLineColor() set];
    CGFloat x = rect.size.width / 2;
    CGContextMoveToPoint(context, x, 0);
    CGContextAddLineToPoint(context, x, kLPSmallViewH);
    CGContextSetLineWidth(context, 1);
    
    CGRect bounds = CGRectMake(0, 0, rect.size.width, kLPSmallViewH);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:bounds];
    CGContextAddPath(context, path.CGPath);
    
    CGContextStrokePath(context);
}

#pragma mark - lazy

- (LPAwardButton *)coinButton {
    if (!_coinButton) {
        _coinButton = [LPAwardButton buttonWithType:UIButtonTypeCustom];
        _coinButton.type = LPAwardTypeCoin;
        [_coinButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coinButton;
}

@end
