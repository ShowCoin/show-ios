//
//  SLNetDiagnoViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLNetDiagnoViewController.h"
#import "LDNetDiagnoService.h"

@interface SLNetDiagnoViewController () <LDNetDiagnoServiceDelegate, UITextFieldDelegate> {
    
}
@property (nonatomic,strong)UITextView *txtView_log;
@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;
@property (nonatomic,copy)NSString *logInfo;
@property (nonatomic,strong)LDNetDiagnoService *netDiagnoService;
@property (nonatomic,assign)BOOL isRunning;


@end

@implementation SLNetDiagnoViewController
- (void)dealloc
{
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    _isRunning = !_isRunning;
    [_netDiagnoService stopNetDialogsis];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    _txtView_log.text = @"";
    _logInfo = @"";
    _isRunning = !_isRunning;
    [_netDiagnoService startNetDiagnosis];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setNavigationTitle:@"网络诊断"];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];

    
    _txtView_log = [[UITextView alloc] initWithFrame:CGRectZero];
    _txtView_log.backgroundColor = kBlackThemeBGColor;
    _txtView_log.font = [UIFont systemFontOfSize:10.0f];
    _txtView_log.textAlignment = NSTextAlignmentLeft;
    _txtView_log.scrollEnabled = YES;
    _txtView_log.textColor = kBlackThemetextColor;
    _txtView_log.editable = NO;
    _txtView_log.frame =CGRectMake(0.0f, KNaviBarHeight, kMainScreenWidth, kMainScreenHeight - KNaviBarHeight);
    [self.view addSubview:_txtView_log];
    
    // Do any additional setup after loading the view, typically from a nib.
    _netDiagnoService = [[LDNetDiagnoService alloc] initWithAppCode:@"NetWork Diagnosis"
                                                            appName:[SLUtils appName]
                                                         appVersion:[SLUtils appVersion]
                                                             userID:@"kefu01@showlive.one"
                                                           deviceID:nil
                                                            dormain:@"www.baidu.com"
                                                        carrierName:nil
                                                     ISOCountryCode:nil
                                                  MobileCountryCode:nil
                                                      MobileNetCode:nil];
    _netDiagnoService.delegate = self;
    _isRunning = NO;

    // Do any additional setup after loading the view.
}
#pragma mark NetDiagnosisDelegate
- (void)netDiagnosisDidStarted
{
    NSLog(@"开始诊断～～～");
}

- (void)netDiagnosisStepInfo:(NSString *)stepInfo
{
    NSLog(@"%@", stepInfo);
    _logInfo = [_logInfo stringByAppendingString:stepInfo];
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        self.txtView_log.text = self.logInfo;
    });
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
