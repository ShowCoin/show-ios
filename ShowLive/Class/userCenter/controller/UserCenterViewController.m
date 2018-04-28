//
//  UserCenterViewController.m
//  ShowLive
//
//  Created by VNing on 2018/3/29.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "UserCenterViewController.h"
//#import "ShowAccountViewController.h"
//#import "WithdrawViewController.h"
//#import "ShowWalletViewController.h"
//#import "WithdrawAddressViewController.h"
//#import <ethers/Account.h>
//#import "WalletBuildingController.h"
#import "UserTableViewTypeOneCell.h"
#import "UserTableViewTypeTwoCell.h"
#import "UserTableViewTypeThreeCell.h"
#import "ShowSettingViewController.h"
#import "UserInfoViewController.h"
@interface UserCenterViewController ()
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftNone];
    [self.navigationBarView setNavigationTitle:STRING_TABBAR_ACCOUNT_12];
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    self.view.backgroundColor = kthemeBlackColor;
    [self.view addSubview:self.tableView];
    
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth, 246) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor =kThemeWhiteColor;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
    
}

#pragma mark - delegates
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
    headerView.backgroundColor = kGrayBGColor;
    return headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier1 = @"UserTableViewTypeOneCell";
    static NSString * cellIdentifier2 = @"UserTableViewTypeTwoCell";
    static NSString * cellIdentifier3 = @"UserTableViewTypeThreeCell";
    if (indexPath.section == 0) {
        UserTableViewTypeOneCell * Cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!Cell) {
            Cell = [[UserTableViewTypeOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            Cell.backgroundColor = [UIColor clearColor];
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            Cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return Cell;
    }else if (indexPath.section == 1){
        UserTableViewTypeTwoCell * Cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (!Cell) {
            Cell = [[UserTableViewTypeTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            Cell.backgroundColor = [UIColor clearColor];
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            Cell.accessoryType = UITableViewCellAccessoryNone;
        }
        Cell.walletLab.text  = STRING_ACCOUNT_WALLET_16;
        return Cell;
    }else if(indexPath.section == 2){
        UserTableViewTypeTwoCell * Cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        if (!Cell) {
            Cell = [[UserTableViewTypeTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
            Cell.backgroundColor = [UIColor clearColor];
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            Cell.accessoryType = UITableViewCellAccessoryNone;
        }
        Cell.walletLab.text = STRING_ACCOUNT_SETTING_60;
        Cell.mCountLab1.hidden  = YES;
        Cell.mCountLab2.hidden = YES;
        return Cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            [self userViewclickAction:nil];
            break;
        case 1:
            [self walletViewclickAction:nil];
            break;
        case 2:
        {
            ShowSettingViewController * setting = [ShowSettingViewController initVC];
            setting.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:setting animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)userViewclickAction:(UITapGestureRecognizer *)sender
{
    //    [HDHud showHUDInView:self.view title:@"开发中。。。"];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [HDHud hideHUDInView:self.view];
    //    });
    UserInfoViewController * userVC  = [UserInfoViewController initVC];
    userVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userVC animated:YES];
}
-(void)walletViewclickAction:(UITapGestureRecognizer *)sender
{
//    ShowWalletViewController * account = [[ShowWalletViewController alloc]init];
//    account.address =WalletProfile.account.address.checksumAddress/*WalletProfile.address*/;
//    account.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:account animated:YES];
    
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

