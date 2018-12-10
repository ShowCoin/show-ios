//
//  ShowAccountHead.m
//  ShowLive
//
//  Created by iori_chou on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAccountHead.h"
#import "ShowAccountExchangeView.h"
#import "ShowAccountTableHeader.h"
#import "SLWalletExchangeAction.h"
#import "YZAuthID.h"

#define Start_X          20.0f*Proportion375
#define Start_Y          232*Proportion375
#define Width_Space      10.0f*Proportion375
#define Button_Height   75*Proportion375
#define Button_Width    105.0f  *Proportion375  

@interface ShowAccountHead ()
@property (nonatomic, strong) UIImageView *exchangeImage;
@property (nonatomic, strong) UIButton  * addButton;
@property (nonatomic, strong) ShowAccountTableHeader *backView;
@property (nonatomic, strong) UILabel *  propertyLabel;
@property (nonatomic, strong) UIButton *  sureBtn;
@property (nonatomic, strong) UILabel *  userAlertLab;
@property (nonatomic, strong) ShowAccountExchangeView *  selectBtn;
@property (nonatomic, assign) NSInteger   selectBtnIndex;
@property (nonatomic, strong) SLWalletExchangeAction * ExchangeAction;

@end
@implementation ShowAccountHead
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =kThemeWhiteColor;
        [self addSubview:self.backView];
        [self addSubview:self.sureBtn];
        [self addSubview:self.exchangeLabel];
        [self addSubview:self.propertyLabel];
        [self addSubview:self.exchangeImage];
        [self addSubview:self.userAlertLab];
        self.selectBtn = [[ShowAccountExchangeView alloc] init];
        self.selectBtnIndex = 1;
        //        UIView * whiteBG = [[UIView alloc] initWithFrame:CGRectMake(0, Start_Y , kMainScreenWidth, 100)];
        //        whiteBG.backgroundColor = kThemeWhiteColor;
        //        [self addSubview:whiteBG];
//        [self addSubview:self.addButton];
//        [whiteBG mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self);
//            make.top.equalTo(self).with.offset(Start_Y - 17*Proportion375);
//            make.width.equalTo(@(kMainScreenWidth));
//            make.bottom.equalTo(self);
//        }];
    }
    return self;
}
- (void)setUser:(ShowUserModel *)user
{
    _user = user;
    _backView.user =_user;

}
- (void)setWalletModel:(SLWalletModel *)walletModel
{
    _walletModel =walletModel;
    _exchangeLabel.attributedText= [SLHelper appendString:[NSString stringWithFormat:@"汇率  %@",walletModel.eth_rate?:@"1.00"] withColor:kthemeBlackColor font:Font_Regular(17*Proportion375) lenght:walletModel.eth_rate.length?:4];
    [_exchangeLabel sizeToFit];
    _exchangeLabel.centerX = self.centerX - 10*Proportion375;
    _exchangeImage.left = _exchangeLabel.right+5*Proportion375;
    _exchangeImage.bottom = _exchangeLabel.bottom-7*Proportion375;
//    _backView.walletModel= walletModel;
    if ([_user.uid isEqualToString:AccountUserInfoModel.uid]) {
        _exchangeLabel.hidden = NO;
        _exchangeImage.hidden = NO;
        _userAlertLab.hidden = NO;
        _sureBtn.hidden = NO;
        [self addButtonS];
    }
    self.backView.RmbNumLabel.hidden = YES;
    self.backView.coinNumLabel.text = [NSString stringWithFormat:@"%@ 元",_walletModel.rmb_num?:@"0"];
}
-(UIView*)backView
{
    if (!_backView) {
        _backView = [[ShowAccountTableHeader alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 217.5*Proportion375)];
    }
    return _backView;
}


-(UILabel*)exchangeLabel
{
    if (!_exchangeLabel) {
        _exchangeLabel = [UILabel labelWithFrame:CGRectMake(0, 414*Proportion375,  215*Proportion375, 15*Proportion375) text:@"汇率  1.00" textColor:kGrayWith999999 font:Font_Regular(15*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _exchangeLabel.attributedText= [SLHelper appendString:@"汇率  1.00" withColor:kthemeBlackColor font:Font_Regular(15*Proportion375) lenght:4];
        _exchangeLabel.hidden = YES;


    }
    return _exchangeLabel;
}
- (UIImageView*)exchangeImage{
    if (!_exchangeImage) {
        _exchangeImage = [[UIImageView alloc]initWithFrame:CGRectMake(_exchangeLabel.right+5*Proportion375, _exchangeLabel.bottom-15*Proportion375, 15*Proportion375, 15*Proportion375)];
        _exchangeImage.image = [UIImage imageNamed:@"account_exchange"];
        _exchangeImage.hidden = YES;

    }
    return _exchangeImage;
}
-(UILabel*)propertyLabel
{
    if (!_propertyLabel) {
        _propertyLabel = [UILabel labelWithFrame:CGRectMake(20*Proportion375, self.height-30*Proportion375,  kMainScreenWidth - 20*Proportion375, 18*Proportion375) text:STRING_WALLET_ASSETS_23 textColor:kthemeBlackColor font:Font_Regular(18*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(20*Proportion375, self.height -.6, kMainScreenWidth - 20*Proportion375, 0.6)];
        lineView.backgroundColor = kSeparationColor;
        [self addSubview:lineView];
    }
    return _propertyLabel;
}
-(UILabel*)userAlertLab
{
    if (!_userAlertLab) {
        _userAlertLab = [UILabel labelWithFrame:CGRectMake(0, self.exchangeLabel.bottom + 20*Proportion375,  kMainScreenWidth   , 10*Proportion375) text:@"已阅读并同意《用户充值协议》" textColor:kGrayWith999999 font:Font_Regular(10*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _userAlertLab.attributedText= [SLHelper appendString:@"已阅读并同意《用户充值协议》" withColor:kthemeBlackColor font:Font_Regular(10*Proportion375) lenght:7];
        _userAlertLab.hidden = YES;
        
    }
    return _userAlertLab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
