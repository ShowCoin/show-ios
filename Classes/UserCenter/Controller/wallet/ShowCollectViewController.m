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

- (void)configSubView{
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.headerImage];
    [self.backView addSubview:self.nameLabel];
    if (self.walletModel.address.length>10) {
        UILabel * show = [UILabel labelWithFrame:CGRectMake(55*Proportion375, _backView.bottom+20*Proportion375,  kMainScreenWidth-110*Proportion375, 18*Proportion375) text:self.walletModel.typeCName textColor:kTextWithF7 font:Font_Medium(23*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _address = [UILabel labelWithFrame:CGRectMake(55*Proportion375, show.bottom+10*Proportion375,  kMainScreenWidth-110*Proportion375, 50*Proportion375) text:self.walletModel.address textColor:kTextWith8b font:Font_Regular(12*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _address.numberOfLines =2;
        [self.view addSubview:show];
        [self.view addSubview:_address];
        UIView * line = [[ UIView alloc]initWithFrame:CGRectMake(55*Proportion375, _address.bottom +3*WScale , kMainScreenWidth-110*Proportion375, 0.5f)];
        line.backgroundColor = kBlackWith17;
        [self.view addSubview:line];
        [self.view addSubview:self.QRImage];
        [self.view addSubview:self.copyButton];
    }
    else
    {
        UILabel * show = [UILabel labelWithFrame:CGRectMake(55*Proportion375, _backView.bottom+20*Proportion375,  kMainScreenWidth-110*Proportion375, 18*Proportion375) text:self.walletModel.typeCName textColor:kTextWithF7 font:Font_Medium(23*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _address = [UILabel labelWithFrame:CGRectMake(55*Proportion375, show.bottom+10*Proportion375,  kMainScreenWidth-110*Proportion375, 50*Proportion375) text:@"系统繁忙,请重试" textColor:kTextWith8b font:Font_Regular(12*Proportion375)  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _address.numberOfLines =2;
        [self.view addSubview:show];
        [self.view addSubview:_address];
        UIView * line = [[ UIView alloc]initWithFrame:CGRectMake(55*Proportion375, _address.bottom +3*WScale , kMainScreenWidth-110*Proportion375, 0.5f)];
        line.backgroundColor = kBlackWith17;
        [self.view addSubview:line];
        [self.view addGestureRecognizer:self.singleTap];
    }
    
}
- (UITapGestureRecognizer *)singleTap{
    if(!_singleTap){
        _singleTap = [[UITapGestureRecognizer alloc]init];
        _singleTap.numberOfTapsRequired =1;
        @weakify(self)
        [[_singleTap rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self)
            if (self.getCoinInfoAction ) {
                [self.getCoinInfoAction cancel];
                self.getCoinInfoAction = nil;
            }
            [HDHud showHUDInView:self.view title:@""];
            
            self.getCoinInfoAction = [SLGetCoinInfo action];
            self.getCoinInfoAction.coin_type = self.walletModel.type;
            @weakify(self)
            self.getCoinInfoAction.finishedBlock = ^(NSDictionary * dic)
            {
                @strongify(self)
                [HDHud hideHUDInView:self.view];
                self.walletModel.address = dic[@"address"];
                [self reloadUI];
                //  初始化用户单例
            };
            self.getCoinInfoAction.failedBlock = ^(NSError *error) {
                @strongify(self)
                [HDHud hideHUDInView:self.view];
                [HDHud showMessageInView:self.view title:error.userInfo[@"msg"]];

            };
            [self.getCoinInfoAction start];

        }];
    }
    return _singleTap;
}
- (void)reloadUI
{
    if (self.walletModel.address.length>10) {
        _address.text = self.walletModel.address;
        [self.view addSubview:self.QRImage];
        [self.view addSubview:self.copyButton];
        [self.view removeGestureRecognizer:self.singleTap];
    }
}


@end
