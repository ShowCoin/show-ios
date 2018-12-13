//
//  ShowAddAddressViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAddAddressViewController.h"
#import "ShowAddressTextCell.h"
#import "SLAddWithdrawAddressAction.h"
#import "ShowVerifycodeAction.h"

@interface ShowAddAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)UIButton * sureButton;
@property (nonatomic, copy)NSString * walletName;
@property (nonatomic, copy)NSString * walletAddress;

@property (nonatomic, copy)NSString * walletPassword;
@property (nonatomic, copy)NSString * googlePassword;
@property (nonatomic, copy)NSString * messagePassword;
@property (nonatomic, copy)NSString * emailPassword;
@property (nonatomic, assign)BOOL  walletVerify;
@property (nonatomic, strong)SLAddWithdrawAddressAction * addWithdrawAddressAction;
@property (nonatomic, strong)ShowVerifycodeAction * getVerifyAction;

@end

@implementation ShowAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationTitle:@"添加地址"];
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    [self configSubView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [IQKeyboardManager sharedManager].enable = NO;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [IQKeyboardManager sharedManager].enable = YES;

}
- (void)configSubView{
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
