//
//  SLWalletHomePageHeader.h
//  ShowLive
//
//  Created by vning on 2018/10/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBYLineGraphView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^SwitchBlock)(BOOL on);

@interface SLWalletHomePageHeader : UIView
@property (nonatomic, strong) UIImageView *BGTopimgView;
@property (nonatomic, strong) UIImageView *BGBottomimgView;
@property (nonatomic, strong) FBYLineGraphView *graphView;
@property (nonatomic, assign) CGFloat lineMaxValue;
@property (nonatomic, assign) CGFloat lineMinValue;

@property (nonatomic, strong)SLWalletModel * walletModel;
@property (nonatomic, strong) ShowUserModel *user;

@property (nonatomic, strong) SLHeadPortrait *headerImage;
@property (nonatomic, strong) UILabel *NameLab;
@property (nonatomic, strong) UILabel *showNumLab;
@property (nonatomic, strong) UILabel *showLab;

@property (nonatomic, strong) UILabel *showTLab;
@property (nonatomic, strong) UILabel *showPriceLab;
@property (nonatomic, strong) UILabel *otherTLab;
@property (nonatomic, strong) UILabel *otherPriceLab;
@property (nonatomic, strong) UILabel *allTLab;
@property (nonatomic, strong) UILabel *allPriceLab;

@property (nonatomic, strong) UILabel *showPriceTitleLab;
@property (nonatomic, strong) UILabel *showPriceChangeLab;
@property (nonatomic, strong) UILabel *showPriceDisplayLab;
@property (nonatomic, strong) UIImageView *showPriceDisplayImg;

@property (nonatomic, strong) UILabel *showDayLowPriceLabNum;
@property (nonatomic, strong) UILabel *showDayLowPriceLab;
@property (nonatomic, strong) UILabel *showDayHighPriceLabNum;
@property (nonatomic, strong) UILabel *showDayHighPriceLab;

@property (nonatomic, strong) UILabel *showDayDealLabNum;
@property (nonatomic, strong) UILabel *showDayDealLab;
@property (nonatomic, strong) UILabel *showValueLabNum;
@property (nonatomic, strong) UILabel *showValueLab;
@property (nonatomic, strong) UILabel *showMarketNum;

@property (nonatomic, strong) UIButton *dealButton;

@property (nonatomic, strong) UIButton *hideBtn;
@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, copy)SwitchBlock switchBlock;


-(void)refreshState;

@end

NS_ASSUME_NONNULL_END
