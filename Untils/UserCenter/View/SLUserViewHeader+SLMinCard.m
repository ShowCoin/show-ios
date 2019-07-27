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
            make.left.equalTo(self.scrollerContentView).with.offset(20*Proportion375);
            make.width.equalTo(@(kMainScreenWidth-40*Proportion375));
        }];
        

        [self.fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.wordsLab.mas_bottom).with.offset(20*Proportion375);
            make.centerX.equalTo(self.scrollerContentView);
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
    }
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

- (void)clearData{
    [self.masterLevel setLevel:@""];
    [self.showLevel setLevel:@""];
    
    [self.nickLab setText:@""];
    [self.sexImg setImage:nil];
    [self.sexlab setText:[NSString stringWithFormat:@"未知"]];
    
    
    [self.idLab setText:@""];
    
    UILabel * testLab1 = [UILabel labelWithText:@"秀号" textColor:kThemeWhiteColor font:Font_Trebuchet(13*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    UILabel * testLab2 = [UILabel labelWithText:@"" textColor:kThemeWhiteColor font:Font_Trebuchet(16*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    
    CGFloat indexWith = testLab1.width - testLab2.width;
    
//    [self.idPreLab mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.nickLab.mas_bottom).with.offset(7*Proportion375);
//        make.right.equalTo(self.mas_centerX).with.offset(indexWith/2);
//        make.height.equalTo(@(13*Proportion375));
//    }];
    
    [self.constellationLab setText:[NSString stringWithFormat:@"未知"]];    
    self.headImgView.image = nil ;
    self.headPortrait.imageView.image  = nil ;
    
 
}

+(CGFloat)minCardHeightWithDesc:(NSString *)desc{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 0; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //    设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *strdic = @{NSFontAttributeName:Font_Regular(14*Proportion375), NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                             };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:desc attributes:strdic];
    
    CGSize size = CGSizeMake(kMainScreenWidth-40, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attributeStr];
    return layout.textBoundingSize.height + 410*Proportion375 +KNaviBarSafeBottomMargin;
}
@end
