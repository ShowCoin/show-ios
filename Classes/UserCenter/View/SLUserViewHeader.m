//
//  SLUserViewHeader.m
//  ShowLive
//
//  Created by vning on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLUserViewHeader.h"
#import <YYTextLayout.h>
#import "SLFollowUserAction.h"
#import "SLPhotoBrowserViewController.h"
#import "SLUserViewHeader+SLMinCard.h"
#import "SLCustomerViewController.h"
#import "HomeHeader.h"
#import "SLPlayerViewController.h"
#import "ShowHomeViewController.h"
#import "UserCenterViewController.h"
#import "UMMoreViewController.h"

@interface SLUserViewHeader ()

@end

@implementation SLUserViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = kBlackWith1c;
    
    _shadowColor = [[NSShadow alloc] init];
    _shadowColor.shadowBlurRadius = 1; //模糊度(宽度？)
    _shadowColor.shadowColor = kThemeShadowColor;
    _shadowColor.shadowOffset = CGSizeMake(1, 1);//正数是往右边跟下边延伸
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:kNotificationLogout object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self clearData];
    }];
    if (self) {
        
        [self addSubview:self.headImgView];
        [self addSubview:self.effColorView];
        [self addSubview:self.effectview];
        [self addSubview:self.leftBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.settingBtn];
        [self addSubview:self.headPortrait];
        [self addSubview:self.IsLiveImgView];
        [self addSubview:self.nickLab];
        [self addSubview:self.idLab];
        [self addSubview:self.LineView];
        
        [self addSubview:self.walletNum];
        [self addSubview:self.walletLab];
        [self addSubview:self.concernNum];
        [self addSubview:self.concernLab];
        [self addSubview:self.fansNum];
        [self addSubview:self.fansLab];
        
        [self addSubview:self.walletBtn];
        [self addSubview:self.concerBtn];
        [self addSubview:self.fansBtn];
        [self addSubview:self.userInfoBtn];
        
        [self addSubview:self.masterLevel];
        [self addSubview:self.showLevel];
        [self addSubview:self.levelCenterImg];
        
        [self addSubview:self.sexbg];
        [self.sexbg addSubview:self.sexImg];
        [self.sexbg addSubview:self.sexlab];
        [self addSubview:self.cityLab];
        [self addSubview:self.constellationLab];
        [self addSubview:self.wordsLab];
        //        [self addSubview:self.idPreLab];
        //        [self addSubview:self.bottomWhiteView];
        
        [self addSubview:self.toConcerBtn];
        [self addSubview:self.tosendMessageBtn];
        
        [self addSubview:self.worksBtn];
        [self addSubview:self.likesBtn];
        [self addSubview:self.bottomAnimationLine];
        
        [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(self).with.offset(0);
        }];
        
        [self.effColorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgView);
            make.bottom.equalTo(self.headImgView);
            make.size.mas_equalTo(self.headImgView);
        }];
        [self.effectview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgView);
            make.bottom.equalTo(self.headImgView);
            make.size.mas_equalTo(self.headImgView);
        }];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(25*Proportion375 + KTopHeight);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(32*Proportion375, 32*Proportion375));
        }];
        [self.headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(74*Proportion375 + KTopHeight);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(94*Proportion375, 94*Proportion375));
        }];
        [self.IsLiveImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headPortrait);
            make.left.equalTo(self.headPortrait);
            make.size.mas_equalTo(CGSizeMake(94.5*Proportion375, 94.5*Proportion375));
        }];
        [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(25*Proportion375 + KTopHeight);
            make.right.equalTo(self).with.offset(-10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(32*Proportion375, 32*Proportion375));
        }];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(25*Proportion375 + KTopHeight);
            make.right.equalTo(self).with.offset(-54*Proportion375);
            make.size.mas_equalTo(CGSizeMake(32*Proportion375, 32*Proportion375));
        }];
        
        [self.walletNum mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(87*Proportion375+KTopHeight);
            make.left.equalTo(self.headPortrait.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(82*Proportion375, 17*Proportion375));
        }];
        [self.walletLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.concernNum.mas_bottom).with.offset(2*Proportion375);
            make.left.equalTo(self.headPortrait.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(82*Proportion375, 13*Proportion375));
        }];
        [self.concernNum mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.walletNum);
            make.left.equalTo(self.walletNum.mas_right);
            make.size.mas_equalTo(CGSizeMake(82*Proportion375, 17*Proportion375));
        }];
        [self.concernLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.walletLab);
            make.left.equalTo(self.walletLab.mas_right);
            make.size.mas_equalTo(CGSizeMake(82*Proportion375, 13*Proportion375));
        }];
        [self.fansNum mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.walletNum);
            make.left.equalTo(self.concernNum.mas_right);
            make.size.mas_equalTo(CGSizeMake(82*Proportion375, 17*Proportion375));
        }];
        [self.fansLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.walletLab);
            make.left.equalTo(self.concernLab.mas_right);
            make.size.mas_equalTo(CGSizeMake(82*Proportion375, 13*Proportion375));
        }];
        
        [self.walletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(81*Proportion375+KTopHeight);
            make.left.equalTo(self.headPortrait.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(82*Proportion375, 40*Proportion375));
        }];
        [self.concerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.walletBtn);
            make.left.equalTo(self.walletBtn.mas_right);
            make.size.mas_equalTo(CGSizeMake(82*Proportion375, 40*Proportion375));
        }];
        [self.fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.walletBtn);
            make.left.equalTo(self.concerBtn.mas_right);
            make.size.mas_equalTo(CGSizeMake(82*Proportion375, 40*Proportion375));
        }];
        
        [self.userInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(7*Proportion375);
            make.left.equalTo(self.headPortrait.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(244*Proportion375, 28*Proportion375));
        }];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headPortrait.mas_bottom).with.offset(14*Proportion375);
            make.left.equalTo(self).with.offset(16*Proportion375);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth/2, 15*Proportion375));
        }];
        
        [self.idLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickLab.mas_bottom).with.offset(6*Proportion375);
            make.left.equalTo(self).with.offset(16*Proportion375);
            //            make.size.mas_equalTo(CGSizeMake(100, 16*Proportion375));
            make.height.equalTo(@(11*Proportion375));
            
        }];
        [self.LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.idLab.mas_bottom).with.offset(10*Proportion375);
            make.left.equalTo(self).with.offset(16*Proportion375);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth - 32*Proportion375, 1));
            
        }];
        
        [self.masterLevel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.LineView.mas_bottom).with.offset(10*Proportion375);
            make.left.equalTo(self).with.offset(16*Proportion375);
            make.size.mas_equalTo(CGSizeMake(30*Proportion375, 14*Proportion375));
        }];
        [self.showLevel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.masterLevel);
            make.left.equalTo(self.masterLevel.mas_right).with.offset(4*Proportion375);
            make.size.mas_equalTo(CGSizeMake(30*Proportion375, 14*Proportion375));
        }];
        [self.levelCenterImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.masterLevel);
            make.left.equalTo(self.showLevel.mas_right).with.offset(4*Proportion375);
            make.size.mas_equalTo(CGSizeMake(17*Proportion375, 15*Proportion375));
        }];
        [self.sexbg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.showLevel.mas_bottom).with.offset(8*Proportion375);
            make.left.equalTo(self).with.offset(16*Proportion375);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 18*Proportion375));
        }];
        [self.sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sexbg).with.offset(4*Proportion375);
            make.left.equalTo(self.sexbg).with.offset(7*Proportion375);
            make.size.mas_equalTo(CGSizeMake(10*Proportion375, 10*Proportion375));
        }];
        [self.sexlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sexbg);
            make.left.equalTo(self.sexImg.mas_right).with.offset(1*Proportion375);
            make.size.mas_equalTo(CGSizeMake(30*Proportion375, 20*Proportion375));
        }];
        [self.cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sexbg);
            make.left.equalTo(self.sexbg.mas_right).with.offset(4*Proportion375);
            make.width.lessThanOrEqualTo(@(100*Proportion375));
            make.width.greaterThanOrEqualTo(@(50*Proportion375));
            make.height.equalTo(@(18*Proportion375));
            
        }];
        [self.constellationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sexbg);
            make.left.equalTo(self.cityLab.mas_right).with.offset(4*Proportion375);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 18*Proportion375));
        }];
        [self.wordsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cityLab.mas_bottom).with.offset(8*Proportion375);
            make.left.equalTo(self).with.offset(16*Proportion375);
            make.width.equalTo(@(kMainScreenWidth-40*Proportion375));
        }];
        [self.toConcerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(13*Proportion375);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(0, 31*Proportion375));
        }];
        [self.tosendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(13*Proportion375);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(0, 31*Proportion375));
        }];
        
        
        [self.worksBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(- 1);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth/2, 40*Proportion375));
        }];
        
        [self.likesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(- 1);
            make.right.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth/2, 40*Proportion375));
        }];
        
        [self.bottomAnimationLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.centerX.equalTo(self.worksBtn);
            make.size.mas_equalTo(CGSizeMake(26*Proportion375, 2*Proportion375));
        }];
        
    }
    return self;
}

-(void)setIsMe:(BOOL)isMe
{
    //    return;
    _isMe = isMe;
    if (!isMe) {
        
        [self.toConcerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(7*Proportion375);
            make.left.equalTo(self.headPortrait.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(244*Proportion375, 28*Proportion375));
        }];
        [self.tosendMessageBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(13*Proportion375);
            make.left.equalTo(self.toConcerBtn.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(165*Proportion375 , 28*Proportion375));
        }];
        [self.shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(25*Proportion375 + KTopHeight);
            make.right.equalTo(self).with.offset(-54*Proportion375);
            make.size.mas_equalTo(CGSizeMake(32*Proportion375, 32*Proportion375));
        }];
        self.leftBtn.hidden = NO;
        self.settingBtn.hidden = NO;
        self.userInfoBtn.hidden = YES;
        self.leftBtn.hidden = NO;
        self.tosendMessageBtn.hidden = YES;
        self.toConcerBtn.hidden = NO;
        self.shareBtn.hidden = NO;
    }else{
        self.leftBtn.hidden = YES;
        self.settingBtn.hidden = NO;
        self.userInfoBtn.hidden = NO;
        self.leftBtn.hidden = YES;
        self.tosendMessageBtn.hidden = YES;
        self.toConcerBtn.hidden = YES;
        self.shareBtn.hidden = YES;
        
        
    }
}
//刷新ui
- (void)userinfoChange:(NSNotification *)notif
{
    [self setLabelSpace:self.wordsLab withValue:@"" withFont:Font_Regular(14*Proportion375)];
    [_headPortrait setRoundStyle:YES imageUrl:AccountUserInfoModel.avatar imageHeight:95 vip:AccountUserInfoModel.is_vip attestation:NO];
    [_nickLab setText:AccountUserInfoModel.nickname];
    _sexImg .image=[AccountUserInfoModel.gender  isEqualToString:@"1"]?[UIImage imageNamed:@"userhome_sex_man"]:[UIImage imageNamed:@"userhome_sex_women"];
    
}

-(UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"user_back"] forState:UIControlStateNormal];
        [[_leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [PageMgr popActionFromViewcontroller:self.Controller?:(BaseViewController *)self.viewController];
        }];
    }
    return _leftBtn;
}
-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"user_share"] forState:UIControlStateNormal];
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [HDHud showMessageInView:self title:@"敬请期待"];
        }];
        
    }
    return _shareBtn;
}

- (SLHeadPortrait *)headPortrait
{
    if (!_headPortrait) {
        _headPortrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(0, 53*Proportion375, 94*Proportion375, 94 *Proportion375)];
        _headPortrait.centerX = kMainScreenWidth/2;
        _headPortrait.delegate = self;
        
    }
    return _headPortrait;
}
-(UIImageView *)IsLiveImgView
{
    if (!_IsLiveImgView) {
        _IsLiveImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_is_live"]];
        _IsLiveImgView.hidden = YES;
        _IsLiveImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _IsLiveImgView;
}

-(UIButton *)settingBtn
{
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.titleLabel.font = Font_Medium(12*Proportion375);
        [_settingBtn setBackgroundImage:[UIImage imageNamed:@"user_more"] forState:UIControlStateNormal];
        [[_settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [SLReportManager reportEvent:kReport_Me andSubEvent:kReport_Me_Setting];
            if (self.isMe) {
                [PageMgr pushtoUserMoreVCWithUserModel:self.userModel];
            } else {
#ifdef kCYHTestCode
                UMMoreViewController *vc = [[UMMoreViewController alloc] init];
                [self.viewController.navigationController pushViewController:vc animated:YES];
#else
                [HDHud showMessageInView:self title:@"敬请期待"];
#endif
                
            }
        }];
    }
    return _settingBtn;
}

-(UILabel *)nickLab
{
    if (!_nickLab) {
        _nickLab = [UILabel labelWithText:AccountUserInfoModel.nickname textColor:kThemeWhiteColor font:Font_Semibold(14*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _nickLab.layer.shadowRadius = 0.0f;
        _nickLab.layer.shadowOpacity = 0.3;
        _nickLab.layer.shadowColor = kThemeShadowColor.CGColor;
        _nickLab.layer.shadowOffset = CGSizeMake(0,1);
        
    }
    return _nickLab;
}
-(SLLevelMarkView *)masterLevel
{
    if (!_masterLevel) {
        _masterLevel = [[SLLevelMarkView alloc]initWithFrame:CGRectMake(0, 0, 30*WScale, 15*WScale) withType:LevelType_Host];
        _masterLevel.level =Int2String(_userModel.masterLevel);
        _masterLevel.clipsToBounds = YES;
    }
    return _masterLevel;
}
-(SLLevelMarkView *)showLevel
{
    if (!_showLevel) {
        _showLevel = [[SLLevelMarkView alloc]initWithFrame:CGRectMake(0, 0, 30*WScale, 15*WScale) withType:LevelType_ShowCoin];
        _showLevel.level =Int2String(_userModel.showLevel);
        _showLevel.clipsToBounds = YES;
        
    }
    return _showLevel;
}
-(UIImageView *)levelCenterImg
{
    if (!_levelCenterImg) {
        _levelCenterImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    }
    return _levelCenterImg;
}
-(UIView *)sexbg
{
    if (!_sexbg) {
        _sexbg = [[UIView alloc] init];
        _sexbg.clipsToBounds = YES;
        _sexbg.layer.cornerRadius = 1.5;
        _sexbg.backgroundColor = HexRGBAlpha(0x9f52ff,.12);
    }
    return _sexbg;
}
-(UIImageView *)sexImg
{
    if (!_sexImg) {
        _sexImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_sex_man"]];
        _sexImg.clipsToBounds = YES;
    }
    return _sexImg;
}
-(UILabel *)sexlab
{
    if (!_sexlab) {
        _sexlab = [UILabel labelWithText:@"22岁" textColor:kThemeWhiteColor font:Font_Medium(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _sexlab.clipsToBounds = YES;
    }
    return _sexlab;
}

-(UILabel*)idLab
{
    if (!_idLab) {
        _idLab = [UILabel labelWithText:[NSString stringWithFormat:@"%@",AccountUserInfoModel.popularNo] textColor:kTextWithF7 font:Font_Regular(11*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _idLab.layer.shadowColor = kThemeShadowColor.CGColor;
        _idLab.layer.shadowOffset = CGSizeMake(0,1);
        
    }
    return _idLab;
}
-(UIView *)LineView{
    if (!_LineView) {
        _LineView = [[UIView alloc] init];
        _LineView.backgroundColor = HexRGBAlpha(0xffffff, .04);
    }
    return _LineView;
}
-(UILabel*)cityLab
{
    if (!_cityLab) {
        _cityLab = [UILabel labelWithText:AccountUserInfoModel.city textColor:kThemeWhiteColor font:Font_Semibold(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _cityLab.layer.cornerRadius = 1.5;
        _cityLab.clipsToBounds = YES;
        _cityLab.backgroundColor = HexRGBAlpha(0x00c0ff, .12);
    }
    return _cityLab;
}
-(UILabel*)constellationLab
{
    if (!_constellationLab) {
        _constellationLab = [UILabel labelWithText:AccountUserInfoModel.constellation textColor:kThemeWhiteColor font:Font_Semibold(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _constellationLab.layer.cornerRadius = 1.5;
        _constellationLab.clipsToBounds = YES;
        _constellationLab.backgroundColor = HexRGBAlpha(0xff57b8, .12);
        
    }
    return _constellationLab;
}
-(UILabel *)wordsLab
{
    if (!_wordsLab) {
        _wordsLab = [UILabel labelWithText:@"" textColor:kThemeWhiteColor font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _wordsLab.numberOfLines = 0;
        _wordsLab.preferredMaxLayoutWidth = kMainScreenWidth-40 *Proportion375;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        _wordsLab.userInteractionEnabled = YES;
        [_wordsLab addGestureRecognizer:tap];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            if (self.isMe) {
                [PageMgr pushtoUserInfoVC];
            }
        }];
        
    }
    return _wordsLab;
}
-(UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] init];
        _headImgView.layer.masksToBounds = YES;
        //        _headImgView.alpha = 0;
        _headImgView.contentMode =UIViewContentModeScaleAspectFill;
        
    }
    return _headImgView;
}
-(UIView *)effColorView
{
    if (!_effColorView) {
        _effColorView  = [[UIView alloc] init];
        _effColorView.backgroundColor = HexRGBAlpha(0x000000, 0);
    }
    return _effColorView;
}
-(UIVisualEffectView *)effectview
{
    if (!_effectview) {
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        //        _effectview.alpha = 0.97;
    }
    return _effectview;
}

-(UIView *)bottomWhiteView
{
    if (!_bottomWhiteView) {
        _bottomWhiteView = [[UIView alloc] init];
        _bottomWhiteView.backgroundColor = kThemeWhiteColor;
        
    }
    return _bottomWhiteView;
}
-(UIButton *)fansBtn
{
    if (!_fansBtn) {
        _fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fansBtn.titleLabel.numberOfLines = 0;
        _fansBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        @weakify(self)
        [[_fansBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            if(self.isMiniCard){
                return  ;
            }
            [SLReportManager reportEvent:self.isMe?kReport_Me:kReport_Others andSubEvent:self.isMe?kReport_Me_FansList:kReport_Others_FansList];
            [PageMgr pushFansWithType:1 andUid:self.userModel.uid viewcontroller:self.Controller?:(BaseViewController *)self.viewController];
        }];
    }
    return _fansBtn;
}

-(UIButton *)concerBtn
{
    if (!_concerBtn) {
        _concerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _concerBtn.titleLabel.numberOfLines = 0;
        _concerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        @weakify(self)
        [[_concerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            if(self.isMiniCard){
                return  ;
            }
            [SLReportManager reportEvent:self.isMe?kReport_Me:kReport_Others andSubEvent:self.isMe?kReport_Me_FollowList:kReport_Others_FollowList];
            [PageMgr pushFansWithType:0 andUid:self.userModel.uid viewcontroller:self.Controller?:(BaseViewController *)self.viewController];
        }];
    }
    return _concerBtn;
}
-(UIButton *)walletBtn
{
    if (!_walletBtn) {
        _walletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _walletBtn.titleLabel.numberOfLines = 0;
        _walletBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        @weakify(self)
        [[_walletBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            if(self.isMiniCard){
                return;
            }
            [SLReportManager reportEvent:self.isMe?kReport_MyWallet:kReport_OthersWallet];
            if ([self.userModel.uid isEqualToString:AccountUserInfoModel.uid]) {
                
                [PageMgr pushToWalletHomePage:self.userModel viewcontroller:self.Controller?:(BaseViewController *)self.viewController];
            }else{
                SLWalletCoinModel * model = [[SLWalletCoinModel alloc]init];
                model.typeCName = @"秀币";
                model.type      = @"SHOW";
                [PageMgr PushToDaycoinViewControllerWithWallet:model user:self.userModel viewcontroller:self.Controller?:(BaseViewController *)self.viewController];
            }
        }];
    }
    return _walletBtn;
}

-(UILabel *)walletNum
{
    if (!_walletNum) {
        _walletNum = [UILabel labelWithText:@"" textColor:kTextWithF7 font:Font_engMedium(17*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _walletNum;
}
-(UILabel *)walletLab
{
    if (!_walletLab) {
        _walletLab = [UILabel labelWithText:@"钱包" textColor:kThemeAlph70F7F7F7 font:Font_Regular(13*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _walletLab;
}
-(UILabel *)concernNum
{
    if (!_concernNum) {
        _concernNum = [UILabel labelWithText:@"" textColor:kTextWithF7 font:Font_engMedium(17*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _concernNum;
}
-(UILabel *)concernLab
{
    if (!_concernLab) {
        _concernLab = [UILabel labelWithText:@"关注" textColor:kThemeAlph70F7F7F7 font:Font_Regular(13*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _concernLab;
}
-(UILabel *)fansNum
{
    if (!_fansNum) {
        _fansNum = [UILabel labelWithText:@"" textColor:kTextWithF7 font:Font_engMedium(17*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _fansNum;
}
-(UILabel *)fansLab
{
    if (!_fansLab) {
        _fansLab = [UILabel labelWithText:@"粉丝" textColor:kThemeAlph70F7F7F7 font:Font_Regular(13*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _fansLab;
}
-(UIButton *)toConcerBtn
{
    if (!_toConcerBtn) {
        _toConcerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toConcerBtn setTitle:@"加关注" forState:UIControlStateNormal];
        [_toConcerBtn setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
        _toConcerBtn.titleLabel.font = Font_Medium(13*Proportion375);
        _toConcerBtn.layer.borderWidth = 0.5*Proportion375;
        _toConcerBtn.layer.borderColor = kGoldWithAlphPoster.CGColor;
        _toConcerBtn.layer.cornerRadius = 4;
        _toConcerBtn.backgroundColor = kThemeShadowColor15;
        @weakify(self)
        [[_toConcerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [SLReportManager reportEvent:kReport_Others andSubEvent:kReport_Others_Follow];
            [self concerAction];
        }];
    }
    return _toConcerBtn;
}
-(UIButton *)tosendMessageBtn
{
    if (!_tosendMessageBtn) {
        _tosendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tosendMessageBtn setTitle:@"私信" forState:UIControlStateNormal];
        [_tosendMessageBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _tosendMessageBtn.titleLabel.font = Font_Medium(13*Proportion375);
        _tosendMessageBtn.layer.borderWidth = 0.5*Proportion375;
        _tosendMessageBtn.layer.borderColor = kThemeAlph30F7F7F7.CGColor;
        _tosendMessageBtn.layer.cornerRadius = 4;
        _tosendMessageBtn.backgroundColor = kThemeAlph15Block;
        
        
        
        @weakify(self)
        [[_tosendMessageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [SLReportManager reportEvent:kReport_Others andSubEvent:kReport_Others_SendMessage];
            
            [ PageMgr pushToChatViewControllerWithTargetUser:self.userModel];
            //            if (self.delegate && [self.delegate respondsToSelector:@selector(SLUserViewHeaderConcernActionDelegateWithShare)] ) {
            //                [self.delegate SLUserViewHeaderConcernActionDelegateWithShare];
            //            }
        }];
        
    }
    return _tosendMessageBtn;
}
-(UIButton *)userInfoBtn
{
    if (!_userInfoBtn) {
        _userInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_userInfoBtn setTitle:@"消息" forState:UIControlStateNormal];
        [_userInfoBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _userInfoBtn.titleLabel.font = Font_Medium(13*Proportion375);
        _userInfoBtn.layer.borderWidth = 0.5*Proportion375;
        _userInfoBtn.layer.borderColor = kThemeAlph30F7F7F7.CGColor;
        _userInfoBtn.layer.cornerRadius = 4;
        _userInfoBtn.backgroundColor = kThemeAlph15Block;
        [[_userInfoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [PageMgr pushToChatViewController];
        }];
        
    }
    return _userInfoBtn;
}
-(UIButton *)worksBtn
{
    if (!_worksBtn) {
        _worksBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _worksBtn.titleLabel.font = Font_Regular(14*Proportion375);
        [_worksBtn setTitle:@"作品 0" forState:UIControlStateNormal];
        [_worksBtn setTitleColor:kTextWithF7 forState:UIControlStateNormal];
        //        [_worksBtn setBackgroundColor:kNavigationBGColor forState:UIControlStateNormal];
        [[_worksBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [SLReportManager reportEvent:self.isMe?kReport_Me:kReport_Others andSubEvent:self.isMe?kReport_Me_HistoryList:kReport_Others_HistoryList];
            
            [self.bottomAnimationLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.centerX.equalTo(self.worksBtn);
                make.size.mas_equalTo(CGSizeMake(26*Proportion375, 2*Proportion375));
            }];
            [UIView animateWithDuration:0.2 animations:^{
                
                [self layoutIfNeeded];
            }];
        }];
    }
    return _worksBtn;
}
-(UIButton *)likesBtn
{
    if (!_likesBtn) {
        _likesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likesBtn.titleLabel.font = Font_Regular(14*Proportion375);
        [_likesBtn setTitle:@"喜欢 0" forState:UIControlStateNormal];
        [_likesBtn setTitleColor:kThemeAlph70F7F7F7 forState:UIControlStateNormal];
        //        [_likesBtn setBackgroundColor:kNavigationBGColor forState:UIControlStateNormal];
        [[_likesBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [SLReportManager reportEvent:self.isMe?kReport_Me:kReport_Others andSubEvent:self.isMe?kReport_Me_LikeList:kReport_Others_LikeList];
            [HDHud showMessageInView:self title:@"敬请期待"];
            
        }];
        
    }
    return _likesBtn;
}
-(UIView *)bottomAnimationLine
{
    if (!_bottomAnimationLine) {
        _bottomAnimationLine = [[UIView alloc] init];
        _bottomAnimationLine.layer.cornerRadius = 1*Proportion375;
        _bottomAnimationLine.backgroundColor = kThemeWhiteColor;
    }
    return _bottomAnimationLine;
}
#pragma mark---------method-----------

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    if (!str.length) {
        return;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 0; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //    设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f,NSForegroundColorAttributeName:kBlackThemetextColor};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
    self.labelHeight = label.height;
    NSLog(@"header height  1    =====     %f",self.labelHeight);
}

#pragma mark- datas
@end
 
