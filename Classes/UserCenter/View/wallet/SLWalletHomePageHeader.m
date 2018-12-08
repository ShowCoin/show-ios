//
//  SLWalletHomePageHeader.m
//  ShowLive
//
//  Created by vning on 2018/10/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLWalletHomePageHeader.h"
#import "PTTradeViewController.h"

@implementation SLWalletHomePageHeader

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBlackWith17;

        [self addSubview:self.BGTopimgView];
        [self addSubview:self.BGBottomimgView];
        [self.BGBottomimgView addSubview:self.graphView];
        [self.BGTopimgView addSubview:self.headerImage];
        [self.BGTopimgView addSubview:self.NameLab];
        [self.BGTopimgView addSubview:self.showNumLab];
        [self.BGTopimgView addSubview:self.showLab];

        [self.BGTopimgView addSubview:self.showTLab];
        [self.BGTopimgView addSubview:self.showPriceLab];
        [self.BGTopimgView addSubview:self.otherTLab];
        [self.BGTopimgView addSubview:self.otherPriceLab];
        [self.BGTopimgView addSubview:self.allTLab];
        [self.BGTopimgView addSubview:self.allPriceLab];

        [self.BGBottomimgView addSubview:self.showPriceChangeLab];
        [self.BGBottomimgView addSubview:self.showPriceTitleLab];
        [self.BGBottomimgView addSubview:self.showPriceDisplayLab];
        [self.BGBottomimgView addSubview:self.showPriceDisplayImg];
        
        [self.BGBottomimgView addSubview:self.showDayLowPriceLabNum];
        [self.BGBottomimgView addSubview:self.showDayLowPriceLab];
        [self.BGBottomimgView addSubview:self.showDayHighPriceLabNum];
        [self.BGBottomimgView addSubview:self.showDayHighPriceLab];
        
        [self.BGBottomimgView addSubview:self.showDayDealLabNum];
        [self.BGBottomimgView addSubview:self.showDayDealLab];
        [self.BGBottomimgView addSubview:self.showValueLabNum];
        [self.BGBottomimgView addSubview:self.showValueLab];
        [self.BGBottomimgView addSubview:self.showMarketNum];
        
//        [self.BGimgView addSubview:self.dealButton];
        
        self.lineMaxValue = 0;
        self.lineMinValue = 0;
        
        
}
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
