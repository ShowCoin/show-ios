//
//  SLBlankView.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLBlankView.h"
@interface SLBlankView()
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *tipsLabel;
@property (strong, nonatomic) UIButton *loginButton;
@end
@implementation SLBlankView
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self addSubview:self.icon];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.loginButton];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(131, 131));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.icon.mas_bottom).offset(0);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(80);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.height.mas_equalTo(42);
    }];
    self.loginButton.hidden = YES;
}

- (void)setType:(SLMessageBlankViewType)type
{
    CGFloat iconCenterYOffsetToSuperView = -38;
    switch (type) {
        case SLMessageBlankViewTypeMessageListTouristMode:{
            self.icon.image = [UIImage imageNamed:@"message_blank_tourist_icon"];
            self.loginButton.hidden = NO;
            self.tipsLabel.text = @"这位英雄，请亮明你的真身…";
            
            CGFloat loginButtonHeight = 42;
            CGFloat loginButtonToTipsLabelSpacing = 80;
            iconCenterYOffsetToSuperView = -38-loginButtonHeight-loginButtonToTipsLabelSpacing;
            break;
        }
        case SLMessageBlankViewTypeMessageListSearchNotFound:{
            self.icon.image = [UIImage imageNamed:@"message_blank_search_no_result_icon"];
            self.loginButton.hidden = YES;
            self.tipsLabel.text = @"没有这个人，是真的没有...";
            
            break;
        }
        case SLMessageBlankViewTypeMessageListSearchNoData:{
            self.icon.image = [UIImage imageNamed:@"message_blank_search_list_empty"];
            self.loginButton.hidden = YES;
            self.tipsLabel.text = @"主动那么一点点，就会多个朋友...";
            
            break;
        }
        case SLMessageBlankViewTypeMyWork:{
            self.icon.image = [UIImage imageNamed:@"SLDrafts_blank_icon"];
            self.loginButton.hidden = YES;
            self.tipsLabel.text = @"懒到没发作品啊...";
            
            break;
        }
        case SLMessageBlankViewTypeMineLikeWork:{
            self.icon.image = [UIImage imageNamed:@"message_blank_search_list_empty"];
            self.loginButton.hidden = YES;
            self.tipsLabel.text = @"没有喜欢的作品";
            iconCenterYOffsetToSuperView = -10;
            break;
        }
            
        default:
            break;
    }
    
    [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(iconCenterYOffsetToSuperView);
    }];
}

#pragma mark - Getter
- (UIImageView *)icon
{
    if (!_icon) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _icon = imageView;
    }
    return _icon;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        UILabel *label = [UILabel labelWithFont:[UIFont systemFontOfSize:14] textColor:RGBCOLOR(140, 137, 155) alignment:NSTextAlignmentCenter];
        _tipsLabel = label;
    }
    return _tipsLabel;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"登录 / 注册" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 6;
        [button addTarget:self action:@selector(didTappedLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:HexRGBAlpha(0x47bafe, 1)];
        _loginButton = button;
    }
    return _loginButton;
}

#pragma mark - Action
- (void)didTappedLoginBtn:(id)sender
{
    if (self.didTappedLoginBtnAction) {
        self.didTappedLoginBtnAction();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
