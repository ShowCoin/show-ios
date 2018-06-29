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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
