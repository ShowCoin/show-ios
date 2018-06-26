//
//  SLSpringBUtton.m
//  test
//
//  Created by chenyh on 2018/6/26.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLSpringButton.h"

@implementation SLSpringButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self setTitleColor:kThemeWhiteColor forState:UIControlStateSelected];
    [self setTitleColor:kThemeAlphWhiteColor forState:UIControlStateNormal];
    [self.titleLabel setFont:Font_Medium(20 * Proportion375)];
    self.selected = NO;
}

- (void)setHighlighted:(BOOL)highlighted {}


@end
