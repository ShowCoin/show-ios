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

是
@end
