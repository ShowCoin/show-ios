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

@end
