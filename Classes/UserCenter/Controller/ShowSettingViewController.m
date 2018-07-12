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
