//
//  ShowCollectViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowCollectViewController.h"
#import "SLGetCoinInfo.h"
#import "SLQRTool.h"
@interface ShowCollectViewController ()
@property (nonatomic, strong) SLHeadPortrait *headerImage;
@property (nonatomic, strong) UILabel *  nameLabel;
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) UIImageView *QRImage;
@property (nonatomic, strong) UIButton *copyButton;
@property (nonatomic, strong)  UILabel * address;
@property(nonatomic,strong)UITapGestureRecognizer *singleTap;
@property (nonatomic, strong)SLGetCoinInfo * getCoinInfoAction;

@end

@implementation ShowCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBlackWith1c;
    [self.navigationBarView setNavigationTitle:@"充值码"];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setRightTitle:@"分享" titleColor:WhiteColor font:Font_Regular(14)];

    [self.navigationBarView setNavigationColor:NavigationColor1717];

    [self configSubView];
}

- (void)clickRightButton:(UIButton *)sender{
    [HDHud showMessageInView:self.view title:@"敬请期待"];
}
- (UIView*)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth, 128*Proportion375)];
        _backView.backgroundColor = kBlackWith17;
    }
    return _backView;
}


- (UIButton *)copyButton
{
    if (!_copyButton) {
        _copyButton = [[UIButton alloc] init];
        _copyButton.frame = CGRectMake(55*Proportion375, _QRImage.bottom+15* Proportion375, kMainScreenWidth-110*Proportion375, 45*Proportion375);
        [_copyButton setBackgroundImage:[UIImage imageNamed:@"wallet_home_save"] forState:UIControlStateNormal];
        [_copyButton setBackgroundImage:[UIImage imageNamed:@"wallet_home_save"] forState:UIControlStateHighlighted];
        [_copyButton setTitle:@"复制收款地址" forState:UIControlStateNormal];
        [_copyButton setTitleColor:kBlackWith27 forState:UIControlStateNormal];
        _copyButton.titleLabel.font = Font_Regular(19*Proportion375);
        _copyButton.backgroundColor = [UIColor redColor];
//        _copyButton.backgroundColor = kGrayBGColor;
//        [_copyButton cornerRadiusStyle];
    }
    @weakify(self);
    [[_copyButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [UIPasteboard generalPasteboard].string = self.walletModel.address;
        [HDHud showMessageInView:self.view title:@"已复制到剪切板"];
    }];
    return _copyButton;
}

@end
