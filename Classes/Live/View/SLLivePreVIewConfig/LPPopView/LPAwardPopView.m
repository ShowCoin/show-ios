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

@end
