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

@end
