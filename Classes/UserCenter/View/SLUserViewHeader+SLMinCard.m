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
        
        
@end
