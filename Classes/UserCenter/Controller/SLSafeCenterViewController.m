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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLSafeCenterCell * Cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Cell = [[SLSafeCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!Cell) {
        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    Cell.title.text = @"手势密码";
                    [Cell addSubview:self.GestureSwitch];
                    Cell.arrow.hidden = YES;
                    break;
                case 1:
                    Cell.title.text = @"   需要手势密码";
                    Cell.arrow.hidden = NO;
                    Cell.textLab.text = @"2分钟";
                    Cell.textLab.right = kMainScreenWidth - 32*Proportion375;
                    break;
                case 2:
                    Cell.title.text = @"   修改手势密码";
                    Cell.arrow.hidden = NO;

                    break;
                case 3:
                    Cell.title.text = @"   指纹解锁";
                    [Cell addSubview:self.handSwitch];
                    Cell.arrow.hidden = YES;
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    Cell.title.text = @"绑定手机";
                    Cell.arrow.hidden = YES;
                    Cell.textLab.text = @"未绑定";
                    Cell.textLab.textColor =HexRGBAlpha(0x066bfc, 1);
                    break;
                case 1:
                    Cell.title.text = @"绑定邮箱";
                    Cell.arrow.hidden = YES;
                    Cell.textLab.text = @"已绑定";
                    Cell.textLab.textColor =kGrayWith999999;
                    break;
                case 2:
                    Cell.title.text = @"资金密码";
                    Cell.arrow.hidden = NO;
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            Cell.title.text = @"在线有效期";
            Cell.arrow.hidden = NO;
            Cell.textLab.text = @"1天";
            Cell.textLab.right = kMainScreenWidth - 32*Proportion375;

        }
            break;
        case 3:
        {
            Cell.title.text = @"下单二次确认";
            [Cell addSubview:self.reSureSwitch];
            Cell.arrow.hidden = YES;

        }
            break;
        default:
            break;
    }
    return Cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
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
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    
                    break;
                case 1:
                    break;
                case 2:
                    [PageMgr pushToSLChangeCoinPasswordController];
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
        }
            break;
        case 3:
        {
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
