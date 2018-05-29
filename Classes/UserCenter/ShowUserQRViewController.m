//
//  ShowUserQRViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowUserQRViewController.h"

@interface ShowUserQRViewController ()
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *IDLab;
@property (nonatomic, strong) UIImageView *tipImgView;
@property (nonatomic, strong) SLHeadPortrait *headerImageView;
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
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    [self.navigationBarView setRightIconImage:[UIImage imageNamed:@"userhome_avatar_more"] forState:UIControlStateNormal];



    [self setupViews];

}
- (void)setupViews {
    [self.view setBackgroundColor:kBlackThemeBGColor];
    [self.view addSubview:self.mainView];
    
}
#pragma mark ------------------------懒加载------------------------
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(30*Proportion375, 65*Proportion375+KNaviBarHeight, kMainScreenWidth - 60*Proportion375, 480*Proportion375)];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.cornerRadius = 4;
        _mainView.layer.shadowColor = kTextGrayColor.CGColor;
        _mainView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        
        _headerImageView = [[SLHeadPortrait alloc] initWithFrame:CGRectMake((_mainView.width - 90*Proportion375)/2, -43*Proportion375, 90*Proportion375, 90*Proportion375)];
        [_headerImageView setRoundStyle:YES imageUrl:AccountUserInfoModel.avatar imageHeight:100 vip:NO attestation:NO];
        [_mainView addSubview:_headerImageView];

        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_headerImageView.right+12,_headerImageView.bottom + 13*Proportion375, _mainView.width- 120*Proportion375, 17*Proportion375)];
        _nameLab.centerX  = _mainView.width/2;
        _nameLab.textColor = kthemeBlackColor;
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.text = AccountUserInfoModel.nickname;
        _nameLab.font = [UIFont systemFontOfSize:17*Proportion375];
        [_mainView addSubview:_nameLab];
        

        _IDLab = [[UILabel alloc] initWithFrame:CGRectMake(3, 80*Proportion375, _mainView.width- 120*Proportion375, 12*Proportion375)];
        _IDLab.textColor = kGrayWith999999;
        _IDLab.centerX  = _mainView.width/2;
        _IDLab.textAlignment = NSTextAlignmentCenter;
        _IDLab.text =[NSString stringWithFormat:@"秀号 %@",AccountUserInfoModel.popularNo];
        _IDLab.font = Font_Regular(12*WScale);
        [_mainView addSubview:_IDLab];
        
        _qrCodeImgView = [[UIImageView alloc] initWithFrame:CGRectMake((_mainView.width-280*Proportion375)*0.5, 150*Proportion375, 280*Proportion375, 280*Proportion375)];
        _qrCodeImgView.image = [UIImage createNonInterpolatedUIImageFormStr:AccountUserInfoModel.popularNo];
        [_mainView addSubview:_qrCodeImgView];
        _qrCodeImgView.backgroundColor = kThemeRedColor;
        
        _tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _qrCodeImgView.bottom+19*Proportion375, _mainView.width, 14)];
        _tipLab.textColor = kGrayWith999999;
        _tipLab.textAlignment = NSTextAlignmentCenter;
        _tipLab.font = [UIFont systemFontOfSize:14];
        _tipLab.text = @"扫一扫上面的二维码图案，加我好友";
        [_mainView addSubview:_tipLab];
        
        UILabel * cointextLab= [UILabel labelWithText:@"测试币" textColor:kthemeBlackColor font:Font_Regular(16*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        [cointextLab sizeToFit];
        cointextLab.bottom = _qrCodeImgView.top - 7*Proportion375;
        cointextLab.left = _mainView.width/2+1;
        [_mainView addSubview:cointextLab];
        
        UILabel * coinnumLab = [UILabel labelWithText:AccountUserInfoModel.showCoinStr textColor:kthemeBlackColor font:Font_Regular(25*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        [coinnumLab sizeToFit];
        coinnumLab.right = _mainView.width/2-1;
        coinnumLab.bottom = _qrCodeImgView.top - 2*Proportion375;
        [_mainView addSubview:coinnumLab];
        
        CGFloat width = cointextLab.width + coinnumLab.width + 2;
        CGFloat left = (_mainView.width- width)/2;
        coinnumLab.left = left;
        cointextLab.left = coinnumLab.right + 2;
        
        
        
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
#pragma mark - 创建二维码/条形码
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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
