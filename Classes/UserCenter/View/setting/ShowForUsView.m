//
//  ShowForUsView.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowForUsView.h"
@interface ShowForUsView()
@property (nonatomic, strong) UILabel *  versionLabel;
@property (nonatomic, strong) UILabel *  introduceLabel;
@property (nonatomic, strong) UIImageView *  showImage;

@end
@implementation ShowForUsView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBlackThemeBGColor;
        [self addSubview:self.showImage];
        [self addSubview:self.versionLabel];
        [self addSubview:self.introduceLabel];
    }
    return self;
}


-(UILabel*)versionLabel
{
    if (!_versionLabel) {
        if (@available(iOS 8.2, *)) {
            _versionLabel = [UILabel labelWithFrame:CGRectMake(0, _showImage.bottom+3*Proportion375, self.width, 13*Proportion375) text:[NSString stringWithFormat:@"当前版本:%@",[SLUtils appVersion]] textColor:kGrayWith999999 font:[UIFont systemFontOfSize:13*Proportion375 weight:UIFontWeightThin]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        } else {
            // Fallback on earlier versions
        }
    }
    return _versionLabel;
}
-(UILabel*)introduceLabel
{
    if (!_introduceLabel) {
        if (@available(iOS 8.2, *)) {
            _introduceLabel = [UILabel labelWithFrame:CGRectMake(30*Proportion375, _versionLabel.bottom+10*Proportion375, self.width-60*Proportion375, 80*Proportion375) text:@"秀币(ShowCoin)是世界首个基于区块链和智能合约的点对点网络技术基础，针对直播类数字娱乐内容分发服务和产品而设计的数字加密虚拟货币。" textColor:kGrayWith999999 font:[UIFont systemFontOfSize:14*Proportion375 weight:UIFontWeightThin]   backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        } else {
            // Fallback on earlier versions
        }if (@available(iOS 8.2, *)) {
            _introduceLabel = [UILabel labelWithFrame:CGRectMake(30*Proportion375, _versionLabel.bottom+10*Proportion375, self.width-60*Proportion375, 80*Proportion375) text:@"秀币(ShowCoin)是世界首个基于区块链和智能合约的点对点网络技术基础，针对直播类数字娱乐内容分发服务和产品而设计的数字加密虚拟货币。" textColor:kGrayWith999999 font:[UIFont systemFontOfSize:14*Proportion375 weight:UIFontWeightThin]   backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];

        } else {
            // Fallback on earlier versions
        }
        _introduceLabel.numberOfLines=3;
        
    }
    return _introduceLabel;
}

- (UIImageView*)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-70*Proportion375/2, 25*Proportion375, 70*Proportion375, 70*Proportion375)];
        
        _showImage.image = [UIImage imageNamed:@"usLogo"];
        [_showImage roundStyle];
        _showImage.backgroundColor = [UIColor clearColor];
    }
    return _showImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
