
//
//  NewTopListHeader.m
//  ShowLive
//
//  Created by vning on 2019/1/25.
//  Copyright © 2019 vning. All rights reserved.
//

#import "NewTopListHeader.h"

@implementation NewTopListHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBlackWith17;
        [self addSubview:self.firstL];
        [self addSubview:self.secL];
        [self addSubview:self.thirdL];
        [self addSubview:self.fouthL];
        [self addSubview:self.fifthL];
    }
    return self;
}
-(UILabel *)firstL
{
    if (!_firstL ) {
        _firstL = [UILabel labelWithText:@"" textColor:kGrayTextWithb6 font:Font_Medium(12*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _firstL.frame = CGRectMake(0, 30*Proportion375, kMainScreenWidth, 12*Proportion375);
    }
    return _firstL;
}
-(UILabel *)secL
{
    if (!_secL ) {
        _secL = [UILabel labelWithText:@"" textColor:kGoldWithPoster font:Font_engMedium(27*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _secL.frame = CGRectMake(0, 50*Proportion375, kMainScreenWidth, 27*Proportion375);

    }
    return _secL;
}
-(UILabel *)thirdL
{
    if (!_thirdL ) {
        _thirdL = [UILabel labelWithText:@"" textColor:kGrayTextWithb6 font:Font_engMedium(16*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _thirdL.frame = CGRectMake(0, 78*Proportion375, kMainScreenWidth, 16*Proportion375);
    }
    return _thirdL;
}
-(UILabel *)fouthL
{
    if (!_fouthL ) {
        _fouthL = [UILabel labelWithText:@"" textColor:kGrayWith727272 font:Font_Medium(11*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _fouthL.frame = CGRectMake(0, 105*Proportion375, kMainScreenWidth, 11*Proportion375);
    }
    return _fouthL;
}
-(UILabel *)fifthL
{
    if (!_fifthL ) {
        _fifthL = [UILabel labelWithText:@"" textColor:kGrayWith727272 font:Font_Medium(11*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _fifthL.frame = CGRectMake(0, 132*Proportion375, kMainScreenWidth, 11*Proportion375);
        _fifthL.hidden = YES;
    }
    return _fifthL;
}
@end
