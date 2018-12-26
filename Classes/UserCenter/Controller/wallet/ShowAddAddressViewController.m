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
- (UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        _sureButton.clipsToBounds = YES;
        _sureButton.frame = CGRectMake(15*Proportion375, 20, kMainScreenWidth-30*Proportion375, 45*Proportion375);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
//        [_sureButton setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
//        [_sureButton setBackgroundImage:[UIImage imageNamed:@"wallet_withdraw_sure"] forState:UIControlStateNormal];
        [_sureButton setBackgroundImage:[UIImage imageNamed:@"wallet_withdraw_nomal"] forState:UIControlStateNormal];
        [_sureButton setTitleColor:kThemeWhiteColor  forState:UIControlStateNormal];
        _sureButton.userInteractionEnabled = NO;
//        [_sureButton roundHeightStyle];
        [_sureButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth, kMainScreenHeight - kNaviBarHeight) style:UITableViewStylePlain];
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
        _tableView.separatorColor = kSeparationColor;

    }
    return _tableView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 100*Proportion375)];
    [view addSubview:self.sureButton];
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(15*Proportion375, 0, kMainScreenWidth - 15*Proportion375, 0.5)];
    line.backgroundColor = kSeparationColor;
    [view addSubview:line];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100*Proportion375;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        return 100*WScale ;
    }else if (self.walletVerify){
        return 50*WScale;

    }else{
        if (indexPath.row == 4) {
//            if (indexPath.row == 4 || indexPath.row == 5) {
            return 0;
        }else{
            return 50*WScale;
        }
    }
    return 0;
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
