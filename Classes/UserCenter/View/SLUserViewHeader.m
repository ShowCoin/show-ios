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

@end
