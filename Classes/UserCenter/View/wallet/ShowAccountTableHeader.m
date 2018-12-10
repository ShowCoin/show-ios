//
//  ShowAccountTableHeader.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAccountTableHeader.h"
@interface ShowAccountTableHeader()
@property (nonatomic, strong) SLHeadPortrait *headerImage;
@property (nonatomic, strong) UILabel *  nameLabel;
@property (nonatomic, strong) UIImageView * backView;

@end
@implementation ShowAccountTableHeader
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kThemeYellowColor;
        [self addSubview:self.backView];
        [self.backView addSubview:self.headerImage];
        [self.backView addSubview:self.nameLabel];
        [self.backView addSubview:self.coinNumLabel];
        [self.backView addSubview:self.RmbNumLabel];
    }
    return self;
}
- (void)setUser:(ShowUserModel *)user
{
    _user = user;
    [_headerImage setRoundStyle:YES imageUrl:_user?_user.avatar:AccountUserInfoModel.avatar imageHeight:45 vip:NO attestation:NO];
    _nameLabel.text =_user?_user.nickname:AccountUserInfoModel.nickname;

}
- (void)setWalletModel:(SLWalletCoinModel *)walletModel
{
    _walletModel =walletModel;
    _RmbNumLabel.text=[NSString stringWithFormat:@"%@ 元",_walletModel.balance_rmb?:@"0.00"];
    _coinNumLabel.text=[NSString stringWithFormat:@"%@",_walletModel.balance?:@"0"];
}

-(UIImageView*)backView
{
    if (!_backView) {
//        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, self.height)];
//        _backView.backgroundColor = kThemeYellowColor;
        _backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, self.height)];
        [_backView setImage:[UIImage imageNamed:@"wallet_bg"]];
    }
    return _backView;
}
-(UILabel*)coinNumLabel
{
    if (!_coinNumLabel) {
        _coinNumLabel = [UILabel labelWithFrame:CGRectMake(0, _nameLabel.bottom+15*Proportion375, self.width, 35*Proportion375) text:@"0 秀币" textColor:kThemeWhiteColor font:Font_Regular(35*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];

    }
    return _coinNumLabel;
}
-(UILabel*)RmbNumLabel
{
    if (!_RmbNumLabel) {
        CGFloat rmb = AccountUserInfoModel.showCoinNum.floatValue/100;
        _RmbNumLabel = [UILabel labelWithFrame:CGRectMake(0, _coinNumLabel.bottom+5*Proportion375, self.width, 18*Proportion375) text:[NSString stringWithFormat:@"%.2f 元",rmb] textColor:kThemeWhiteColor font:Font_Regular(18*WScale)   backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];

    }
    return _RmbNumLabel;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(0, _headerImage.bottom+12*WScale,  kMainScreenWidth, 20*Proportion375) text:AccountUserInfoModel.nickname textColor:kThemeWhiteColor font:Font_Regular(17*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _nameLabel;
}
- (SLHeadPortrait*)headerImage{
    if (!_headerImage) {
        _headerImage = [[SLHeadPortrait alloc]initWithFrame:CGRectMake(kMainScreenWidth/2-58*Proportion375/2, 30*Proportion375, 58*Proportion375, 58*Proportion375)];
        [_headerImage setRoundStyle:YES imageUrl:AccountUserInfoModel.avatar imageHeight:45 vip:NO attestation:NO];
        _headerImage.backgroundColor = [UIColor clearColor];
    }
    return _headerImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
