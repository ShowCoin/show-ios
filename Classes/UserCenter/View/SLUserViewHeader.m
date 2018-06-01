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

@implementation SLUserViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = kThemeWhiteColor;
    
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
//        [self addSubview:self.effColorView];
        [self addSubview:self.effectview];
        [self addSubview:self.navLab];
        [self addSubview:self.leftBtn];
        [self addSubview:self.listBtn];
        [self addSubview:self.settingBtn];
        [self addSubview:self.giftStoreBtn];
        [self addSubview:self.headPortrait];
        [self addSubview:self.nickLab];
        [self addSubview:self.masterLevel];
        [self addSubview:self.showLevel];

        [self addSubview:self.sexbg];
        [self.sexbg addSubview:self.sexImg];
        [self.sexbg addSubview:self.sexlab];
//        [self addSubview:self.idPreLab];
        [self addSubview:self.idLab];
        [self addSubview:self.cityLab];
        [self addSubview:self.constellationLab];
        [self addSubview:self.wordsLab];
//        [self addSubview:self.bottomWhiteView];
        
        [self addSubview:self.fansBtn];
        [self addSubview:self.concerBtn];
        [self addSubview:self.walletBtn];
        [self addSubview:self.toConcerBtn];
        [self addSubview:self.tosendMessageBtn];
        [self addSubview:self.shareBtn];

        [self addSubview:self.worksBtn];
        [self addSubview:self.likesBtn];
        [self addSubview:self.bottomAnimationLine];
        [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(self).with.offset(-40*Proportion375 + KTopHeight);
        }];
        
        //        [self.effColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.headImgView);
        //            make.bottom.equalTo(self.headImgView);
        //            make.size.mas_equalTo(self.headImgView);
        //        }];
        [self.effectview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgView);
            make.bottom.equalTo(self.headImgView);
            make.size.mas_equalTo(self.headImgView);
        }];
        
        [self.navLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_top).with.offset(44*Proportion375);
            make.left.equalTo(self);
            
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 30*Proportion375));
        }];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(20*Proportion375 + KTopHeight);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(73*Proportion375, 30*Proportion375));
        }];
        [self.listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(70*Proportion375 + KTopHeight);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(73*Proportion375, 30*Proportion375));
        }];
        [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(70*Proportion375 + KTopHeight);
            make.right.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(73*Proportion375, 30*Proportion375));
        }];
        [self.giftStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(120*Proportion375 + KTopHeight);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(73*Proportion375, 30*Proportion375));
        }];
        [self.headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(54*Proportion375 + KTopHeight);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(93*Proportion375, 93*Proportion375));
        }];
        
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headPortrait.mas_bottom).with.offset(12*Proportion375);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 27*Proportion375));
        }];
        //        [self.idPreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.nickLab.mas_bottom).with.offset(7*Proportion375);
        //            make.right.equalTo(self.mas_centerX);
        //            make.height.equalTo(@(13*Proportion375));
        //        }];
        [self.idLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.top.equalTo(self.nickLab.mas_bottom).with.offset(6*Proportion375);
            //            make.left.equalTo(self).equalTo(self.idPreLab.mas_right).with.offset(2*Proportion375);
            //            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 16*Proportion375));
            make.top.equalTo(self.nickLab.mas_bottom).with.offset(6*Proportion375);
            make.centerX.equalTo(self);
            //            make.size.mas_equalTo(CGSizeMake(100, 16*Proportion375));
            make.height.equalTo(@(16*Proportion375));
            
        }];
        //        [self.idPreLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.nickLab.mas_bottom).with.offset(7*Proportion375);
        //            make.right.equalTo(self.mas_centerX).with.offset((self.idPreLab.width + self.idLab.mas_width)/2 - self.idPreLab.mas_width);
        //            make.size.mas_equalTo(CGSizeMake(100, 13*Proportion375));
        //        }];
        [self.masterLevel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.idLab.mas_bottom).with.offset(12*Proportion375);
            make.right.equalTo(self.mas_centerX).with.offset(-4*Proportion375);
            make.size.mas_equalTo(CGSizeMake(28*Proportion375, 15*Proportion375));
        }];
        [self.showLevel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.idLab.mas_bottom).with.offset(12*Proportion375);
            make.left.equalTo(self.mas_centerX).with.offset(4*Proportion375);
            make.size.mas_equalTo(CGSizeMake(28*Proportion375, 15*Proportion375));
        }];
        [self.cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.showLevel.mas_bottom).with.offset(6*Proportion375);
            make.centerX.equalTo(self);
            //            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 20*Proportion375));
            make.width.lessThanOrEqualTo(@(100*Proportion375));
            make.width.greaterThanOrEqualTo(@(50*Proportion375));
            make.height.equalTo(@(20*Proportion375));
            
        }];
        [self.constellationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.showLevel.mas_bottom).with.offset(6*Proportion375);
            make.left.equalTo(self.cityLab.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 20*Proportion375));
        }];
        [self.sexbg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.showLevel.mas_bottom).with.offset(6*Proportion375);
            make.right.equalTo(self.cityLab.mas_left).with.offset(-10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 20*Proportion375));
        }];
        [self.sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sexbg).with.offset(5*Proportion375);
            make.left.equalTo(self.sexbg).with.offset(7*Proportion375);
            make.size.mas_equalTo(CGSizeMake(10*Proportion375, 10*Proportion375));
        }];
        [self.sexlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sexbg);
            make.left.equalTo(self.sexImg.mas_right).with.offset(1*Proportion375);
            make.size.mas_equalTo(CGSizeMake(30*Proportion375, 20*Proportion375));
        }];
        [self.wordsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cityLab.mas_bottom).with.offset(20*Proportion375);
            make.left.equalTo(self).with.offset(20*Proportion375);
            make.width.equalTo(@(kMainScreenWidth-40*Proportion375));
        }];
        
        
        //        [self.bottomWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.wordsLab.mas_bottom).with.offset(7);
        //            make.width.equalTo(self);
        //            make.bottom.equalTo(self);
        //
        //        }];
        [self.fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.wordsLab.mas_bottom).with.offset(20*Proportion375);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100*Proportion375, 40*Proportion375));
        }];
        [self.concerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn);
            make.right.equalTo(self.fansBtn.mas_left);
            make.size.mas_equalTo(CGSizeMake(100*Proportion375, 40*Proportion375));
        }];
        [self.walletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn);
            make.left.equalTo(self.fansBtn.mas_right);
            make.size.mas_equalTo(CGSizeMake(100*Proportion375, 40*Proportion375));
        }];
        
        [self.toConcerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(20*Proportion375);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(0, 31*Proportion375));
        }];
        [self.tosendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(20*Proportion375);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(0, 31*Proportion375));
        }];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(20*Proportion375);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(295*Proportion375, 31*Proportion375));
        }];
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userinfoChange:) name:kUserInfoChange object:nil];
        
        
        [self.worksBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth/2, 40*Proportion375));
        }];
        
        [self.likesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.right.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth/2, 40*Proportion375));
        }];
        
        [self.bottomAnimationLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.centerX.equalTo(self.worksBtn);
            make.size.mas_equalTo(CGSizeMake(40*Proportion375, 2*Proportion375));
        }];
    }
    return self;
}

-(void)setIsMe:(BOOL)isMe
{
    _isMe = isMe;
    if (!isMe) {
        self.leftBtn.hidden = NO;
        [self.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(20*Proportion375 + KTopHeight);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(73*Proportion375, 30*Proportion375));
        }];
        [self.listBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headPortrait).with.offset(-10*Proportion375);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(73*Proportion375, 30*Proportion375));
        }];
        
        [self.toConcerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(20*Proportion375);
            make.left.equalTo(self).with.offset(35*Proportion375);
            make.size.mas_equalTo(CGSizeMake((kMainScreenWidth - 70*Proportion375 - 20 *Proportion375)/3, 31*Proportion375));
        }];
        [self.tosendMessageBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(20*Proportion375);
            make.left.equalTo(self.toConcerBtn.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake((kMainScreenWidth - 70*Proportion375 - 20 *Proportion375)/3, 31*Proportion375));
        }];
        [self.shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(20*Proportion375);
            make.left.equalTo(self.tosendMessageBtn.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake((kMainScreenWidth - 70*Proportion375 - 20 *Proportion375)/3, 31*Proportion375));
        }];
        
        self.settingBtn.hidden = YES;
        self.giftStoreBtn.hidden = YES;
    }else{
        self.leftBtn.hidden = YES;
    }
}
-(UILabel *)navLab
{
    if (!_navLab) {
        _navLab = [UILabel labelWithText:@"" textColor:kthemeBlackColor font:Font_Regular(16) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _navLab;
}

-(UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_leftBtn setTitle:@"" forState:UIControlStateNormal];
        //        _leftBtn.titleLabel.font = Font_Medium(12*Proportion375);
        //        [_leftBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        //        [_leftBtn MelineDockTopWithColor:kThemeWhiteColor];
        [_leftBtn setImage:[UIImage imageNamed:@"account_navBack"] forState:UIControlStateNormal];
        [[_leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [PageMgr popActionFromViewcontroller:self.Controller?:(BaseViewController *)self.viewController];
        }];
    }
    return _leftBtn;
}
-(UIButton *)listBtn
{
    if (!_listBtn) {
        _listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listBtn setTitle:@"排行榜" forState:UIControlStateNormal];
        [_listBtn setTitleShadowColor:kThemeShadowColor forState:UIControlStateNormal];
        [_listBtn.titleLabel setShadowOffset:CGSizeMake(1, 1)];
        _listBtn.titleLabel.font = Font_Medium(14*Proportion375);
        [_listBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_listBtn MelineDockTopWithColor:kThemeWhiteColor];
        @weakify(self)
        [[_listBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            [PageMgr pushtoTopListVCwithUid:self.userModel.uid viewcontroller:self.Controller?:(BaseViewController *)self.viewController];
        }];
    }
    return _listBtn;
}
-(UIButton *)giftStoreBtn
{
    if (!_giftStoreBtn) {
        _giftStoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_giftStoreBtn setTitle:@"礼物商城" forState:UIControlStateNormal];
        [_giftStoreBtn setTitleShadowColor:kThemeShadowColor forState:UIControlStateNormal];
        [_giftStoreBtn.titleLabel setShadowOffset:CGSizeMake(1, 1)];
        
        _giftStoreBtn.titleLabel.font = Font_Medium(14*Proportion375);
        [_giftStoreBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_giftStoreBtn MelineDockTopWithColor:kThemeWhiteColor];
        [[_giftStoreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [HDHud showMessageInView:self.viewController.view title:@"敬请期待"];// [PageMgr pushtoTopListVCwithUid:self.userModel.uid];
        }];
    }
    return _giftStoreBtn;
}
- (SLHeadPortrait *)headPortrait
{
    if (!_headPortrait) {
        _headPortrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(0, 53*Proportion375, 95*Proportion375, 95*Proportion375)];
        _headPortrait.centerX = kMainScreenWidth/2;
        _headPortrait.delegate = self;
    }
    return _headPortrait;
}
-(UIButton *)settingBtn
{
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.titleLabel.font = Font_Medium(14*Proportion375);
        [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_settingBtn setTitleShadowColor:kThemeShadowColor forState:UIControlStateNormal];
        [_settingBtn.titleLabel setShadowOffset:CGSizeMake(1, 1)];
        [_settingBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_settingBtn MelineDockTopWithColor:kThemeWhiteColor];
        [[_settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [PageMgr pushtoUserSettingVC];
        }];
    }
    return _settingBtn;
}

-(UILabel *)nickLab
{
    if (!_nickLab) {
        _nickLab = [UILabel labelWithText:AccountUserInfoModel.nickname textColor:kThemeWhiteColor font:Font_Semibold(24*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _nickLab.layer.shadowRadius = 0.0f;
        _nickLab.layer.shadowOpacity = 0.3;
        _nickLab.layer.shadowColor = [UIColor blackColor].CGColor;
        _nickLab.layer.shadowOffset = CGSizeMake(1,1);
        
    }
    return _nickLab;
}
-(SLLevelMarkView *)masterLevel
{
    if (!_masterLevel) {
        _masterLevel = [[SLLevelMarkView alloc]initWithFrame:CGRectMake(0, 0, 30*WScale, 15*WScale) withType:LevelType_Host];
        _masterLevel.level =Int2String(_userModel.masterLevel) ;
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
-(UIView *)sexbg
{
    if (!_sexbg) {
        _sexbg = [[UIView alloc] init];
        _sexbg.clipsToBounds = YES;
        _sexbg.layer.cornerRadius = 10*Proportion375;
        _sexbg.backgroundColor = HexRGBAlpha(0x8a7acc, 1);
        
        //        UILabel * label = [UILabel labelWithFrame:CGRectMake(33*Proportion375, 3.5*Proportion375, 12*Proportion375, 12*Proportion375) text:@"岁" textColor:kThemeWhiteColor font:Font_Medium(12*Proportion375) backgroundColor:[UIColor clearColor]];
        //        label.textAlignment = NSTextAlignmentLeft;
        //        [_sexbg addSubview:label];
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
        _idLab = [UILabel labelWithText:[NSString stringWithFormat:@"%@",AccountUserInfoModel.popularNo] textColor:kThemeWhiteColor font:Font_Regular(16*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _idLab.layer.shadowRadius = 0.0f;
        _idLab.layer.shadowOpacity = 0.3;
        _idLab.layer.shadowColor = [UIColor blackColor].CGColor;
        _idLab.layer.shadowOffset = CGSizeMake(1,1);
        
    }
    return _idLab;
}
//-(UILabel*)idPreLab
//{
//    if (!_idPreLab) {
//        _idPreLab = [UILabel labelWithText:@"秀号" textColor:kThemeWhiteColor font:Font_Medium(13*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
//        _idPreLab.layer.shadowRadius = 0.0f;
//        _idPreLab.layer.shadowOpacity = 0.3;
//        _idPreLab.layer.shadowColor = [UIColor blackColor].CGColor;
//        _idPreLab.layer.shadowOffset = CGSizeMake(1,1);
//
//    }
//    return _idPreLab;
//}

-(UILabel*)cityLab
{
    if (!_cityLab) {
        _cityLab = [UILabel labelWithText:AccountUserInfoModel.city textColor:kThemeWhiteColor font:Font_Semibold(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _cityLab.layer.cornerRadius = 10*Proportion375;
        _cityLab.clipsToBounds = YES;
        _cityLab.backgroundColor = HexRGBAlpha(0x14c5ed, 1);
    }
    return _cityLab;
}
-(UILabel*)constellationLab
{
    if (!_constellationLab) {
        _constellationLab = [UILabel labelWithText:AccountUserInfoModel.constellation textColor:kThemeWhiteColor font:Font_Semibold(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _constellationLab.layer.cornerRadius = 10*Proportion375;
        _constellationLab.clipsToBounds = YES;
        _constellationLab.backgroundColor = HexRGBAlpha(0xeb5299, 1);
        
    }
    return _constellationLab;
}
-(UILabel *)wordsLab
{
    if (!_wordsLab) {
        _wordsLab = [UILabel labelWithText:@"" textColor:kThemeWhiteColor font:Font_Medium(14*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _wordsLab.numberOfLines = 0;
        _wordsLab.preferredMaxLayoutWidth = kMainScreenWidth-40 *Proportion375;
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
        NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:@"0"];
        
        if (!IsStrEmpty(AccountUserInfoModel.fansCount)) {
            firstPart = [[NSMutableAttributedString alloc] initWithString:AccountUserInfoModel.fansCount];
        }
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Font_Regular(20*Proportion375),NSForegroundColorAttributeName:kThemeWhiteColor,};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blueColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"粉丝"];
        NSDictionary * thirdAttributes = @{NSFontAttributeName:Font_Medium(14*Proportion375),NSForegroundColorAttributeName:kThemeWhiteColor,};
        [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
        
        [firstPart appendAttributedString:secondPart];
        [firstPart appendAttributedString:thirdPart];
        @weakify(self)
        [[_fansBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [PageMgr pushFansWithType:1 andUid:self.userModel.uid viewcontroller:self.Controller?:(BaseViewController *)self.viewController];
        }];
        
        [_fansBtn setAttributedTitle:firstPart forState:UIControlStateNormal];
    }
    return _fansBtn;
}

-(UIButton *)concerBtn
{
    if (!_concerBtn) {
        _concerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _concerBtn.titleLabel.numberOfLines = 0;
        _concerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:@"0"];
        //        _concerBtn.backgroundColor = kThemeRedColor;
        
        if (!IsStrEmpty(AccountUserInfoModel.followCount)) {
            firstPart = [[NSMutableAttributedString alloc] initWithString:AccountUserInfoModel.followCount];
        }
        
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Font_Regular(20*Proportion375),NSForegroundColorAttributeName:kThemeWhiteColor,};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blueColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"关注"];
        NSDictionary * thirdAttributes = @{NSFontAttributeName:Font_Medium(14*Proportion375),NSForegroundColorAttributeName:kThemeWhiteColor,};
        [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
        
        [firstPart appendAttributedString:secondPart];
        [firstPart appendAttributedString:thirdPart];
        
        [_concerBtn setAttributedTitle:firstPart forState:UIControlStateNormal];
        @weakify(self)
        [[_concerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [PageMgr pushFansWithType:0 andUid:self.userModel.uid viewcontroller:self.Controller?:(BaseViewController *)self.viewController];
        }];
        
        [_concerBtn setTitleShadowColor:kThemeShadowColor forState:UIControlStateNormal];
        [_concerBtn.titleLabel setShadowOffset:CGSizeMake(1, 1)];
        
    }
    return _concerBtn;
}
-(UIButton *)walletBtn
{
    if (!_walletBtn) {
        _walletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _walletBtn.titleLabel.numberOfLines = 0;
        _walletBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:@"0"];
        
        if (!IsStrEmpty(AccountUserInfoModel.showCoinStr)) {
            firstPart = [[NSMutableAttributedString alloc] initWithString:AccountUserInfoModel.showCoinStr];
        }
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Font_Regular(20*Proportion375),NSForegroundColorAttributeName:kThemeWhiteColor,};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blueColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"钱包"];
        NSDictionary * thirdAttributes = @{NSFontAttributeName:Font_Medium(14*Proportion375),NSForegroundColorAttributeName:kThemeWhiteColor,};
        [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
        
        [firstPart appendAttributedString:secondPart];
        [firstPart appendAttributedString:thirdPart];
        
        [_walletBtn setAttributedTitle:firstPart forState:UIControlStateNormal];
        @weakify(self)
        [[_walletBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [PageMgr pushToWalletController:self.userModel viewcontroller:self.Controller?:(BaseViewController *)self.viewController];
        }];
        [_walletBtn setTitleShadowColor:kThemeShadowColor forState:UIControlStateNormal];
        [_walletBtn.titleLabel setShadowOffset:CGSizeMake(1, 1)];
        
    }
    return _walletBtn;
}
-(UIButton *)toConcerBtn
{
    if (!_toConcerBtn) {
        _toConcerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toConcerBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_toConcerBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _toConcerBtn.titleLabel.font = Font_Semibold(14*Proportion375);
        _toConcerBtn.layer.borderWidth = 0.5*Proportion375;
        _toConcerBtn.layer.borderColor = kThemeWhiteColor.CGColor;
        //        _toConcerBtn.layer.cornerRadius = 6*Proportion375;
        @weakify(self)
        [[_toConcerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self concerAction];
        }];
    }
    return _toConcerBtn;
}
-(UIButton *)tosendMessageBtn
{
    if (!_tosendMessageBtn) {
        _tosendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tosendMessageBtn setTitle:@"发消息" forState:UIControlStateNormal];
        [_tosendMessageBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _tosendMessageBtn.titleLabel.font = Font_Semibold(14*Proportion375);
        _tosendMessageBtn.layer.borderWidth = 0.5*Proportion375;
        _tosendMessageBtn.layer.borderColor = kThemeWhiteColor.CGColor;
        //        _tosendMessageBtn.layer.cornerRadius = 6*Proportion375;
        @weakify(self)
        [[_tosendMessageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [ PageMgr pushToChatViewControllerWithTargetUser:self.userModel];
            //            if (self.delegate && [self.delegate respondsToSelector:@selector(SLUserViewHeaderConcernActionDelegateWithShare)] ) {
            //                [self.delegate SLUserViewHeaderConcernActionDelegateWithShare];
            //            }
        }];
        
    }
    return _tosendMessageBtn;
}
-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"分享主页" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = Font_Semibold(14*Proportion375);
        _shareBtn.layer.borderWidth = 0.5*Proportion375;
        _shareBtn.layer.borderColor = kThemeWhiteColor.CGColor;
        //        _shareBtn.layer.cornerRadius = 6*Proportion375;
        @weakify(self)
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [HDHud showMessageInView:self.viewController.view title:@"敬请期待"];
            //            if (self.delegate && [self.delegate respondsToSelector:@selector(SLUserViewHeaderConcernActionDelegateWithShare)] ) {
            //                [self.delegate SLUserViewHeaderConcernActionDelegateWithShare];
            //            }
            
        }];
        
    }
    return _shareBtn;
}
-(UIButton *)worksBtn
{
    if (!_worksBtn) {
        _worksBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _worksBtn.titleLabel.font = Font_Medium(15*Proportion375);
        [_worksBtn setTitle:@"作品" forState:UIControlStateNormal];
        [_worksBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_worksBtn setBackgroundColor:kthemeBlackColor forState:UIControlStateNormal];
        [[_worksBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.bottomAnimationLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.centerX.equalTo(self.worksBtn);
                make.size.mas_equalTo(CGSizeMake(40*Proportion375, 1*Proportion375));
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
        _likesBtn.titleLabel.font = Font_Medium(15*Proportion375);
        [_likesBtn setTitle:@"喜欢" forState:UIControlStateNormal];
        [_likesBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_likesBtn setBackgroundColor:kthemeBlackColor forState:UIControlStateNormal];
        [[_likesBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [HDHud showMessageInView:self title:@"敬请期待"];
        }];
        
    }
    return _likesBtn;
}
//刷新ui
- (void)userinfoChange:(NSNotification *)notif
{
    [self setLabelSpace:self.wordsLab withValue:@"" withFont:Font_Regular(14*Proportion375)];
    [_headPortrait setRoundStyle:YES imageUrl:AccountUserInfoModel.avatar imageHeight:95 vip:[_userModel.uid isEqualToString:kSystemNumber_RongCloud]?:NO attestation:NO];
    [_nickLab setText:AccountUserInfoModel.nickname];
    _sexImg .image=[AccountUserInfoModel.gender  isEqualToString:@"1"]?[UIImage imageNamed:@"userhome_sex_man"]:[UIImage imageNamed:@"userhome_sex_women"];
    
}

-(UIView *)bottomAnimationLine
{
    if (!_bottomAnimationLine) {
        _bottomAnimationLine = [[UIView alloc] init];
        _bottomAnimationLine.backgroundColor = kThemeWhiteColor;
    }
    return _bottomAnimationLine;
}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    if (!str.length) {
        return;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 0; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //    设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
    self.labelHeight = label.height;
}

@end
