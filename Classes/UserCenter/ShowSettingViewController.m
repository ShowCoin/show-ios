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
#import<StoreKit/StoreKit.h>

@interface ShowSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * LogoutBtn;

@end

@implementation ShowSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationTitle:@"设置"];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor = kBlackThemeColor;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.LogoutBtn];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarSafeBottomMargin - 45*Proportion375) style:UITableViewStylePlain];
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
    return 70*WScale;
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
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54*WScale;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * Cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!Cell) {
        Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        Cell.textLabel.font = Font_Regular(15*Proportion375);
        Cell.textLabel.textColor = kBlackThemetextColor;
        Cell.backgroundColor = kBlackThemeBGColor;
    }
    switch (indexPath.row) {
        case 0:
            Cell.textLabel.text = @"编辑资料";
            break;
        case 1:
            Cell.textLabel.text = @"安全中心";
            break;
        case 2:
            Cell.textLabel.text = @"去评分";
            break;
        case 3:
            Cell.textLabel.text = @"帮助与反馈";
            break;
        case 4:
            Cell.textLabel.text = @"多语言";
            break;
        case 5:
            Cell.textLabel.text = @"货币单位";
            break;
        case 6:
            Cell.textLabel.text = @"网络诊断";
            break;
        case 7:
            Cell.textLabel.text = @"关于我们";
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
            [HDHud showMessageInView:self.view title:@"敬请期待"];//[PageMgr pushToSLSafeCenterViewController];
            break;
        case 2:
            [self addAppReview];
            break;
        case 3:
            [HDHud showMessageInView:self.view title:@"敬请期待"];
            break;
        case 4:
            [HDHud showMessageInView:self.view title:@"敬请期待"];
            break;
        case 5:
            [HDHud showMessageInView:self.view title:@"敬请期待"];
            break;
        case 6:
            [self.navigationController pushViewController:[SLNetDiagnoViewController initVC] animated:YES];
            break;
        case 7:
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
    
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
