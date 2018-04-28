//
//  HomeHeader.m
//  ShowLive
//
//  Created by VNing on 2018/4/9.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "HomeHeader.h"
@interface HomeHeader ()
@property (nonatomic, strong) UIButton * navBtnA;
@property (nonatomic, strong) UIButton * navBtnB;
@property (nonatomic, strong) UIButton * navBtnC;
@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, strong) UIView * lineView;

@end

@implementation HomeHeader

+ (instancetype)authViewWithFrame:(CGRect)frame
{
    HomeHeader * view = [[HomeHeader alloc]initWithFrame:frame];
    return view;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        self.backgroundColor =HexRGBAlpha(0x000000, 0.1);
    }
    return self;
}
- (void)setupViews{
    [self addSubview:self.navBtnB];
    [self addSubview:self.navBtnA];
    [self addSubview:self.navBtnC];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.lineView];
}
-(UIButton *)navBtnA
{
    if (!_navBtnA) {
        _navBtnA=[UIButton buttonWithType:UIButtonTypeCustom];
        _navBtnA.frame=CGRectMake(self.navBtnB.left - 85*Proportion375, KTopHeight + 20, 85*Proportion375, 43);
        [_navBtnA setTitle:STRING_HOME_TITLECONCER_74 forState:UIControlStateNormal];
        [_navBtnA setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [[_navBtnA rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (_delegate && [_delegate respondsToSelector:@selector(navTabAaction:)]) {
                [_delegate navTabAaction:self.navBtnA];
            }
        }];

    }
    return _navBtnA;
}

-(UIButton *)navBtnB
{
    if (!_navBtnB) {
        _navBtnB=[UIButton buttonWithType:UIButtonTypeCustom];
        _navBtnB.frame=CGRectMake(85*Proportion375, KTopHeight + 20, 85*Proportion375, 43);
        _navBtnB.centerX = kMainScreenWidth/2;
        [_navBtnB setTitle:STRING_HOME_TITLEHOT_75 forState:UIControlStateNormal];
        [_navBtnB setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [[_navBtnB rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (_delegate && [_delegate respondsToSelector:@selector(navTabBaction:)]) {
                [_delegate navTabBaction:self.navBtnB];
            }

        }];

    }
    return _navBtnB;
}

-(UIButton *)navBtnC
{
    if (!_navBtnC) {
        _navBtnC=[UIButton buttonWithType:UIButtonTypeCustom];
        _navBtnC.frame=CGRectMake(self.navBtnB.right, KTopHeight + 20, 85*Proportion375, 43);
        [_navBtnC setTitle:STRING_HOME_TITLENEW_76 forState:UIControlStateNormal];
        [_navBtnC setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [[_navBtnC rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (_delegate && [_delegate respondsToSelector:@selector(navTabCaction:)]) {
                [_delegate navTabCaction:self.navBtnC];
            }
        }];

    }
    return _navBtnC;
}

-(UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(6, 20+KTopHeight, 44, 44);
        [ _leftBtn setImage:[UIImage imageNamed:@"home_left_img"] forState:UIControlStateNormal];
        [[_leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (_delegate && [_delegate respondsToSelector:@selector(leftBtnClick:)]) {
                [_delegate leftBtnClick:self.leftBtn];
            }
        }];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(kMainScreenWidth - 50, 20+KTopHeight, 44, 44);
        [ _rightBtn setImage:[UIImage imageNamed:@"home_right_img"] forState:UIControlStateNormal];
        [[_rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (_delegate && [_delegate respondsToSelector:@selector(rightBtnClick:)]) {
                [_delegate rightBtnClick:self.rightBtn];
            }
        }];
    }
    return _rightBtn;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight-2, 20, 2)];
        _lineView.backgroundColor = kThemeWhiteColor;
        _lineView.centerX = _navBtnB.centerX;
    }
    return _lineView;
}

-(void)changePageIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            self.lineView.centerX = self.navBtnA.centerX;
            break;
        case 1:
            self.lineView.centerX = self.navBtnB.centerX;
            break;
        case 2:
            self.lineView.centerX = self.navBtnC.centerX;
            break;
            
        default:
            break;
    }
}
@end
