//
//  ShowSettingViewController.m
//  ShowLive
//
//  Created by 周华 on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowSettingViewController.h"
#import "ShowForUsViewController.h"
#import "ShowLoginViewController.h"

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
    [self.navigationBarView setNavigationColor:NavigationColorwihte];
    self.view.backgroundColor = kThemeWhiteColor;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.LogoutBtn];
}
-(UIButton*)LogoutBtn
{
    if (!_LogoutBtn) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = (CGRect){0,kMainScreenHeight-44*Proportion375-KBottomHeight ,kMainScreenWidth,45*Proportion375+KBottomHeight};
        [button setTitle:@"退出" forState:UIControlStateNormal];
        button.backgroundColor = kThemeYellowColor;
        _LogoutBtn = button;
    }
    [[_LogoutBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self presentViewController:[ShowLoginViewController initVC] animated:YES completion:^{
            
        }];
    }];
    return _LogoutBtn;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth, kMainScreenHeight-kNaviBarHeight) style:UITableViewStylePlain];
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
    return .01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*WScale;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * Cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!Cell) {
        Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
            Cell.textLabel.text = @"去评分";
            break;
        case 1:
            Cell.textLabel.text = @"帮助与反馈";
            break;
        case 2:
            Cell.textLabel.text = @"多语言";
            break;
        case 3:
            Cell.textLabel.text = @"货币单位";
            break;
        case 4:
            Cell.textLabel.text = @"网络诊断";
            break;
        case 5:
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
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            [self.navigationController pushViewController:[ShowForUsViewController initVC] animated:YES];
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
