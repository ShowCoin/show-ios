//
//  SLSafeCenterViewController.m
//  ShowLive
//
//  Created by vning on 2018/5/8.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLSafeCenterViewController.h"
#import "SLSafeCenterCell.h"
@interface SLSafeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UISwitch * GestureSwitch;
@property(nonatomic,strong)UISwitch * handSwitch;
@property(nonatomic,strong)UISwitch * reSureSwitch;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation SLSafeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationTitle:@"安全中心"];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor = kBlackThemeColor;
    [self Views];
}
-(void)Views{
    [self.view addSubview:self.tableView];
}
@end
