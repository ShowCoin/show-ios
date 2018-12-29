//
//  HomeHeader.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "HomeHeader.h"

static BOOL isHot = NO;

@interface HomeHeader ()

@property (nonatomic, strong) UIImageView * grayBg;
@property (nonatomic, strong) UIButton * navBtnA;
@property (nonatomic, strong) UIButton * navBtnB;
@property (nonatomic, strong) UIButton * navBtnC;
@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UIView   * lineView;

@end

@implementation HomeHeader

+ (instancetype)authViewWithFrame:(CGRect)frame
{
    HomeHeader * view = [[HomeHeader alloc]initWithFrame:frame];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupViews{
    [self addSubview:self.grayBg];
    [self addSubview:self.navBtnB];
    [self addSubview:self.navBtnA];
    [self addSubview:self.navBtnC];
    [self addSubview:self.leftBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.rightBtn];
    isHot = YES ;
    
    if (@available(iOS 11.0, *)) {
        NSInteger  count =  [[ShowCIoundIMService sharedManager] getTotalUnreadCount];
        self.rightBtn.hasMessage = (count>0)?YES:NO;
    }
    if (@available(iOS 11.0, *)) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateTotalUnreadCount:) name:kUpdateTotalUnreadCountNotification object:nil];
        
    }
}

- (void)updateTotalUnreadCount:(NSNotification *)notification
{
    NSString * count=notification.object;
    self.rightBtn.hasMessage = (count.integerValue>0)?YES:NO;
}

- (SLMessageButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [SLMessageButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(kMainScreenWidth - 50, 17+KTopHeight, 50, 50);
        [_rightBtn setImage:[UIImage imageNamed:@"live_bottom_more"] forState:UIControlStateNormal];
        @weakify(self);
        [[_rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"%s", __func__);
            if ([self.delegate respondsToSelector:@selector(rightBtnClick:)]) {
                [self.delegate rightBtnClick:self.rightBtn];
            }
        }];
    }
    return _rightBtn;
}

- (UIImageView *)grayBg
{
    if (!_grayBg) {
        _grayBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, KNaviBarHeight)];
        [_grayBg setImage:[UIImage imageNamed:@"home_header_bg"]];
    }
    return _grayBg;
}

- (UIButton *)navBtnA
{
    if (!_navBtnA) {
        _navBtnA=[UIButton buttonWithType:UIButtonTypeCustom];
        _navBtnA.frame=CGRectMake(self.navBtnB.left - 85*Proportion375, KTopHeight + 20, 85*Proportion375, 43);
        [_navBtnA setTitle:STRING_HOME_TITLECONCER_74 forState:UIControlStateNormal];
        [_navBtnA setTitleColor:kThemeAlphWhiteColor forState:UIControlStateNormal];
        [_navBtnA.titleLabel setFont:Font_Medium(18*Proportion375)];
         @weakify(self);
        [[_navBtnA rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.delegate && [self.delegate respondsToSelector:@selector(navTabAaction:)]) {
                [self.delegate navTabAaction:self.navBtnA];
            }
            [self rightButtonHidden:YES];
        }];
    }
    return _navBtnA;
}

- (UIButton *)navBtnB
{
    if (!_navBtnB) {
        _navBtnB=[UIButton buttonWithType:UIButtonTypeCustom];
        _navBtnB.frame=CGRectMake(85*Proportion375, KTopHeight + 20, 85*Proportion375, 43);
        _navBtnB.centerX = kMainScreenWidth/2;
        [_navBtnB setTitle:STRING_HOME_TITLEHOT_75 forState:UIControlStateNormal];
        [_navBtnB setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_navBtnB.titleLabel setFont:Font_Medium(20*Proportion375)];
         @weakify(self);
        [[_navBtnB rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.delegate && [self.delegate respondsToSelector:@selector(navTabBaction:)]) {
                [self.delegate navTabBaction:self.navBtnB];
            }
            [self rightButtonHidden:NO];
        }];
    }
    return _navBtnB;
}

- (UIButton *)navBtnC
{
    if (!_navBtnC) {
        _navBtnC=[UIButton buttonWithType:UIButtonTypeCustom];
        _navBtnC.frame=CGRectMake(self.navBtnB.right, KTopHeight + 20, 85*Proportion375, 43);
        [_navBtnC setTitle:STRING_HOME_TITLENEW_76 forState:UIControlStateNormal];
        [_navBtnC setTitleColor:kThemeAlphWhiteColor forState:UIControlStateNormal];
        [_navBtnC.titleLabel setFont:Font_Medium(18*Proportion375)];
        @weakify(self);
        [[_navBtnC rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.delegate && [self.delegate respondsToSelector:@selector(navTabBaction:)]) {
                [self.delegate navTabCaction:self.navBtnC];
            }
            [self rightButtonHidden:YES];
        }];

    }
    return _navBtnC;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(6, 17+KTopHeight, 50, 50);
        [ _leftBtn setImage:[UIImage imageNamed:@"home_left_img"] forState:UIControlStateNormal];
        
        _leftBtn.alpha = .5f;
        _leftBtn.hidden = YES ;
        @weakify(self);
        [[_leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [HDHud showMessageInView:self.viewController.view title:@"敬请期待"];
        }];
    }
    return _leftBtn;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight-2*Proportion375, 35*Proportion375, 2*Proportion375)];
        _lineView.backgroundColor = kThemeWhiteColor;
        _lineView.layer.cornerRadius = 1*Proportion375;
        _lineView.centerX = _navBtnB.centerX;
    }
    return _lineView;
}



@end
