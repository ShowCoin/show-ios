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
@implementation SLUserViewHeader
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = kThemeWhiteColor;
    if (self) {
        [self addSubview:self.headImgView];
        [self addSubview:self.effColorView];
        [self addSubview:self.effectview];
        [self addSubview:self.navLab];
        [self addSubview:self.listBtn];
        [self addSubview:self.settingBtn];
        [self addSubview:self.headPortrait];
        [self addSubview:self.nickLab];
        [self addSubview:self.masterLevel];
        [self addSubview:self.showLevel];

        [self addSubview:self.sexbg];
        [self.sexbg addSubview:self.sexImg];
        [self.sexbg addSubview:self.sexlab];
        [self addSubview:self.idLab];
        [self addSubview:self.cityLab];
        [self addSubview:self.constellationLab];
        [self addSubview:self.wordsLab];
        [self addSubview:self.bottomWhiteView];
        
        [self addSubview:self.fansBtn];
        [self addSubview:self.concerBtn];
        [self addSubview:self.walletBtn];
        [self addSubview:self.toConcerBtn];
        [self addSubview:self.shareBtn];

        [self addSubview:self.worksBtn];
        [self addSubview:self.likesBtn];
        

        [self.navLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_top).with.offset(44*Proportion375);
            make.left.equalTo(self);
            
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 30*Proportion375));
        }];
        [self.listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(75*Proportion375);
            make.left.equalTo(self).with.offset(-15*Proportion375);
            make.size.mas_equalTo(CGSizeMake(95*Proportion375 + 15*Proportion375, 30*Proportion375));
        }];
        [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(75*Proportion375);
            make.right.equalTo(self).with.offset(15*Proportion375);
            make.size.mas_equalTo(CGSizeMake(95*Proportion375, 30*Proportion375));
        }];
        [self.headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(72*Proportion375);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(75*Proportion375, 75*Proportion375));
        }];
        
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headPortrait.mas_bottom).with.offset(20*Proportion375);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 16*Proportion375));
        }];
        [self.masterLevel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickLab.mas_bottom).with.offset(2*Proportion375);
            make.right.equalTo(self.mas_centerX).with.offset(-2);
            make.size.mas_equalTo(CGSizeMake(30, 15));
        }];
        [self.showLevel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickLab.mas_bottom).with.offset(2*Proportion375);
            make.left.equalTo(self.mas_centerX).with.offset(2);
            make.size.mas_equalTo(CGSizeMake(30, 15));
        }];
        [self.idLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickLab.mas_bottom).with.offset(22*Proportion375);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 12*Proportion375));
        }];
        [self.cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.idLab.mas_bottom).with.offset(5*Proportion375);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 20*Proportion375));
        }];
        [self.constellationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.idLab.mas_bottom).with.offset(5*Proportion375);
            make.left.equalTo(self.cityLab.mas_right).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 20*Proportion375));
        }];
        [self.sexbg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.idLab.mas_bottom).with.offset(5*Proportion375);
            make.right.equalTo(self.cityLab.mas_left).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 20*Proportion375));
        }];
        [self.sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sexbg);
            make.left.equalTo(self.sexbg).with.offset(2*Proportion375);
            make.size.mas_equalTo(CGSizeMake(18*Proportion375, 20*Proportion375));
        }];
        [self.sexlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sexbg);
            make.left.equalTo(self.sexImg.mas_right);
            make.size.mas_equalTo(CGSizeMake(30*Proportion375, 20*Proportion375));
        }];
        
        [self.wordsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cityLab.mas_bottom).with.offset(13*Proportion375);
            make.left.equalTo(self).with.offset(20*Proportion375);
            make.width.equalTo(@(kMainScreenWidth-40*Proportion375));
        }];
        
        [self.bottomWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.wordsLab.mas_bottom).with.offset(7);
            make.width.equalTo(self);
            make.bottom.equalTo(self);

        }];
        [self.fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.wordsLab.mas_bottom).with.offset(15);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 50*Proportion375));
        }];
        [self.concerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn);
            make.left.equalTo(self.fansBtn.mas_right);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 50*Proportion375));
        }];
        [self.walletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn);
            make.left.equalTo(self).with.offset(kMainScreenWidth/2);
            make.size.mas_equalTo(CGSizeMake(180*Proportion375, 50*Proportion375));
        }];
        
        [self.toConcerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(10*Proportion375);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(0, 40*Proportion375));
        }];
        
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(10*Proportion375);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth - 20*Proportion375, 40*Proportion375));
        }];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userinfoChange:) name:kUserInfoChange object:nil];

        
        [self.worksBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth/2, 45*Proportion375));
        }];
        
        [self.likesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.right.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth/2, 45*Proportion375));
        }];
    }
    return self;
}

-(void)setIsMe:(BOOL)isMe
{
    _isMe = isMe;
    if (!isMe) {
        [self.toConcerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(10*Proportion375);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(115*Proportion375, 40*Proportion375));
        }];
        
        [self.shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansBtn.mas_bottom).with.offset(10*Proportion375);
            make.left.equalTo(self.toConcerBtn.mas_right).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth - 30*Proportion375-115*Proportion375, 40*Proportion375));
        }];
        
        self.settingBtn.hidden = YES;
    }
}
//刷新ui
- (void)userinfoChange:(NSNotification *)notif
{
    [self setLabelSpace:self.wordsLab withValue:@"" withFont:Font_Medium(12)];
    [_headPortrait setRoundStyle:YES imageUrl:AccountUserInfoModel.avatar imageHeight:45 vip:NO attestation:NO];
    [_nickLab setText:AccountUserInfoModel.nickname];
    _sexImg .image=[AccountUserInfoModel.gender  isEqualToString:@"1"]?[UIImage imageNamed:@"userhome_sex_man"]:[UIImage imageNamed:@"userhome_sex_women"];

}
-(UILabel *)navLab
{
    if (!_navLab) {
        _navLab = [UILabel labelWithText:@"" textColor:kthemeBlackColor font:Font_Regular(16) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _navLab;
}

-(UIButton *)listBtn
{
    if (!_listBtn) {
        _listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _listBtn.backgroundColor = kThemeWhiteColor;
        _listBtn.layer.cornerRadius = 15*Proportion375;
        _listBtn.layer.borderColor = kGrayBGColor.CGColor;
        _listBtn.layer.borderWidth = 1.0;
        
        [_listBtn setTitle:@"排行榜" forState:UIControlStateNormal];
        _listBtn.titleLabel.font = Font_Regular(12*Proportion375);
        [_listBtn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
        [_listBtn setImage:[UIImage imageNamed:@"userhome_toplist_img"] forState:UIControlStateNormal];
        _listBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10*Proportion375, 0, 0);
        [[_listBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [PageMgr pushtoTopListVC];
        }];
    }
    return _listBtn;
}

- (SLHeadPortrait *)headPortrait
{
    if (!_headPortrait) {
        _headPortrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(0, 72*Proportion375, 75*Proportion375, 75*Proportion375)];
        _headPortrait.centerX = kMainScreenWidth/2;
        _headPortrait.delegate = self;
    }
    return _headPortrait;
}
-(UIButton *)settingBtn
{
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.titleLabel.font = Font_Regular(12*Proportion375);
        _settingBtn.backgroundColor = kThemeWhiteColor;
        _settingBtn.layer.cornerRadius = 15*Proportion375;
        _settingBtn.layer.borderColor = kGrayBGColor.CGColor;
        _settingBtn.layer.borderWidth = 1.0;
        
        [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_settingBtn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
        [_settingBtn setImage:[UIImage imageNamed:@"userhome_setting_img"] forState:UIControlStateNormal];
        _settingBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10*Proportion375);
        [[_settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            [PageMgr pushtoUserSettingVC];
        }];
    }
    return _settingBtn;
}

-(UILabel *)nickLab
{
    if (!_nickLab) {
        _nickLab = [UILabel labelWithText:AccountUserInfoModel.nickname textColor:kThemeWhiteColor font:Font_Medium(16) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _nickLab;
}
-(SLLevelMarkView *)masterLevel
{
    if (!_masterLevel) {
        _masterLevel = [[SLLevelMarkView alloc]initWithFrame:CGRectMake(0, 0, 30, 15) withType:LevelType_Host];
        _masterLevel.level =@"100";
        _masterLevel.clipsToBounds = YES;
    }
    return _masterLevel;
}
-(SLLevelMarkView *)showLevel
{
    if (!_showLevel) {
        _showLevel = [[SLLevelMarkView alloc]initWithFrame:CGRectMake(0, 0, 30, 15) withType:LevelType_ShowCoin];
        _showLevel.level =@"99";
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
        _sexbg.backgroundColor = kThemeRedColor;
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
        _sexlab = [UILabel labelWithText:@"22" textColor:kThemeWhiteColor font:Font_Trebuchet(12) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _sexlab.clipsToBounds = YES;
    }
    return _sexlab;
}

-(UILabel*)idLab
{
    if (!_idLab) {
        _idLab = [UILabel labelWithText:AccountUserInfoModel.popularNo textColor:kThemeWhiteColor font:Font_Trebuchet(12) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        
    }
    return _idLab;
}



-(UILabel*)cityLab
{
    if (!_cityLab) {
        _cityLab = [UILabel labelWithText:AccountUserInfoModel.city textColor:kThemeWhiteColor font:Font_Medium(12) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _cityLab.layer.cornerRadius = 10*Proportion375;
        _cityLab.clipsToBounds = YES;
        _cityLab.backgroundColor = [UIColor blueColor];
    }
    return _cityLab;
}
-(UILabel*)constellationLab
{
    if (!_constellationLab) {
        _constellationLab = [UILabel labelWithText:AccountUserInfoModel.constellation textColor:kThemeWhiteColor font:Font_Medium(12) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _constellationLab.layer.cornerRadius = 10*Proportion375;
        _constellationLab.clipsToBounds = YES;
        _constellationLab.backgroundColor = [UIColor purpleColor];

    }
    return _constellationLab;
}
-(UILabel *)wordsLab
{
    if (!_wordsLab) {
        _wordsLab = [UILabel labelWithText:@"" textColor:kThemeWhiteColor font:Font_Medium(12) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
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
        _headImgView.contentMode =UIViewContentModeScaleAspectFill;
        
    }
    return _headImgView;
}
-(UIView *)effColorView
{
    if (!_effColorView) {
        _effColorView  = [[UIView alloc] init];
        _effColorView.backgroundColor = HexRGBAlpha(0x1c0072, 0.4);
    }
    return _effColorView;
}
-(UIVisualEffectView *)effectview
{
    if (!_effectview) {
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        _effectview.alpha = 0.97;
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
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Font_Trebuchet(18*Proportion375),NSForegroundColorAttributeName:kthemeBlackColor,};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blueColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"粉丝"];
        NSDictionary * thirdAttributes = @{NSFontAttributeName:Font_Regular(11*Proportion375),NSForegroundColorAttributeName:kGrayWith999999,};
        [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
        
        [firstPart appendAttributedString:secondPart];
        [firstPart appendAttributedString:thirdPart];
        [[_fansBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [PageMgr pushFans];
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

        if (!IsStrEmpty(AccountUserInfoModel.followCount)) {
            firstPart = [[NSMutableAttributedString alloc] initWithString:AccountUserInfoModel.followCount];
        }

        NSDictionary * firstAttributes = @{ NSFontAttributeName:Font_Trebuchet(18*Proportion375),NSForegroundColorAttributeName:kthemeBlackColor,};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blueColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"关注"];
        NSDictionary * thirdAttributes = @{NSFontAttributeName:Font_Regular(11*Proportion375),NSForegroundColorAttributeName:kGrayWith999999,};
        [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
        
        [firstPart appendAttributedString:secondPart];
        [firstPart appendAttributedString:thirdPart];

        [_concerBtn setAttributedTitle:firstPart forState:UIControlStateNormal];

    }
    return _concerBtn;
}
-(UIButton *)walletBtn
{
    if (!_walletBtn) {
        _walletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _walletBtn.titleLabel.numberOfLines = 0;
        _walletBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _walletBtn.layer.cornerRadius = 8*Proportion375;
        _walletBtn.layer.borderColor = kthemeBlackColor.CGColor;
        _walletBtn.layer.borderWidth = 2;
        
        NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:@"0"];
        
        if (!IsStrEmpty(AccountUserInfoModel.showCoinNum)) {
            firstPart = [[NSMutableAttributedString alloc] initWithString:AccountUserInfoModel.showCoinNum];
        }
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Font_Trebuchet(18*Proportion375),NSForegroundColorAttributeName:kthemeBlackColor,};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blueColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"秀币"];
        NSDictionary * thirdAttributes = @{NSFontAttributeName:Font_Regular(11*Proportion375),NSForegroundColorAttributeName:kGrayWith999999,};
        [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
        
        [firstPart appendAttributedString:secondPart];
        [firstPart appendAttributedString:thirdPart];
        
        [_walletBtn setAttributedTitle:firstPart forState:UIControlStateNormal];
        [[_walletBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [PageMgr pushToWalletController];
        }];

    }
    return _walletBtn;
}
-(UIButton *)toConcerBtn
{
    if (!_toConcerBtn) {
        _toConcerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toConcerBtn setTitle:@"已关注" forState:UIControlStateNormal];
        _toConcerBtn.layer.borderWidth = 1;
        _toConcerBtn.layer.borderColor = kGrayWith999999.CGColor;
        [_toConcerBtn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
        @weakify(self)
        [[_toConcerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self concerAction];
        }];
    }
    return _toConcerBtn;
}
-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"分享主页" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = Font_Regular(15*Proportion375);
        [_shareBtn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
        _shareBtn.layer.borderWidth = 1;
        _shareBtn.layer.borderColor = kGrayWith999999.CGColor;
        @weakify(self)
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            if (self.delegate && [self.delegate respondsToSelector:@selector(SLUserViewHeaderConcernActionDelegateWithShare)] ) {
                [self.delegate SLUserViewHeaderConcernActionDelegateWithShare];
            }
        }];

    }
    return _shareBtn;
}
-(UIButton *)worksBtn
{
    if (!_worksBtn) {
        _worksBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_worksBtn setTitle:@"作品" forState:UIControlStateNormal];
        [_worksBtn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
    }
    return _worksBtn;
}
-(UIButton *)likesBtn
{
    if (!_likesBtn) {
        _likesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likesBtn setTitle:@"喜欢" forState:UIControlStateNormal];
        [_likesBtn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
    }
    return _likesBtn;
}

#pragma mark---------method-----------

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    if (!str.length) {
        return;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 5*Proportion375; //设置行间距
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
//    CGSize size = CGSizeMake(kMainScreenWidth-40, CGFLOAT_MAX);
//    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attributeStr];
//    _wordsHeight = layout.textBoundingSize.height;

}

#pragma mark- datas
-(void)setUserModel:(ShowUserModel *)userModel
{
    _userModel = userModel;
    [self.headPortrait setRoundStyle:YES imageUrl:_userModel.avatar imageHeight:75*Proportion375 vip:NO attestation:NO];
    [self.nickLab setText:_userModel.nickname];
    [self.sexImg setImage:userModel.gender.integerValue == 1?[UIImage imageNamed:@"userhome_sex_man"]:[UIImage imageNamed:@"userhome_sex_women"]];
    [self.sexlab setText:[NSString stringWithFormat:@"%@岁",_userModel.age]];
    [self.idLab setText:[NSString stringWithFormat:@"ID %@",_userModel.popularNo]];
    [self.constellationLab setText:[NSString stringWithFormat:@"%@",_userModel.constellation]];
    [self.cityLab setText:IsStrEmpty(_userModel.city)?@"未知":_userModel.city];
    if (_userModel.isFollowed.boolValue) {
        [self.toConcerBtn setTitle:@"已关注" forState:UIControlStateNormal];
        self.toConcerBtn.userInteractionEnabled = NO;
    }else{
        [self.toConcerBtn setTitle:@"关注" forState:UIControlStateNormal];
        self.toConcerBtn.userInteractionEnabled = YES;

    }
    [self setLabelSpace:self.wordsLab withValue:_userModel.descriptions withFont:Font_Medium(12)];
    
    [self setAttributeBtnTextWithButton:self.fansBtn andStr:_userModel.fansCount];
    [self setAttributeBtnTextWithButton:self.concerBtn andStr:_userModel.followCount];
    [self setAttributeBtnTextWithButton:self.walletBtn andStr:_userModel.showCoinNum];

    
    [self.headImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kMainScreenWidth,247*Proportion375 + self.labelHeight + 7));
    }];
    
    [self.effColorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView);
        make.bottom.equalTo(self.headImgView);
        make.size.mas_equalTo(self.headImgView);
    }];
    [self.effectview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView);
        make.bottom.equalTo(self.headImgView);
        make.size.mas_equalTo(self.headImgView);
    }];
    [self.headImgView yy_setImageWithURL:[NSURL URLWithString:_userModel.large_avatar] placeholder:[UIImage imageNamed:@""]];
}

-(void)setAttributeBtnTextWithButton:(UIButton *)sender andStr:(NSString *)str
{
    NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:@"0"];
    if (sender == self.fansBtn) {
        
        if (!IsStrEmpty(str)) {
            firstPart = [[NSMutableAttributedString alloc] initWithString:str];
        }
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Font_Trebuchet(18*Proportion375),NSForegroundColorAttributeName:kthemeBlackColor,};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blueColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"粉丝"];
        NSDictionary * thirdAttributes = @{NSFontAttributeName:Font_Regular(11*Proportion375),NSForegroundColorAttributeName:kGrayWith999999,};
        [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
        
        [firstPart appendAttributedString:secondPart];
        [firstPart appendAttributedString:thirdPart];
        
        [self.fansBtn setAttributedTitle:firstPart forState:UIControlStateNormal];

    }else if (sender == self.concerBtn){
        
        if (!IsStrEmpty(str)) {
            firstPart = [[NSMutableAttributedString alloc] initWithString:str];
        }
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Font_Trebuchet(18*Proportion375),NSForegroundColorAttributeName:kthemeBlackColor,};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blueColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"关注"];
        NSDictionary * thirdAttributes = @{NSFontAttributeName:Font_Regular(11*Proportion375),NSForegroundColorAttributeName:kGrayWith999999,};
        [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
        
        [firstPart appendAttributedString:secondPart];
        [firstPart appendAttributedString:thirdPart];
        
        [self.concerBtn setAttributedTitle:firstPart forState:UIControlStateNormal];

    }else{
        if (!IsStrEmpty(str)) {
            firstPart = [[NSMutableAttributedString alloc] initWithString:str];
        }
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Font_Trebuchet(18*Proportion375),NSForegroundColorAttributeName:kthemeBlackColor,};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blueColor],};
        [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
        
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"秀币"];
        NSDictionary * thirdAttributes = @{NSFontAttributeName:Font_Regular(11*Proportion375),NSForegroundColorAttributeName:kGrayWith999999,};
        [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
        
        [firstPart appendAttributedString:secondPart];
        [firstPart appendAttributedString:thirdPart];
        
        [self.walletBtn setAttributedTitle:firstPart forState:UIControlStateNormal];
    }
}

-(void)concerAction{
    SLFollowUserAction *action  = [SLFollowUserAction action];
    
    action.to_uid = self.userModel.uid;
    if (self.userModel.isFollowed.integerValue == 1) {
        action.type = 1;
    }else{
        action.type = 0;
    }
    @weakify(self);
    [self sl_startRequestAction:action Sucess:^(id result) {
        @strongify(self);
        if (self.userModel.isFollowed.integerValue == 1) {
            self.userModel.isFollowed = @"0";
        }else{
            self.userModel.isFollowed = @"1";
        }
//        [self.delegate SLUserViewHeaderConcernActionDelegateWithModel:self._userModel];
        
    } FaildBlock:^(NSError *error) {
        
    }];
}
- (void)headPortraitClickAuthor
{
    [PageMgr pushtoUserInfoVC];
}
@end
