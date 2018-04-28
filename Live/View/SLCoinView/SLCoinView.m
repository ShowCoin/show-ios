//
//  SLCoinView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLCoinView.h"
#import "NSString+Number.h"
@interface SLCoinView()

@property(nonatomic,strong)UILabel * coinLabel;

@property(nonatomic,strong)UILabel * numberLabel;

@property(nonatomic,copy)NSString * coinString;

@end

@implementation SLCoinView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.numberLabel];
        [self addSubview:self.coinLabel];
 
    }
    return self;
}


-(UILabel*)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 55, 15)];
        _numberLabel.font=[UIFont systemFontOfSize:14];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.layer.shadowRadius = 4.0f;
        _numberLabel.layer.shadowOpacity = 0.5;
        _numberLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        _numberLabel.layer.shadowOffset = CGSizeMake(2, 2);
        _numberLabel.layer.masksToBounds = NO;
    }
    return _numberLabel;
}

-(UILabel*)coinLabel
{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,23, 55.f,15)];
        _coinLabel.font=[UIFont systemFontOfSize:11];
        _coinLabel.textColor = [UIColor whiteColor];
        _coinLabel.textAlignment = NSTextAlignmentCenter;
        _coinLabel.text =@"秀币";
        _coinLabel.layer.shadowRadius = 4.0f;
        _coinLabel.layer.shadowOpacity = 0.5;
        _coinLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        _coinLabel.layer.shadowOffset = CGSizeMake(2, 2);
        _coinLabel.layer.masksToBounds = NO;
    }
    return _coinLabel;
}

-(void)updateCoin:(NSString*)coin
{
    _coinString = coin;
    NSString * text = [NSString stringWithFormat:@"%@",coin];
    self.numberLabel.text = text;

}

-(void)addCoin:(NSInteger)coin
{
    if (_coinString) {
        
        NSInteger ticketCount = [_coinString integerValue];
        NSInteger totalCount = ticketCount + coin;
        [self updateCoin:[NSString stringWithFormat:@"%ld",(long)totalCount]];
    }
 
}


@end
