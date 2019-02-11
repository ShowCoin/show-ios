//
//  ShowAccountExchangView.m
//  ShowLive
//
//  Created by iori_chou on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAccountExchangeView.h"

@implementation ShowAccountExchangeView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backimage];
        [self addSubview:self.namelabel];
        [self addSubview:self.ethLabel];
        [self addSubview:self.RmbLabel];
        [self addSubview:self.coverBtn];
        
    
    }
    return self;
}

-(UILabel*)namelabel
{
    if (!_namelabel) {
        _namelabel = [UILabel labelWithFrame:CGRectMake(0, 0,  self.width, 46*Proportion375) text:@"" textColor:kThemeWhiteColor font:Font_Regular(14*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        
    }
    return _namelabel;
}
-(UILabel*)ethLabel
{
    if (!_ethLabel) {
        _ethLabel = [UILabel labelWithFrame:CGRectMake(0, 55*Proportion375, self.width, 10*Proportion375) text:@"0.00067 以太" textColor:kthemeBlackColor font:Font_Regular(12*WScale) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        
    }
    return _ethLabel;
}
-(UILabel*)RmbLabel
{
    if (!_RmbLabel) {
        _RmbLabel = [UILabel labelWithFrame:CGRectMake(0, self.height + 5*Proportion375, self.width, 10*Proportion375) text:@"" textColor:Color(@"999999") font:Font_Regular(12*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        
    }
    return _RmbLabel;
}
- (UIImageView*)backimage{
    if (!_backimage) {
        _backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _backimage.image = [UIImage imageNamed:@"account_coinBg"];
        _backimage.backgroundColor = [UIColor clearColor];
    }
    return _backimage;
}
-(UIButton *)coverBtn
{
    if (!_coverBtn) {
        _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _coverBtn.frame = CGRectMake(0, 0, self.width, self.height);
        [_coverBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return _coverBtn;
}
-(void)setPay_config:(NSDictionary *)pay_config
{
    _namelabel.text=[NSString stringWithFormat:@"%@ 秀币",pay_config[@"show_number"]?:@"0"];
    _ethLabel.text=[NSString stringWithFormat:@"%@ 以太",pay_config[@"eth_number"]?:@"0"];
    _RmbLabel.text = [NSString stringWithFormat:@"%@ 元",pay_config[@"rmb_number"]?:@"0"];

    if (KScreenWidth==320) {
        _RmbLabel.height = 12;
        _ethLabel.mj_y = 52;
    }
    
//    _namelabel.attributedText=[SLHelper appendString:[NSString stringWithFormat:@"%@ 测试",pay_config[@"show_number"]?:@"0"] withColor:kThemeWhiteColor font:Font_Regular(12*Proportion375) lenght:2];
//    _ethLabel.attributedText=[SLHelper appendString:[NSString stringWithFormat:@"%@ 演示",pay_config[@"eth_number"]?:@"0"] withColor:kthemeBlackColor font:Font_Regular(12*Proportion375) lenght:2];
//    _RmbLabel.text = [NSString stringWithFormat:@"%@ 元",pay_config[@"rmb_number"]?:@"0"];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
