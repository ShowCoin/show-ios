//
//  SLConversationInputMoreCardView.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLConversationInputMoreCardView.h"
#import "UIView+build.h"
#import "UIColor+HexString.h"
NS_ASSUME_NONNULL_BEGIN
@interface SLConversationInputMoreCardView()

@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) UIButton *diceButton;
@property (nonatomic, strong) UIButton *giftButton;

@end
NS_ASSUME_NONNULL_END
@implementation SLConversationInputMoreCardView
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadViews];
    }
    return self;
}

#pragma mark - Set Data & Views
- (void)loadViews
{
    self.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"D3D3D3"];
    
    [self addSubview:line];
//    [self addSubview:self.giftButton];
    [self addSubview:self.cameraButton];
//    [self addSubview:self.locationButton];
//    [self addSubview:self.diceButton];
    
    CGFloat topPadding = 20;
    CGFloat buttonWidth = 60;
    CGFloat hPadding = (kMainScreenWidth - buttonWidth*4)/5;
    
    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(topPadding);
        make.left.equalTo(self).offset(hPadding);
        make.size.mas_equalTo(CGSizeMake(buttonWidth, 90));
    }];
    
//    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(topPadding);
//        make.left.equalTo(self.giftButton.mas_right).offset(hPadding);
//        make.size.mas_equalTo(CGSizeMake(buttonWidth, 90));
//    }];
//
//    [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(topPadding);
//        make.left.equalTo(self.cameraButton.mas_right).offset(hPadding);
//        make.size.mas_equalTo(CGSizeMake(buttonWidth, 90));
//    }];
//
//    [self.diceButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(topPadding);
//        make.left.equalTo(self.locationButton.mas_right).offset(hPadding);
//        make.size.mas_equalTo(CGSizeMake(buttonWidth, 90));
//    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@0.5);
        make.left.right.top.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - Getter

- (UIButton *)giftButton
{
    if (!_giftButton) {
        _giftButton = [self buttonWithTitle:@"礼物" imageName:@"msg_gift_icon"];
        _giftButton.tag = 100;
    }
    return _giftButton;
}

- (UIButton *)cameraButton
{
    if (!_cameraButton) {
        _cameraButton = [self buttonWithTitle:@"拍摄" imageName:@"msg_camera_icon"];
        _cameraButton.tag = 101;
    }
    return _cameraButton;
}

- (UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton = [self buttonWithTitle:@"位置" imageName:@"msg_location_icon"];
        _locationButton.tag = 102;
        
    }
    return _locationButton;
}

- (UIButton *)diceButton
{
    if (!_diceButton) {
        _diceButton = [self buttonWithTitle:@"投骰子" imageName:@"msg_dice_icon"];
        _diceButton.tag = 103;
        
    }
    return _diceButton;
}

#pragma mark - Uitil
- (UIButton *)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:RGBCOLOR(140, 137, 155) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleEdgeInsets = UIEdgeInsetsMake(65, -58, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(-26, 0, 0, 0);
    return button;
}

#pragma mark - Actions
- (void)onButtonClick:(UIButton *)button
{
    if (self.didTapedBlock) {
        self.didTapedBlock(button.tag);
    }
    if ([self.delegate respondsToSelector:@selector(conversationInputMoreCardViewDidClickBtnWithType:)]) {
        [self.delegate conversationInputMoreCardViewDidClickBtnWithType:button.tag];
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
