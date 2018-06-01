//
//  ShowForUsViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowForUsViewController.h"
#import "ShowForUsView.h"

@interface ShowForUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation ShowForUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationTitle:@"关于我们"];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor = kBlackThemeBGColor;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor =kBlackThemeBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kBlackThemeColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            
        }
        
    }
    return _tableView;
    
}

#pragma mark - delegates


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 205*WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShowForUsView * headerView = [[ShowForUsView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 205*WScale)];
    return headerView;
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
        Cell.textLabel.textColor = kBlackThemetextColor;
        Cell.backgroundColor = kBlackThemeBGColor;
    }
    switch (indexPath.row) {
        case 0:
            Cell.textLabel.text = @"社区公约";
            break;
        case 1:
            Cell.textLabel.text = @"隐私政策";
            
            break;
        case 2:
            Cell.textLabel.text = @"服务条款";
            break;
        case 3:
            Cell.textLabel.text = @"SHOW主播规范管理";
            break;
        case 4:
            Cell.textLabel.text = @"SHOW社区用户违规管理规则";
            break;
        case 5:
            Cell.textLabel.text = @"联系我们";
            break;
        default:
            break;
    }
    return Cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString * requestUrl;
    switch (indexPath.row) {
        case 1:
        {
            if(IS_EXIST_STR(SysConfig.privacy_page))
            {
                requestUrl = SysConfig.privacy_page;
            }else
            {
                requestUrl = @"http://www.xiubi.com/privacy.html";
            }
            [PageMgr pushToWebController:requestUrl title:@"隐私政策" share:NO];
        }
            break;
        case 2:
        {
            if(IS_EXIST_STR(SysConfig.service_page))
            {
                requestUrl = SysConfig.service_page;
            }else
            {
                requestUrl = @"http://www.xiubi.com/service.html";
            }
            [PageMgr pushToWebController:requestUrl title:@"服务条款" share:NO];
        }
            break;
        case 5:
        {
            if(IS_EXIST_STR(SysConfig.contact_page))
            {
                requestUrl = SysConfig.contact_page;
            }else
            {
                requestUrl = @"http://www.xiubi.com/contact.html";
            }
            [PageMgr pushToWebController:requestUrl title:@"联系我们" share:NO];
        }
            break;
        default:
            break;
    }
    
    
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
