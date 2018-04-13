//
//  SLMiniCardItem.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMiniCardItem.h"
@interface SLMiniCardItem ()

@property(nonatomic, strong)UILabel *valueLabel;
@property(nonatomic, strong)UILabel *titleLabel;

@end
@implementation SLMiniCardItem


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.valueLabel];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}


-(void)setValue:(NSString *)text
{
   self.valueLabel.text = text;
}
-(void)setTitle:(NSString *)text
{
    self.titleLabel.text = text;
}

#pragma mark - private

-(UILabel*)valueLabel
{
    if (!_valueLabel) {
        CGFloat x = 0, y = 0;
        CGFloat width = self.width, height = self.height/2;
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _valueLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:18];
        _valueLabel.textColor = [UIColor blackColor];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _valueLabel;
}
-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        CGFloat x = 0, y = self.height/2;
        CGFloat width = self.width, height = self.height/2;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
