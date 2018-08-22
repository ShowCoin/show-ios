//
//  SLQRScanViewController.m
//  Edu
//
//  Created by chenyh on 2018/8/8.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLQRScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SLImagePicker.h"
#import "SLPlayerMoreController.h"

NSString * const kInviteCodePrefix = @"http://api.xiubi.com/invite/clickLink/";

@interface SLQRScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureDeviceInput *input;

@property (nonatomic, strong) SLQRScanView   *centerView;
@property (nonatomic, strong) SLQRBottomView *bottomView;

@end

@implementation SLQRScanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.session startRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.session stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBarView setNavigationTitle:@"扫描二维码"];
    self.navigationBarView.backgroundColor = kNavigationBGColor;
    [self.navigationBarView setNavigationLineHidden:YES];
    
    [self addDeviceInput];
    [self addDeviceOutput];
    [self addPreviewLayer];
    [self.view insertSubview:self.centerView atIndex:1];
    [self.view addSubview:self.bottomView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat h = CGRectGetHeight(self.view.frame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    
    self.centerView.frame = self.view.bounds;
    
    CGFloat bottomH = KTabbarSafeBottomMargin + 44;
    CGFloat bottomY = h - bottomH;
    self.bottomView.frame = CGRectMake(0, bottomY, w, bottomH);
}

- (void)addPreviewLayer {
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.frame = UIScreen.mainScreen.bounds;
    [self.view.layer insertSublayer:preview atIndex:0];
}

- (void)addDeviceOutput {
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    
    CGFloat scanWH = screenSize.width * 0.6;

    CGRect scanRect = CGRectMake((screenSize.width - scanWH) / 2,
                                 (screenSize.height - scanWH) / 2,
                                 scanWH, scanWH);

    self.centerView.scanRect = scanRect;

    CGFloat x = scanRect.origin.y / screenSize.height;
    CGFloat y = scanRect.origin.x / screenSize.width;
    CGFloat w = scanRect.size.height / screenSize.height;
    CGFloat h = scanRect.size.width  / screenSize.width;
    scanRect = CGRectMake(x, y, w, h);
    
    output.rectOfInterest = scanRect;//SLFuncGetScreenCenterRect(100);
    
    
    self.output = output;
}


@end

@implementation SLQRScanView

@end


@interface SLQRBottomView ()
@property (nonatomic, strong) UIButton *button;
@end


@implementation SLQRBottomView

@end
