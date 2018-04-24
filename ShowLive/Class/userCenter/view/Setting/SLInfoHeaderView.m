//
//  SLInfoHeaderView.m
//  ShowLive
//
//  Created by vning on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLInfoHeaderView.h"
@interface SLInfoHeaderView()
@property(nonatomic,strong)UIImageView * BgImgView;
@property(nonatomic,strong)UIView * whiteView;
@property(nonatomic,strong)UIButton * avaBtn;
@property(nonatomic,strong)UIImageView * cameraImg;
@end
@implementation SLInfoHeaderView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(UIImageView *)BgImgView
{
    if (!_BgImgView) {
        _BgImgView = [[UIImageView alloc] init];
        _BgImgView.contentMode = UIViewContentModeScaleAspectFill;
        _BgImgView.backgroundColor = kthemeBlackColor;
    }
    return _BgImgView;
}

-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = kThemeWhiteColor;
    }
    return _whiteView;
}

-(UIButton *)avaBtn
{
    if (!_avaBtn) {
        _avaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _avaBtn.backgroundColor = [UIColor redColor];
    }
    return _avaBtn;
}

-(UIImageView *)cameraImg
{
    if (!_cameraImg) {
        _cameraImg  = [[UIImageView alloc] init];
        _cameraImg.backgroundColor = [UIColor blueColor];
    }
    return _cameraImg;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
