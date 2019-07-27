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


-(UILabel*)showPriceTitleLab
{
    if (!_showPriceTitleLab) {
        _showPriceTitleLab = [UILabel labelWithFrame:CGRectMake(16*Proportion375,10*Proportion375, 120*Proportion375, 18*Proportion375) text:@"SHOW价格" textColor:kTextWhitef7f7f7 font:Font_Regular(18*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
//        [_showPriceTitleLab sizeToFit];
        _showPriceTitleLab.centerY = _showPriceChangeLab.centerY;
    }
    return _showPriceTitleLab;
}
-(UILabel*)showPriceChangeLab
{
    if (!_showPriceChangeLab) {
        _showPriceChangeLab = [UILabel labelWithFrame:CGRectMake(120*Proportion375, 14*Proportion375, 84*Proportion375, 28*Proportion375) text:@"+0.00%" textColor:kTextWhitef7f7f7 font:Font_engMedium(18*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _showPriceChangeLab.clipsToBounds = YES;
        _showPriceChangeLab.layer.cornerRadius = 2*Proportion375;
    }
    return _showPriceChangeLab;
}
-(UILabel*)showPriceDisplayLab
{
    if (!_showPriceDisplayLab) {
        _showPriceDisplayLab = [UILabel labelWithFrame:CGRectMake(8*Proportion375, _showPriceTitleLab.bottom + 25*Proportion375, 200*Proportion375, 49*Proportion375) text:@"￥0.00" textColor:kGoldWithLight font:Font_engRegular(49*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _showPriceDisplayLab.centerY = _showPriceChangeLab.bottom + 41*Proportion375;
    }
    return _showPriceDisplayLab;
}
-(UIImageView*)showPriceDisplayImg
{
    if (!_showPriceDisplayImg) {
        _showPriceDisplayImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25*Proportion375, 35*Proportion375)];
        _showPriceDisplayImg.centerY = _showPriceDisplayLab.centerY;
//        _showPriceDisplayImg.right = kMainScreenWidth - 16*Proportion375;
        
    }
    return _showPriceDisplayImg;
}
-(UILabel*)showDayLowPriceLabNum
{
    if (!_showDayLowPriceLabNum) {
        _showDayLowPriceLabNum = [UILabel labelWithFrame:CGRectMake(_showPriceTitleLab.left - 3*Proportion375, _showPriceChangeLab.bottom + 81*Proportion375, 100*Proportion375, 14*Proportion375) text:@"￥0.01" textColor:kTextWhitef7f7f7 font:Font_engRegular(14*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    }
    return _showDayLowPriceLabNum;
}
-(UILabel*)showDayLowPriceLab
{
    if (!_showDayLowPriceLab) {
        _showDayLowPriceLab = [UILabel labelWithFrame:CGRectMake(_showPriceTitleLab.left, _showDayLowPriceLabNum.bottom + 4*Proportion375, 100*Proportion375, 12*Proportion375) text:@"24h最低" textColor:kTextWith8b font:Font_Regular(12*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];

    }
    return _showDayLowPriceLab;
}
-(UILabel*)showDayHighPriceLabNum
{
    if (!_showDayHighPriceLabNum) {
        _showDayHighPriceLabNum = [UILabel labelWithFrame:CGRectMake(_showPriceTitleLab.left - 3*Proportion375, _showDayLowPriceLab.bottom + 12*Proportion375, 100*Proportion375, 14*Proportion375) text:@"￥0.01" textColor:kTextWhitef7f7f7 font:Font_engRegular(14*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _showDayHighPriceLabNum;
}
-(UILabel*)showDayHighPriceLab
{
    if (!_showDayHighPriceLab) {
        _showDayHighPriceLab = [UILabel labelWithFrame:CGRectMake(_showPriceTitleLab.left, _showDayHighPriceLabNum.bottom + 4*Proportion375, 100*Proportion375, 12*Proportion375) text:@"24h最高" textColor:kTextWith8b font:Font_Regular(12*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];

    }
    return _showDayHighPriceLab;
}
-(UILabel*)showDayDealLabNum
{
    if (!_showDayDealLabNum) {
        _showDayDealLabNum = [UILabel labelWithFrame:CGRectMake(_showPriceTitleLab.left, _showDayLowPriceLabNum.top, 100*Proportion375, 14*Proportion375) text:@"￥万" textColor:kTextWhitef7f7f7 font:Font_engRegular(14*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _showDayDealLabNum.right = kMainScreenWidth - 16*Proportion375;
    }
    return _showDayDealLabNum;
}
-(UILabel*)showDayDealLab
{
    if (!_showDayDealLab) {
        _showDayDealLab = [UILabel labelWithFrame:CGRectMake(_showPriceTitleLab.left, _showDayLowPriceLabNum.bottom + 4*Proportion375, 100*Proportion375, 12*Proportion375) text:@"24h成交额" textColor:kTextWith8b font:Font_Regular(12*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _showDayDealLab.right = kMainScreenWidth - 16*Proportion375;

    }
    return _showDayDealLab;
}
-(UILabel*)showValueLabNum
{
    if (!_showValueLabNum) {
        _showValueLabNum = [UILabel labelWithFrame:CGRectMake(_showPriceTitleLab.left, _showDayLowPriceLab.bottom + 12*Proportion375, 100*Proportion375, 14*Proportion375) text:@"￥万" textColor:kTextWhitef7f7f7 font:Font_engRegular(14*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _showValueLabNum.right = kMainScreenWidth - 16*Proportion375;

    }
    return _showValueLabNum;
}
-(UILabel*)showValueLab
{
    if (!_showValueLab) {
        _showValueLab = [UILabel labelWithFrame:CGRectMake(_showPriceTitleLab.left, _showDayHighPriceLabNum.bottom + 4*Proportion375, 100*Proportion375, 12*Proportion375) text:@"市值" textColor:kTextWith8b font:Font_Regular(12*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _showValueLab.right = kMainScreenWidth - 16*Proportion375;

    }
    return _showValueLab;
}
-(UILabel*)showMarketNum
{
    if (!_showMarketNum) {
        _showMarketNum = [UILabel labelWithFrame:CGRectMake(_showPriceTitleLab.left, _showValueLab.bottom + 6*Proportion375, 100*Proportion375, 9*Proportion375) text:@"x个交易所" textColor:kTextWith5b font:Font_Regular(9*WScale)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _showMarketNum.right = kMainScreenWidth - 16*Proportion375;
    }
    return _showMarketNum;
}
-(UIButton *)dealButton
{
    if (!_dealButton) {
        _dealButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _BGBottomimgView.bottom + 6*Proportion375, kMainScreenWidth, 60*Proportion375)];
//        _dealButton.backgroundColor = kThemeRedColor;
        [_dealButton setTitle:@"点对点交易" forState:UIControlStateNormal];
        [_dealButton.titleLabel setFont:Font_Regular(19*Proportion375)];
        [_dealButton setTitleColor:kBlackWith27 forState:UIControlStateNormal];
        [_dealButton setBackgroundImage:[UIImage imageNamed:@"wallet_home_deal"] forState:UIControlStateNormal];
        [_dealButton setBackgroundImage:[UIImage imageNamed:@"wallet_home_deal"] forState:UIControlStateHighlighted];
        [[_dealButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
           //点对点交易入口
            [PageMgr pushToPTTradeViewVC];
        }];
    }
    return _dealButton;
}
-(UIButton *)hideBtn
{
    if (!_hideBtn) {
        _hideBtn = [[UIButton alloc] initWithFrame:CGRectMake(16*Proportion375, _BGBottomimgView.bottom + 6*Proportion375, 90*Proportion375, 34*Proportion375)];
        _hideBtn.centerY = _addBtn.centerY;
        [_hideBtn setImage:[UIImage imageNamed:@"wallet_home_hideType_nomal"] forState:UIControlStateNormal];
        [_hideBtn setImage:[UIImage imageNamed:@"wallet_home_hideType_selected"] forState:UIControlStateSelected];
        [_hideBtn setTitle:@"隐藏小余额" forState:UIControlStateNormal];
        [_hideBtn.titleLabel setFont:Font_Regular(12*Proportion375)];
        [_hideBtn setTitleColor:kTextWith8b forState:UIControlStateNormal];
        [_hideBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -6*Proportion375, 0.0, 0.0)];
        [_hideBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, -6*Proportion375)];
        @weakify(self)
        [[_hideBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            self.hideBtn.selected = !self.hideBtn.selected;
            self.switchBlock(self.hideBtn.selected);

        }];
    }
    return _hideBtn;
}
-(UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _dealButton.bottom + 32*Proportion375, 70*Proportion375, 34*Proportion375)];
        _addBtn.right = kMainScreenWidth - 16*Proportion375;
//        _addBtn.backgroundColor = kThemeRedColor;
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"wallet_home_addType"] forState:UIControlStateNormal];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"wallet_home_addType"] forState:UIControlStateHighlighted];
        _addBtn.hidden = YES;
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        }];
    }
    return _addBtn;
}


- (void)setUser:(ShowUserModel *)user
{
    if ([user.uid isEqualToString:AccountUserInfoModel.uid]) {
        [self addSubview:self.dealButton];
        [self addSubview:self.addBtn];
        [self addSubview:self.hideBtn];
    }
    _user = user;
    [_headerImage setRoundStyle:YES imageUrl:_user?_user.avatar:AccountUserInfoModel.avatar imageHeight:45 vip:NO attestation:NO];
    _NameLab.text =_user?_user.nickname:AccountUserInfoModel.nickname;
}
- (void)setWalletModel:(SLWalletModel *)walletModel
{
    if (!walletModel) {
        return;
    }
    _walletModel = walletModel;
    SLWalletCoinModel *showModel = walletModel.coinList[0];
    _showNumLab.text = showModel.balance;
    _showPriceLab.text =  [NSString stringWithFormat:@"%@CNY",showModel.balance_rmb];
    _otherPriceLab.text = [NSString stringWithFormat:@"%.2fCNY",walletModel.rmb_num.floatValue - showModel.balance_rmb.floatValue];
    _allPriceLab.text = [NSString stringWithFormat:@"%@CNY",walletModel.rmb_num];
    if (walletModel.chg.floatValue < 0) {
        _showPriceChangeLab.backgroundColor = kThemeKRedColor;
        [_showPriceDisplayImg setImage:[UIImage imageNamed:@"wallet_home_line_down"]];
        _showPriceChangeLab.text = [NSString stringWithFormat:@"%@%@",walletModel.chg,@"%"];
    }else{
        _showPriceChangeLab.backgroundColor = kThemeKGreenColor;
        [_showPriceDisplayImg setImage:[UIImage imageNamed:@"wallet_home_line_up"]];
        _showPriceChangeLab.text = [NSString stringWithFormat:@"+%@%@",walletModel.chg,@"%"];
    }
    _showPriceDisplayLab.text  = [NSString stringWithFormat:@"￥%@",walletModel.last];
    [_showPriceDisplayLab sizeToFit];
    _showPriceDisplayLab.centerY = _showPriceChangeLab.bottom + 41*Proportion375;
    _showPriceDisplayLab.left = 8*Proportion375;
    
    _showPriceDisplayImg.left = _showPriceDisplayLab.right + 17*Proportion375;
    _showPriceDisplayImg.centerY = _showPriceDisplayLab.centerY;

    _showDayLowPriceLabNum.text = [NSString stringWithFormat:@"￥%@",walletModel.low];
    _showDayHighPriceLabNum.text = [NSString stringWithFormat:@"￥%@",walletModel.high];
    
    _showDayDealLabNum.text = [NSString stringWithFormat:@"￥%@万",walletModel.volcny];
    _showValueLabNum.text = [NSString stringWithFormat:@"￥%@万",walletModel.val];
    _showMarketNum.text = [NSString stringWithFormat:@"%@个交易所",walletModel.count];
    [self makeData];
    
}

-(void)makeData
{
    
    NSArray * coinList = [NSArray arrayWithArray:_walletModel.list];
    if (coinList.count == 0) {
        return;
    }
    self.lineMinValue = [[coinList objectAtIndex:0] floatValue];
    self.lineMaxValue = [[coinList objectAtIndex:0] floatValue];

    for (int i = 0; i<coinList.count; i++) {
        CGFloat valueY = [[coinList objectAtIndex:i] floatValue];
        if (valueY > self.lineMaxValue) {
            self.lineMaxValue = valueY;
        }
        if (valueY <self.lineMinValue) {
            self.lineMinValue = valueY;
        }
    }
    CGFloat cha = self.lineMaxValue - self.lineMinValue;
    NSMutableArray * dataArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<coinList.count; i++) {
        NSMutableDictionary * lineDataDic = [[NSMutableDictionary alloc] init];
        [lineDataDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"item"];
        CGFloat j =[[coinList objectAtIndex:i] floatValue];
        [lineDataDic setObject:[NSString stringWithFormat:@"%f",(j - self.lineMinValue + cha/4)] forKey:@"count"];
        [dataArr addObject:lineDataDic];
    }
    _graphView.maxValue = self.lineMaxValue - self.lineMinValue +cha/2;   // 最大值
    _graphView.yMarkTitles = @[@"0",[NSString stringWithFormat:@"%f",self.lineMaxValue - self.lineMinValue + cha/2]]; // Y轴刻度标签
    [_graphView setXMarkTitlesAndValues:dataArr titleKey:@"item" valueKey:@"count"];
    [_graphView mapping];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
