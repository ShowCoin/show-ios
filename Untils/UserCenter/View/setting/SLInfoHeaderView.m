//
//  SLInfoHeaderView.m
//  ShowLive
//
//  Created by vning on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLInfoHeaderView.h"
@interface SLInfoHeaderView()
@end
@implementation SLInfoHeaderView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.BgImgView];
        [self addSubview:self.effColorView];
//        [self addSubview:self.effectview];
        [self addSubview:self.whiteView];
        [self addSubview:self.avaImg];
        [self addSubview:self.cameraBtn];
        [self addSubview:self.tipLab];
        
//        [self.BgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self);
//            make.left.equalTo(self);
//            make.size.mas_equalTo(self);
//        }];
        [self.effColorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.self);
            make.bottom.equalTo(self.self);
            make.size.mas_equalTo(self.self);
        }];
//        [self.effectview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self);
//            make.left.equalTo(self);
//            make.size.mas_equalTo(self);
//        }];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(145*Proportion375));
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, self.height- 145*Proportion375));
        }];
        [self.avaImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(@(100*Proportion375));
            make.size.mas_equalTo(CGSizeMake(90*Proportion375, 90*Proportion375));
        }];

        [self.cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(@(100*Proportion375));
            make.size.mas_equalTo(CGSizeMake(90*Proportion375, 90*Proportion375));
        }];

        [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.cameraBtn.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 11));
        }];
    }
    return self;
}

-(UIImageView *)BgImgView
{
    if (!_BgImgView) {
        _BgImgView = [[UIImageView alloc] init];
        _BgImgView.contentMode = UIViewContentModeScaleAspectFill;
        _BgImgView.clipsToBounds = YES;
        _BgImgView.backgroundColor = kThemeWhiteColor;
    }
    return _BgImgView;
}

-(UIVisualEffectView *)effectview
{
    if (!_effectview) {
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        _effectview.alpha = 0.97;
    }
    return _effectview;
}
-(UIView *)effColorView
{
    if (!_effColorView) {
        _effColorView  = [[UIView alloc] init];
        _effColorView.backgroundColor = kBlackThemeColor;
    }
    return _effColorView;
}
-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = kBlackThemeBGColor;
    }
    return _whiteView;
}

-(UIImageView *)avaImg
{
    if (!_avaImg) {
        _avaImg = [[UIImageView alloc]init];
        _avaImg.backgroundColor = [UIColor clearColor];
        _avaImg.contentMode = UIViewContentModeScaleAspectFill;
        _avaImg.clipsToBounds = YES;
        [_avaImg.layer setCornerRadius:45*Proportion375];
    }
    return _avaImg;
}

-(UIButton *)cameraBtn
{
    if (!_cameraBtn) {
        _cameraBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraBtn.backgroundColor = HexRGBAlpha(0x000000, 0.4);
        [_cameraBtn.layer setCornerRadius:45*Proportion375];
        [_cameraBtn setImage:[UIImage imageNamed:@"userhome_avatar_change"] forState:UIControlStateNormal];
        _cameraBtn.layer.borderColor = kBlackThemeBGColor.CGColor;
        _cameraBtn.layer.borderWidth = 6;
        [[_cameraBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [PageMgr pushtoChangeheadportraitController];
        }];
    }
    return _cameraBtn;
}
-(UILabel *)tipLab
{
    if (!_tipLab) {
        _tipLab = [UILabel labelWithText:@"点击更换头像" textColor:kGrayWith999999 font:Font_Regular(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _tipLab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
