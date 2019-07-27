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
-(UIButton*)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(40, 350*Proportion375, kMainScreenWidth - 80, 45*Proportion375);
        _sureBtn.layer.cornerRadius = 45/2*Proportion375;
        [_sureBtn setBackgroundImage:[UIImage imageNamed:@"wallet_sure"] forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:Font_Regular(15*Proportion375)];
        [_sureBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确认充值" forState:UIControlStateNormal];
        _sureBtn.hidden = YES;
        @weakify(self)

        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            NSDictionary * pay_config =self.walletModel.pay_config[self.selectBtnIndex];
            [self alertMessage:[NSString stringWithFormat:@"购买%@秀币",pay_config[@"show_number"]?:@"0"] withIndex:self.selectBtnIndex];
//            [[YZAuthID alloc] yz_showAuthIDWithDescribe:nil BlockState:^(YZAuthIDState state, NSError *error) {
//                if (state == YZAuthIDStateNotSupport) {
//                    [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"对不起，当前设备不支持指纹/面部ID"];//                    NSLog(@"对不起，当前设备不支持指纹/面部ID");//                } else if(state == YZAuthIDStateFail) {
//                    [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"指纹/面部ID不正确，认证失败"];
//                    NSLog(@"指纹/面部ID不正确，认证失败");
//                } else if(state == YZAuthIDStateTouchIDLockout) {
//                    [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"多次错误，指纹/面部ID已被锁定，请到手机解锁界面输入密码"];
//                    NSLog(@"多次错误，指纹/面部ID已被锁定，请到手机解锁界面输入密码");
//                } else if (state == YZAuthIDStateSuccess) {
//
//                }
//            }];

        }];
    }
    return _sureBtn;
}
-(UIButton *)addButton
{
    if (!_addButton) {
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(kMainScreenWidth-50*Proportion375, self.height-40*Proportion375, 27*Proportion375, 27*Proportion375);
        [_addButton setImage:[UIImage imageNamed:@"account_add"] forState:UIControlStateNormal];
//        [_addButton addTarget:self action:@selector(shareSina:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
-(void)addButtonS {
    for (int i = 0 ; i < 3; i++)
    {
        NSInteger index = i % 3;
        ShowAccountExchangeView *mapBtn = [[ShowAccountExchangeView alloc]initWithFrame:CGRectMake(index * (Button_Width + Width_Space) + Start_X, Start_Y, Button_Width, Button_Height)];
        mapBtn.tag = i;
        mapBtn.pay_config= self.walletModel.pay_config[i];
        @weakify(self)
        [[mapBtn.coverBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton * x) {
            @strongify(self);
            if (self.selectBtn==mapBtn) {
                
            }else{
                self.selectBtn.backimage.image = [UIImage imageNamed:@"account_coinBg"];
                self.selectBtn = mapBtn;
            }
            mapBtn.backimage.image = [UIImage imageNamed:@"account_coinBg_select"];
            self.selectBtnIndex = mapBtn.tag;
            
            switch (mapBtn.tag) {

                case 0:
                {
//                    NSDictionary * pay_config =self.walletModel.pay_config[i];
//                    [self alertMessage:[NSString stringWithFormat:@"购买%@测试",pay_config[@"gou'mai_number"]?:@"0"] withIndex:0];
                }
                    break;
                case 1:
                {
//                    NSDictionary * pay_config =self.walletModel.pay_config[i];
//                    [self alertMessage:[NSString stringWithFormat:@"购买%@测试",pay_config[@"show_number"]?:@"0"] withIndex:1];

                }
                    break;
                case 2:
                {
//                     NSDictionary * pay_config =self.walletModel.pay_config[i];
//                    [self alertMessage:[NSString stringWithFormat:@"购买%@测试",pay_config[@"show_number"]?:@"0"] withIndex:2];
                }
                    break;
                default:
                    break;
            }
            
            
        }];
        if (mapBtn.tag == 1) {
            mapBtn.backimage.image = [UIImage imageNamed:@"account_coinBg_select"];
            self.selectBtn = mapBtn;
        }
        [self addSubview:mapBtn];
     }
}

-(void)alertMessage:(NSString *)message withIndex:(NSInteger)buttonIndex{
    @weakify(self);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确定%@？",message] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        @strongify(self);
        if (self.ExchangeAction ) {
            [self.ExchangeAction cancel];
            self.ExchangeAction = nil;
        }
        [SLReportManager reportEvent:kReport_MyWallet andSubEvent:kReport_MyWallet_SHOWPurchase];
        self.ExchangeAction = [SLWalletExchangeAction action];
        NSDictionary * pay_config =self.walletModel.pay_config[buttonIndex];
        
        self.ExchangeAction.show_number = pay_config[@"show_number"];
        self.ExchangeAction.type =@"ETH";
        @weakify(self)
        self.ExchangeAction.finishedBlock = ^(SLWalletModel *model)
        {
            @strongify(self)
            [HDHud hideHUDInView:self];
            [HDHud showMessageInView:self title:@"提交成功"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:SLWalletToRefreshNotification object:nil];

        };
        self.ExchangeAction.failedBlock = ^(NSError *error) {
            @strongify(self)
            [HDHud hideHUDInView:self];
            if (error.code == 8001) {
                [HDHud showMessageInView:self title:@"以太不足，请先充值以太"];
                [self performSelector:@selector(jumpTorecharge) withObject:nil afterDelay:.75];

            }else{
                
                [HDHud showMessageInView:self title:error.userInfo[@"msg"]];
                
            }
        };
        [self.ExchangeAction start];

    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}
-(void)jumpTorecharge{
    [PageMgr pushToRechargeViewControllerWithModel:self.walletModel.coinList[1] ];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
