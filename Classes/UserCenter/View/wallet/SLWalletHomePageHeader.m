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
-(UIImageView *)BGTopimgView
{
    if (!_BGTopimgView) {
        _BGTopimgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 314*Proportion375 + KNaviBarSafeBottomMargin)];
        _BGTopimgView.contentMode = UIViewContentModeScaleToFill;
        [_BGTopimgView setImage:[UIImage imageNamed:@"wallet_homepage_bg_top"]];
        _BGTopimgView.backgroundColor  = [UIColor redColor];
        _BGTopimgView.clipsToBounds = YES;
        _BGTopimgView.userInteractionEnabled = YES;
    }
    return _BGTopimgView;
}
-(UIImageView *)BGBottomimgView
{
    if (!_BGBottomimgView) {
        _BGBottomimgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _BGTopimgView.bottom, self.frame.size.width, 225*Proportion375)];
        _BGBottomimgView.contentMode = UIViewContentModeScaleToFill;
        [_BGBottomimgView setImage:[UIImage imageNamed:@"wallet_homepage_bg_bottom"]];
//        _BGBottomimgView.backgroundColor  = kBlackWith17;

        _BGBottomimgView.clipsToBounds = YES;
        _BGBottomimgView.userInteractionEnabled = YES;
    }
    return _BGBottomimgView;
}
-(FBYLineGraphView *)graphView
{
    if (!_graphView) {
        _graphView = [[FBYLineGraphView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, _BGBottomimgView.height)];
        _graphView.alpha = 0.3;
//        _graphView.backgroundColor = kTextWhitef7f7f7;
        // 设置折线图属性
//        _graphView.title = @"折线统计图"; // 折线图名称
//        _graphView.maxValue = 100;   // 最大值
//        _graphView.yMarkTitles = @[@"0",@"100"]; // Y轴刻度标签
//        [_graphView setXMarkTitlesAndValues:@[@{@"item":@"1月1日",@"count":@10},@{@"item":@"1月2日",@"count":@80},@{@"item":@"1月3日",@"count":@68},@{@"item":@"1月4日",@"count":@90},@{@"item":@"1月5日",@"count":@60},@{@"item":@"1月6日",@"count":@56},@{@"item":@"1月7日",@"count":@11}] titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值
//        //     LineGraphView.xScaleMarkLEN = 60;
//        //设置完数据等属性后绘图折线图
//        [_graphView mapping];
    }
    return _graphView;
}
- (SLHeadPortrait*)headerImage{
    if (!_headerImage) {
        _headerImage = [[SLHeadPortrait alloc]initWithFrame:CGRectMake(kMainScreenWidth/2-58*Proportion375/2, 20*Proportion375 + KNaviBarHeight, 58*Proportion375, 58*Proportion375)];
        [_headerImage setRoundStyle:YES imageUrl:AccountUserInfoModel.avatar imageHeight:45 vip:NO attestation:NO];
        _headerImage.backgroundColor = [UIColor clearColor];
    }
    return _headerImage;
}
-(UILabel*)NameLab
{
    if (!_NameLab) {
        _NameLab = [UILabel labelWithFrame:CGRectMake(0, _headerImage.bottom+10*WScale,  kMainScreenWidth, 18*Proportion375) text:AccountUserInfoModel.nickname textColor:kTextWhitef7f7f7 font:Font_Regular(16*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _NameLab;
}
-(UILabel*)showNumLab
{
    if (!_showNumLab) {
        _showNumLab = [UILabel labelWithFrame:CGRectMake(0, _NameLab.bottom+14*Proportion375, self.width, 35*Proportion375) text:@"0" textColor:kGoldWithNorm font:Font_engRegular(35*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        
    }
    return _showNumLab;
}
-(UILabel*)showLab
{
    if (!_showLab) {
        _showLab = [UILabel labelWithFrame:CGRectMake(0, _headerImage.bottom+80*Proportion375, self.width, 13*Proportion375) text:@"SHOW" textColor:kTextWith8b font:Font_Regular(13*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        
    }
    return _showLab;
}
-(UILabel*)showTLab
{
    if (!_showTLab) {
        _showTLab = [UILabel labelWithFrame:CGRectMake(0, _headerImage.bottom + 110 *Proportion375, 80*Proportion375, 10*Proportion375) text:@"SHOW" textColor:kTextWith8b font:Font_Regular(10*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _showTLab.right = kMainScreenWidth -16*Proportion375;
    }
    return _showTLab;
}
-(UILabel*)showPriceLab
{
    if (!_showPriceLab) {
        _showPriceLab = [UILabel labelWithFrame:CGRectMake(0, _showTLab.top, self.width, 10*Proportion375) text:@"0CNY" textColor:kTextWith8b font:Font_engRegular(10*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _showPriceLab.right = kMainScreenWidth - 60*Proportion375;

    }
    return _showPriceLab;
}
-(UILabel*)otherTLab
{
    if (!_otherTLab) {
        _otherTLab = [UILabel labelWithFrame:CGRectMake(0, _showTLab.bottom + 4*Proportion375, 80*Proportion375, 9*Proportion375) text:@"其他" textColor:kTextWith8b font:Font_Regular(9*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _otherTLab.right = kMainScreenWidth - 16*Proportion375;

    }
    return _otherTLab;
}
-(UILabel*)otherPriceLab
{
    if (!_otherPriceLab) {
        _otherPriceLab = [UILabel labelWithFrame:CGRectMake(0, self.otherTLab.top, self.width, 10*Proportion375) text:@"0CNY" textColor:kTextWith8b font:Font_engRegular(10*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _otherPriceLab.right = kMainScreenWidth - 60*Proportion375;

    }
    return _otherPriceLab;
}
-(UILabel*)allTLab
{
    if (!_allTLab) {
        _allTLab = [UILabel labelWithFrame:CGRectMake(0, _otherTLab.bottom + 4*Proportion375, 80*Proportion375, 9*Proportion375) text:@"总计" textColor:kTextWith8b font:Font_Regular(9*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _allTLab.right = kMainScreenWidth - 16*Proportion375;

    }
    return _allTLab;
}
-(UILabel*)allPriceLab
{
    if (!_allPriceLab) {
        _allPriceLab = [UILabel labelWithFrame:CGRectMake(0, _allTLab.top, self.width, 10*Proportion375) text:@"0CNY" textColor:kTextWith8b font:Font_engRegular(10*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _allPriceLab.right = kMainScreenWidth - 60*Proportion375;

    }
    return _allPriceLab;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
