//
//  SLLiveFinishItem.m
//  ShowLive
//
//  Created by gongxin on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveFinishItem.h"

@interface SLLiveFinishItem ()

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *valueLabel;

@end

@implementation SLLiveFinishItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

-(void)setValue:(NSString *)value
{
    _value = value;
    _valueLabel.text = value;
}

- (void)setTitleColor:(UIColor *)titleColor {

    _titleColor = titleColor;
    self.titleLabel.textColor = _titleColor;
}

- (void)setValueColor:(UIColor *)valueColor {

    _valueColor = valueColor;
    self.valueLabel.textColor = _valueColor;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.width = self.width;
    _valueLabel.width = self.width;
}

-(void)setValueFont:(UIFont*)font
{
    self.valueLabel.font = font;
}

-(void)setTitleFont:(UIFont*)font
{
    self.titleLabel.font = font;
}

#pragma mark - private

-(void)_initView
{
    [self _initValueLabel];
    [self _initTitleLabel];
}

@end
