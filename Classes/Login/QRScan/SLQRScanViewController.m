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


@end

@implementation SLQRScanView

@end


@interface SLQRBottomView ()
@property (nonatomic, strong) UIButton *button;
@end


@implementation SLQRBottomView

@end
