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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLSafeCenterCell * Cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Cell = [[SLSafeCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!Cell) {
        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
            Cell.title.text = @"编辑资料";
            break;
        case 1:
            Cell.title.text = @"安全中心";
            break;
        case 2:{
            
            Cell.title.text = @"手机绑定";
            Cell.textLab.right = kMainScreenWidth - 32*Proportion375;
            if(IsValidString([AccountModel shared].phoneNumber)){
                Cell.textLab.text = @"已绑定";
                Cell.textLab.textColor =kThemeGreenColor;
            }else{
                Cell.textLab.text = @"未绑定";
                Cell.textLab.textColor =kThemeBlueColor;
            }
        }
            break;
        case 3:{
            
            Cell.title.text = @"身份认证";
            Cell.textLab.right = kMainScreenWidth - 32*Proportion375;
            switch (AccountUserInfoModel.authStatus.integerValue) {
                case 1:
                    Cell.textLab.text = @"未认证";
                    Cell.textLab.textColor =kThemeBlueColor;
                    break;
                case 2:
                    Cell.textLab.text = @"认证中";
                    Cell.textLab.textColor =kGrayWith808080;
                    break;
                case 3:
                    Cell.textLab.text = @"认证成功";
                    Cell.textLab.textColor =kThemeGreenColor;
                    break;
                case 4:
                    Cell.textLab.text = @"认证失败";
                    Cell.textLab.textColor =kThemeRedColor;
                    break;

                default:
                    break;
            }
        }
            break;
        case 4:
            Cell.title.text = @"去评分";
            break;
        case 5:
            Cell.title.text = @"帮助与反馈";
            break;
        case 6:
            Cell.title.text = @"多语言";
            break;
        case 7:
            Cell.title.text = @"货币单位";
            break;
        case 8:
            Cell.title.text = @"网络诊断";
            break;
        case 9:
            Cell.title.text = @"关于我们";
            break;
        default:
            break;
    }
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [PageMgr pushtoUserInfoVC];
            break;
        case 1:
         //   [HDHud showMessageInView:self.view title:@"敬请期待"];
           [PageMgr pushToSLSafeCenterViewController];

            break;
        case 2:{
            if(IsValidString([AccountModel shared].phoneNumber)){
                return ;
            }
            
            SLPhoneBindVC *bindPhoneVC = [[SLPhoneBindVC alloc]init];
            bindPhoneVC.refresh = ^{
                SLSafeCenterCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                cell.textLab.text = @"已绑定";
                cell.textLab.textColor =kThemeGreenColor;
            };
            [self.navigationController pushViewController:bindPhoneVC animated:YES];
        }
            break;
        case 3:{
            if(IsValidString([AccountModel shared].phoneNumber)){
                if (AccountUserInfoModel.authStatus.integerValue == 1 || AccountUserInfoModel.authStatus.integerValue == 4) {
                    if (AccountUserInfoModel.showCoinRmb.floatValue > 1.0) {
                        SLAuthIdentityViewController *authVC = [[SLAuthIdentityViewController alloc] init];
                        authVC.refresh = ^{
                            SLSafeCenterCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                            cell.textLab.text = @"认证中";
                            cell.textLab.textColor =kGrayWith808080;
                        };
                        [self.navigationController pushViewController:authVC animated:YES];
                    }else{
                        UIAlertView *CoinAlert = [[UIAlertView alloc] initWithTitle:@"余额不足" message:@"每次提交KYC认证，系统扣除约等于1.00元的SHOW币" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"充值", nil];
                        CoinAlert.tag = 2000;
                        [CoinAlert show];
                    }
                }
            }else{
                UIAlertView *BindPhoneAlert = [[UIAlertView alloc] initWithTitle:@"请先绑定手机" message:@"您还未绑定手机，无法进行身份认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去绑定", nil];
                BindPhoneAlert.tag = 1000;
                [BindPhoneAlert show];
            }
        }
            break;
           
        case 4:
            [self addAppReview];
            break;
        case 5:
            [HDHud showMessageInView:self.view title:@"敬请期待"];
            break;
        case 6:
            [HDHud showMessageInView:self.view title:@"敬请期待"];
            break;
        case 7:
            [HDHud showMessageInView:self.view title:@"敬请期待"];
            break;
        case 8:
            [HDHud showMessageInView:self.view title:@"敬请期待"];
//            [self.navigationController pushViewController:[SLNetDiagnoViewController initVC] animated:YES];
            break;
        case 9:
            [HDHud showMessageInView:self.view title:@"敬请期待"];//[self.navigationController pushViewController:[ShowForUsViewController initVC] animated:YES];
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAppReview{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"喜欢ShowLive么?给个五星好评吧亲!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //跳转APPStore 中应用的撰写评价页面
    UIAlertAction *review = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *appReviewUrl = [NSURL URLWithString:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",@"55583156"]];
        //换成你应用的 APPID
        /// 大于等于10.0系统使用此openURL方法
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:appReviewUrl options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:appReviewUrl];
        }
    }];
    //不做任何操作
    UIAlertAction *noReview = [UIAlertAction actionWithTitle:@"用用再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [alertVC removeFromParentViewController];
    }];
    [alertVC addAction:review];
    [alertVC addAction:noReview];
    //判断系统,是否添加五星好评的入口
    if (@available(iOS 10.3, *)) {
        if([SKStoreReviewController respondsToSelector:@selector(requestReview)])
        {
            UIAlertAction *fiveStar = [UIAlertAction actionWithTitle:@"五星好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                       {
                                           [[UIApplication sharedApplication].keyWindow endEditing:YES];
                                           [SKStoreReviewController requestReview];
                                           
                                       }];
            [alertVC addAction:fiveStar];
            
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertVC animated:YES completion:nil];
        
    });
    
}
    
    //新加  设置页超链接

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
