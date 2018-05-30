//
//  UserInfoViewController.m
//  ShowLive
//
//  Created by vning on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoListCell.h"
#import "ChangeheadportraitController.h"
#import "ShowUserQRViewController.h"
#import "ChangeGenderViewController.h"
#import "ChangeTextController.h"
#import "ShowUserQRViewController.h"
@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationTitle:STRING_ACCOUNT_ME_63];
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    self.view.backgroundColor = kThemeWhiteColor;
    [self.view addSubview:self.tableView];

}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight, KScreenWidth, KScreenHeight - KNaviBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =kThemeWhiteColor;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _tableView;
}
#pragma mark - delegates
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 60;
    }else{
        
        return 50;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"UserInfoListCell";
    UserInfoListCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UserInfoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    switch (indexPath.row) {
        case 0:
            cell.name.text = STRING_USER_EDIT_HEADPORTRAIT_64;
            [cell.avatar setRoundStyle:YES imageUrl:AccountUserInfoModel.avatar imageHeight:45 vip:NO attestation:NO];
            break;
        case 1:
            cell.name.text = STRING_USER_EDIT_NAME_65;
            cell.text.text = AccountUserInfoModel.nickname;
            break;
        case 2:
            cell.name.text = STRING_USER_EDIT_ID_66;
            cell.text.text = AccountUserInfoModel.popularNo;
            break;
        case 3:
            cell.name.text = STRING_USER_EDIT_GENDER_67;
            cell.text.text = [AccountUserInfoModel.gender isEqualToString:@"1"]?@"男":@"女";
            break;
        case 4:
            cell.name.text = STRING_USER_EDIT_AREA_68;
            cell.text.text = AccountUserInfoModel.city;
            break;
        case 5:
            cell.name.text = STRING_USER_EDIT_SIGNATURE_69;
            cell.text.text = AccountUserInfoModel.descriptions;
            break;
        case 6:
            cell.name.text = STRING_USER_EDIT_MYCODE_70;
            break;
        default:
            break;
    }
    if (indexPath.row == 0) {
        [cell setCelltype:firstcellType];
    }else{
        [cell setCelltype:othertcellType];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            ChangeheadportraitController * A = [ChangeheadportraitController initVC];
            [self.navigationController pushViewController:A animated:YES];
        }
            break;
        case 1:{
            ChangeTextController * B = [ChangeTextController initVC];
            B.navtitle =@"名称";
            B.type = textViewType_name;
            B.block = ^(NSString *changeText) {
                [self.tableView reloadData];
            };

            [self.navigationController pushViewController:B animated:YES];
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            ChangeGenderViewController * D = [ChangeGenderViewController initVC];
            
            [self.navigationController pushViewController:D animated:YES];

        }
            break;
        case 4:{
            ChangeTextController * E= [ChangeTextController initVC];
            E.navtitle = @"地区";
            E.type = textViewType_city;
            E.block = ^(NSString *changeText) {
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:E animated:YES];

        }
            break;
        case 5:{
            ChangeTextController * F = [ChangeTextController initVC];
            F.navtitle = @"签名";
            F.type = textViewType_sign;
            F.block = ^(NSString *changeText) {
                [self.tableView reloadData];
            };

            [self.navigationController pushViewController:F animated:YES];

        }
            break;
        case 6:{
            [self.navigationController pushViewController:[ShowUserQRViewController initVC] animated:YES];
        }
            break;
        default:
            break;
    }
    
   
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
