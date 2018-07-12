//
//  ShowSettingViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowSettingViewController.h"
#import "ShowForUsViewController.h"
#import "ShowLoginViewController.h"
#import "SLNetDiagnoViewController.h"
#import "SLLinkLabel.h"
#import "SLPhoneBindVC.h"
#import "SLAuthIdentityViewController.h"
#import "SLSafeCenterCell.h"
#import <StoreKit/StoreKit.h>


@interface ShowSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * LogoutBtn;


@end

@implementation ShowSettingViewController
{
    NSString *Phone;

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [SLReportManager reportPageBegin:kReport_SettingPage];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SLReportManager reportPageEnd:kReport_SettingPage];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationTitle:@"设置"];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor = kBlackThemeColor;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.LogoutBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotoWebView:)
                                                 name:@"webLinks"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTheKycStatue) name:SLKYCRefreshNotification object:nil];

}
-(UIButton*)LogoutBtn
{
    if (!_LogoutBtn) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = (CGRect){0,kMainScreenHeight-44*Proportion375-KTabbarSafeBottomMargin ,KScreenWidth,45*Proportion375+KTabbarSafeBottomMargin};
        [button setTitle:@"退出" forState:UIControlStateNormal];
        [button setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(-KTabbarSafeBottomMargin, 0, 0, 0)];
        button.backgroundColor = kBlackThemeColor;
        _LogoutBtn = button;
    }
    [[_LogoutBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [PageMgr logout:nil];
    }];
    return _LogoutBtn;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarSafeBottomMargin - 45*Proportion375- KNaviBarHeight - KTabbarSafeBottomMargin) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.backgroundColor =kBlackThemeBGColor;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kBlackThemeColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    return _tableView;
    
}

#pragma mark - delegates
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 550*WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 70*Proportion375)];
    view.backgroundColor = [UIColor clearColor];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    
    UILabel * label = [UILabel labelWithText:[NSString stringWithFormat:@"%@ version %@",app_Name,app_Version] textColor:kGrayWith999999 font:Font_Regular(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    label.frame = CGRectMake(0, 60*Proportion375,kMainScreenWidth , 10*Proportion375);
    [view addSubview:label];
    
    UILabel * desLab = [UILabel labelWithText:@"秀币团队信息\n扫微信二维码进秀粉群\n秀币小姐姐 SHOW00100" textColor:kGrayWith999999 font:Font_Regular(12*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    desLab.frame = CGRectMake(0, 80*Proportion375,kMainScreenWidth , 60*Proportion375);
    desLab.numberOfLines = 0;
    [view addSubview:desLab];
    
    UIImageView * codeImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80 * Proportion375, 80 * Proportion375)];
    codeImg.top = desLab.bottom + 10*Proportion375;
    codeImg.contentMode = UIViewContentModeScaleAspectFill;
    codeImg.centerX = kMainScreenWidth/2;
    codeImg.image = [UIImage imageNamed:@"userhome_setting_code"];
    [view addSubview:codeImg];


    NSString * allstr = @"有关团队信息\n官网：http://www.xiubi.com\n官方微信公众号：ShowCoin（http://t.cn/RQHRKOv）\n加入官方微信群，请加ShowCoin小助手，微信ID：ShowCoin-001\n官方微博：ShowCoin(http://t.cn/RnFDsDT)\nTwitter：https://twitter.com/Show_coin\nFacebook：https://www.facebook.com/ShowCoin-144390446177396\nGithub：https://github.com/ShowCoin/\nInstagram：https://www.instagram.com/showcoin/\nTelegram: https://t.me/ShowCoinChinese\nShowCoin Official https://t.me/ShowCoinEnglish\nShowCoin 公式交流グループ \nhttps://t.me/ShowCoinJapanese\nShowCoin 공식 커뮤니티 \nhttps://t.me/ShowCoinKorea";
    NSArray * strArr = [allstr componentsSeparatedByString:@"\n"];
    for (int i = 0; i < strArr.count; i++) {
        SLLinkLabel *_lab = [[SLLinkLabel alloc]initWithFrame:CGRectMake(0, codeImg.bottom + 10*Proportion375 + i*15*Proportion375,kMainScreenWidth , 12*Proportion375)];
        [_lab setTextColor:[UIColor blackColor]];
        _lab.font = Font_Regular(12*Proportion375);
        _lab.numberOfLines = 1;
        _lab.textAlignment = NSTextAlignmentCenter;
        [_lab urlAndIphoneValidation:[strArr objectAtIndex:i]];
        [view addSubview:_lab];
    }
    return view;
}
//- (void)gotoHyperlinksWebView:(NSNotification *)notification{
//
//}

//- (void)call {
//    //这里应该先判断是否具有打电话的功能，如ipad等不能拨打电话，此处省略。。
//    NSString *mobile = Phone;
//    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel://%@",mobile];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
