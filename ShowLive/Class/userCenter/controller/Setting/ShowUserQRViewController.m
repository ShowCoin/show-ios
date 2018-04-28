//
//  ShowUserQRViewController.m
//  ShowLive
//
//  Created by Mac on 2018/4/6.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowUserQRViewController.h"
#import "BTCQRCode.h"

@interface ShowUserQRViewController ()
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *IDLab;
@property (nonatomic, strong) UIImageView *tipImgView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *qrCodeImgView;
@property (nonatomic, strong) UILabel *tipLab;

@end

@implementation ShowUserQRViewController
-(void)dealloc
{
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationTitle:@"我的二维码"];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setRightIconImage:[UIImage imageNamed:@"userhome_avatar_more"] forState:UIControlStateNormal];

    [self setupViews];

}
- (void)setupViews {
    
    [self.view addSubview:self.mainView];
    
}
#pragma mark ------------------------懒加载------------------------
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(30*Proportion375, 55*Proportion375+kNaviBarHeight, kMainScreenWidth-60*Proportion375, 442*Proportion375)];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.cornerRadius = 4;
        _mainView.layer.shadowColor = kTextGrayColor.CGColor;
        _mainView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30*Proportion375, 30*Proportion375, 60*Proportion375, 60*Proportion375)];
        [_headerImageView yy_setImageWithURL:[NSURL URLWithString:@""] placeholder:[UIImage imageNamed:@"userhome_admin_Img"]]  ;
        [_mainView addSubview:_headerImageView];

        
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_headerImageView.right+10, 40*Proportion375, _mainView.width- 120*Proportion375, 20*Proportion375)];
        _nameLab.textColor = HexRGBAlpha(0x413E4F, 1);
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.text = @"admin";
        _nameLab.font = [UIFont systemFontOfSize:17*Proportion375];
        [_mainView addSubview:_nameLab];
        
        _IDLab = [[UILabel alloc] initWithFrame:CGRectMake(_headerImageView.right+10, _nameLab.bottom+5, _mainView.width- 120*Proportion375, 14*Proportion375)];
        _IDLab.textColor = kTextGrayColor;
        _IDLab.textAlignment = NSTextAlignmentLeft;
        _IDLab.text = @"ID: 12345678";
        _IDLab.font = [UIFont systemFontOfSize:12*Proportion375];
        [_mainView addSubview:_IDLab];
        
        _qrCodeImgView = [[UIImageView alloc] initWithFrame:CGRectMake((_mainView.width-250*Proportion375)*0.5, _IDLab.bottom+30*Proportion375, 250*Proportion375, 250*Proportion375)];
        _qrCodeImgView.image = [BTCQRCode imageForString:@"12345678" size:CGSizeMake(250*Proportion375, 250*Proportion375) scale:1];
        [_mainView addSubview:_qrCodeImgView];
        
        _tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _qrCodeImgView.bottom+20, _mainView.width, 15)];
        _tipLab.textColor = kTextGrayColor;
        _tipLab.textAlignment = NSTextAlignmentCenter;
        _tipLab.font = [UIFont systemFontOfSize:14];
        _tipLab.text = @"扫一扫上面的二维码图案，加我好友";
        [_mainView addSubview:_tipLab];
    }
    return _mainView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)clickRightButton:(UIButton *)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    UIAlertAction* otherAction = [UIAlertAction actionWithTitle:@"换个样式" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           //响应事件
                                                           NSLog(@"action = %@", action);
                                                       }];
    UIAlertAction* scanningAction = [UIAlertAction actionWithTitle:@"扫描二维码" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           //响应事件
                                                           NSLog(@"action = %@", action);
                                                       }];
    UIAlertAction* resetAction = [UIAlertAction actionWithTitle:@"重置二维码" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           //响应事件
                                                           NSLog(@"action = %@", action);
                                                       }];

    [alert addAction:otherAction];
    [alert addAction:saveAction];
    [alert addAction:scanningAction];
    [alert addAction:resetAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
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
