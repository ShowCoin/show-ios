//
//  ShowForUsView.m
//  ShowLive
//
//  Created by Mac on 2018/4/6.
//  Copyright © 2018年 VNing. All rights reserved.
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
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.showImage];
        [self addSubview:self.versionLabel];
        [self addSubview:self.introduceLabel];
    }
    return self;
}


-(UILabel*)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [UILabel labelWithFrame:CGRectMake(0, _showImage.bottom+5*Proportion375, self.width, 36*Proportion375) text:[NSString stringWithFormat:@"当前版本:%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] textColor:kTextGrayColor font:[UIFont systemFontOfSize:13*Proportion375 weight:UIFontWeightThin]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    }
    return _versionLabel;
}
-(UILabel*)introduceLabel
{
    if (!_introduceLabel) {
        _introduceLabel = [UILabel labelWithFrame:CGRectMake(30*Proportion375, _versionLabel.bottom+10*Proportion375, self.width-60*Proportion375, 80*Proportion375) text:@"秀币(ShowCoin)是世界首个基于区块链和智能合约的点对点网络技术基础，针对直播类数字娱乐内容分发服务和产品而设计的数字加密虚拟货币。" textColor:kTextGrayColor font:[UIFont systemFontOfSize:14*Proportion375 weight:UIFontWeightThin]   backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _introduceLabel.numberOfLines=3;
        
    }
    return _introduceLabel;
}

- (UIImageView*)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]initWithFrame:CGRectMake(kMainScreenWidth/2-50*Proportion375/2, 25*Proportion375, 50*Proportion375, 50*Proportion375)];
        _showImage.image = [UIImage imageNamed:@"account_show"];
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
