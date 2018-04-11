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

@property(nonatomic,strong)UIView * bgView;

@property(nonatomic,strong)UILabel * numberLabel;

@property(nonatomic,strong)UIImageView * ticketImageView;

@property(nonatomic,strong)UIImageView * arrowImageView;

@end

@implementation SLCoinView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        [self addSubview:self.ticketImageView];
        [self addSubview:self.numberLabel];
        [self addSubview:self.arrowImageView];
    }
    return self;
}

-(UIView*)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.width, 17)];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 8.5;
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _bgView;
}

-(UIImageView*)ticketImageView
{
    if (!_ticketImageView) {
        _ticketImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9.f, 13.f, 16, 11.f)]; //15
        _ticketImageView.image = [UIImage imageNamed:@"sl_live_coin"];
    }
    return _ticketImageView;
}

-(UILabel*)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.ticketImageView.frame)+5, 10, 30.f, 17)];
        _numberLabel.font=[UIFont systemFontOfSize:12];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

-(UIImageView*)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 6.f - 12.f, 0, 12.f,self.height)];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        _arrowImageView.image = [UIImage imageNamed:@"sl_live_into"];
    }
    return _arrowImageView;
}


- (void)updateViewWithUserId:(NSString *)uid
{
    NSLog(@"[gx] 拉取钱包接口");
}

-(void)updateTicketWithCount:(NSInteger)count
{

    NSString * text = [NSString stringWithFormat:@"%ld",count];
    self.numberLabel.text = text;
    [self.numberLabel sizeToFit];
    
    CGFloat width = self.numberLabel.width;
    [self updatUIWithMoneyWidth:width];
}

-(void)addTicketWithCount:(NSInteger)count
{
    NSInteger ticketCount = [self.numberLabel.text integerValue];
    NSInteger totalCount = ticketCount + count;
    NSString * text = [NSString getStringWithNumber:totalCount];
    self.numberLabel.text = text;

}
-(void)updatUIWithMoneyWidth:(CGFloat)width
{
    
    CGFloat dwidth = self.width - (9 + 16 + 6 + 6 + 12);
    
    if (width<dwidth) {
        self.numberLabel.width = width;
        
    }else
    {
        self.width            += width - dwidth;
        self.bgView.width = self.width;
        self.numberLabel.width    = width;
        self.arrowImageView.mj_x += width - dwidth;
        
    }
    
}
@end
