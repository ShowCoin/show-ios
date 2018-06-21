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
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth, kMainScreenHeight-kNaviBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setBackgroundColor:kBlackThemeBGColor];
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
    }
    return _tableView;
}
-(UISwitch *)GestureSwitch
{
    if (!_GestureSwitch) {
        _GestureSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kMainScreenWidth - 65, 0, 50, 25)];
        _GestureSwitch.centerY = 65/2;
    }
    return _GestureSwitch;
}
-(UISwitch *)handSwitch
{
    if (!_handSwitch) {
        _handSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kMainScreenWidth - 65, 0, 50, 25)];
        _handSwitch.centerY = 65/2;
    }
    return _handSwitch;
}
-(UISwitch *)reSureSwitch
{
    if (!_reSureSwitch) {
        _reSureSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kMainScreenWidth - 65, 0, 50, 25)];
        _reSureSwitch.centerY = 65/2;
    }
    return _reSureSwitch;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view;
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 15)];
    view.backgroundColor = kBlackThemeColor;
    if (section == 0) {
        view.height = 0;
    }else{
        view.height = 15;
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return  100  ;
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 100)];
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 5, 300, 10) text:@"开启后每次下单都需要二次确认" textColor:kGrayWith999999 font:Font_Regular(10) backgroundColor:[UIColor clearColor ]];
        [view addSubview:label];
        return view;
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 3;
    }else{
        return 1;
    }
    return 6;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


@end
