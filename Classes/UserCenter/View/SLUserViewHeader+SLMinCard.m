//
//  SLUserViewHeader+SLMinCard.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/5/5.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLUserViewHeader+SLMinCard.h"
#import <YYTextLayout.h>

@implementation SLUserViewHeader (SLMinCard)


- (instancetype)initWithFrame:(CGRect)frame Mincard:(BOOL)mincard
{
    self = [super initWithFrame:frame];
    self.backgroundColor = kThemeWhiteColor;
    self.isMiniCard = YES ;
    
    _shadowColor = [[NSShadow alloc] init];
    _shadowColor.shadowBlurRadius = 1; //模糊度(宽度？)
    _shadowColor.shadowColor = kThemeShadowColor;
    _shadowColor.shadowOffset = CGSizeMake(1, 1);//正数是往右边跟下边延伸
    
    if (self) {
        [self addSubview:self.headImgView];
        //        [self addSubview:self.effColorView];
        [self addSubview:self.effectview];
        
        self.scrollerContentView = [[UIScrollView alloc]init];
        self.scrollerContentView.showsVerticalScrollIndicator = NO ;
        self.scrollerContentView.showsHorizontalScrollIndicator = NO ;
        [self addSubview:self.scrollerContentView];
        
        [self.scrollerContentView addSubview:self.headPortrait];
        [self.scrollerContentView addSubview:self.nickLab];
        [self.scrollerContentView addSubview:self.masterLevel];
        [self.scrollerContentView addSubview:self.showLevel];
        
        [self.scrollerContentView addSubview:self.sexbg];
        [self.sexbg addSubview:self.sexImg];
        [self.sexbg addSubview:self.sexlab];
        
        [self.scrollerContentView addSubview:self.idLab];
        [self.scrollerContentView addSubview:self.cityLab];
        [self.scrollerContentView addSubview:self.constellationLab];
        [self.scrollerContentView addSubview:self.wordsLab];
        
        [self.scrollerContentView addSubview:self.fansBtn];
        [self.scrollerContentView addSubview:self.concerBtn];
        [self.scrollerContentView addSubview:self.walletBtn];
        
        [self addSubview:self.toConcerBtn];
        [self addSubview:self.tosendMessageBtn];
        [self addSubview:self.shareBtn];
        
        [self addSubview:self.worksBtn];
        [self addSubview:self.likesBtn];
        [self addSubview:self.bottomAnimationLine];
        
        
        [self.scrollerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollerContentView);
            make.left.equalTo(self.scrollerContentView);
            make.width.equalTo(self.scrollerContentView);
            make.height.equalTo(self.scrollerContentView).with.offset(-40*Proportion375 + KTopHeight);
        }];
        
        [self.effectview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgView);
            make.bottom.equalTo(self.headImgView);
            make.size.mas_equalTo(self.headImgView);
        }];
    
        [self.headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollerContentView).with.offset(54*Proportion375 + KTopHeight);
            make.centerX.equalTo(self.scrollerContentView);
            make.size.mas_equalTo(CGSizeMake(93*Proportion375, 93*Proportion375));
        }];
        
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headPortrait.mas_bottom).with.offset(12*Proportion375);
            make.left.equalTo(self.scrollerContentView);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 27*Proportion375));
        }];

        [self.idLab mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.nickLab.mas_bottom).with.offset(6*Proportion375);
            make.centerX.equalTo(self.scrollerContentView);
            make.height.equalTo(@(16*Proportion375));
        }];
 
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
            make.centerX.equalTo(self.scrollerContentView);
            make.width.lessThanOrEqualTo(@(100*Proportion375));
            make.width.greaterThanOrEqualTo(@(50*Proportion375));
            make.height.equalTo(@(20*Proportion375));
            
        }];
 
    return self;
}



- (void)adjustMiniCard{
    self.listBtn.hidden = YES ;
    self.giftStoreBtn.hidden = YES ;
    self.settingBtn.hidden = YES;
    self.shareBtn.hidden = YES ;
    self.worksBtn.hidden = YES ;
    self.likesBtn.hidden = YES ;
    self.leftBtn.hidden = YES ;
    
    [self.headImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(self);
    }];
}

@end
