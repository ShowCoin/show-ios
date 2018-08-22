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

- (void)addDeviceInput {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    self.input = input;
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {

    if (metadataObjects.count == 0) return;
    
    [self.session stopRunning];
    
    AVMetadataMachineReadableCodeObject *obj = metadataObjects.firstObject;
    
    [self backActionWithInfo:obj.stringValue];
}

- (NSString *)sl_detectorQRImage:(UIImage *)image {
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    
    CIImage *cImage = [CIImage imageWithCGImage:image.CGImage];
    
    NSArray *features = [detector featuresInImage:cImage];
    
    CIQRCodeFeature *feature = features.firstObject;
    
    return feature.messageString;
}

- (void)photoLibraryAction {
    [SLImagePicker.shared showPickerControllerWithViewController:self];
    @weakify(self)
    [SLImagePicker.shared getPickerImage:^(NSDictionary<NSString *,id> *info) {
        @strongify(self)
        UIImage *image = info[UIImagePickerControllerEditedImage];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *result = [self sl_detectorQRImage:image];
            
            if (result.length == 0) {
                [self sl_showAlertMessage:@"未扫识别到二维码" cancel:@"重新扫描"];
                return;
            }
            [self backActionWithInfo:result];
        });
        
    }];
}

- (void)backActionWithInfo:(NSString *)result {
    if (![result hasPrefix:kInviteCodePrefix]) {
        [self sl_showAlertMessage:@"此二维码不符合标准！" cancel:@"重新扫描"];
        return;
    }
    
    if (self.scanBlock) {
        self.scanBlock(result);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy

- (SLQRScanView *)centerView {
    if (!_centerView) {
        _centerView = [[SLQRScanView alloc] init];
        _centerView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    }
    return _centerView;
}

- (SLQRBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SLQRBottomView alloc] init];
        _bottomView.target = self;
    }
    return _bottomView;
}

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    return _session;
}


@end

@implementation SLQRScanView

@end


@interface SLQRBottomView ()
@property (nonatomic, strong) UIButton *button;
@end


@implementation SLQRBottomView

@end
