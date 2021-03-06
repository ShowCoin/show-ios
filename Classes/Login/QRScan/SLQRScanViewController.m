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

NSString * const kInviteCodePrefix = @"http://api.xiubi.com/";

@interface SLQRScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureDeviceInput *input;

@property (nonatomic, strong) SLQRScanView   *centerView;
@property (nonatomic, strong) SLQRBottomView *bottomView;

@end

@implementation SLQRScanViewController

/**
 viewWillAppear

 @param animated animated
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.session startRunning];
}

/**
 viewDidDisappear

 @param animated animated
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.session stopRunning];
}

/**
 viewDidLoad
 */
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

/**
 viewWillLayoutSubviews
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat h = CGRectGetHeight(self.view.frame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    
    self.centerView.frame = self.view.bounds;
    
    CGFloat bottomH = KTabbarSafeBottomMargin + 44;
    CGFloat bottomY = h - bottomH;
    self.bottomView.frame = CGRectMake(0, bottomY, w, bottomH);
}

/**
 addPreviewLayer
 */
- (void)addPreviewLayer {
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.frame = UIScreen.mainScreen.bounds;
    [self.view.layer insertSublayer:preview atIndex:0];
}

/**
 addDeviceOutput
 */
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

/**
 addDeviceInput
 */
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

/**
 captureOutput

 @param output AVCaptureOutput
 @param metadataObjects NSArray
 @param connection AVCaptureConnection
 */
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {

    if (metadataObjects.count == 0) return;
    
    [self.session stopRunning];
    
    AVMetadataMachineReadableCodeObject *obj = metadataObjects.firstObject;
    
    [self backActionWithInfo:obj.stringValue];
}

/**
 sl_detectorQRImage

 @param image UIImage
 @return NSString
 */
- (NSString *)sl_detectorQRImage:(UIImage *)image {
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    
    CIImage *cImage = [CIImage imageWithCGImage:image.CGImage];
    
    NSArray *features = [detector featuresInImage:cImage];
    
    CIQRCodeFeature *feature = features.firstObject;
    
    return feature.messageString;
}

/**
 photoLibraryAction
 */
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

/**
 backActionWithInfo

 @param result NSString
 */
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

/**
 centerView

 @return SLQRScanView
 */
- (SLQRScanView *)centerView {
    if (!_centerView) {
        _centerView = [[SLQRScanView alloc] init];
        _centerView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    }
    return _centerView;
}

/**
 bottomView

 @return SLQRBottomView
 */
- (SLQRBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SLQRBottomView alloc] init];
        _bottomView.target = self;
    }
    return _bottomView;
}

/**
 session

 @return AVCaptureSession
 */
- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    return _session;
}


@end

/**
 SLQRScanView
 */
@implementation SLQRScanView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.size = CGSizeMake(3, 25);
        self.cornerLineColor = [UIColor blueColor];
        self.borderColor = [UIColor whiteColor];
    }
    return self;
}

/**
 setCornerLineColor

 @param cornerLineColor UIColor
 */
- (void)setCornerLineColor:(UIColor *)cornerLineColor {
    if (_cornerLineColor != cornerLineColor) {
        _cornerLineColor = cornerLineColor;
        [self setNeedsDisplay];
    }
}

/**
 setBorderColor

 @param borderColor borderColor
 */
- (void)setBorderColor:(UIColor *)borderColor {
    if (borderColor != _borderColor) {
        _borderColor = borderColor;
        [self setNeedsDisplay];
    }
}

/**
 setScanRect

 @param scanRect scanRect
 */
- (void)setScanRect:(CGRect)scanRect {
    _scanRect = scanRect;
    [self setNeedsDisplay];
}

/**
 setSize

 @param size size
 */
- (void)setSize:(CGSize)size {
    _size = size;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor colorWithWhite:0 alpha:0.3] set];
    UIRectFill(rect);
    CGRect clearIntersection = CGRectIntersection(self.scanRect, rect);
    [[UIColor clearColor] set];
    UIRectFill(clearIntersection);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.scanRect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [self.borderColor set];
    CGContextStrokePath(context);
    
    CGFloat x = self.scanRect.origin.x;
    CGFloat y = self.scanRect.origin.y;
    CGFloat margin = self.size.height;
    
    CGPoint p1[3];
    p1[0] = CGPointMake(x + margin, y);
    p1[1] = CGPointMake(x, y);
    p1[2] = CGPointMake(x, y + margin);
    CGContextAddLines(context, p1, 3);
    CGContextSetLineWidth(context, self.size.width);
    [self.cornerLineColor set];
    CGContextDrawPath(context, kCGPathStroke);
    
    x = CGRectGetMaxX(self.scanRect);
    y = self.scanRect.origin.y;
    
    CGPoint p2[3];
    p2[0] = CGPointMake(x - margin, y);
    p2[1] = CGPointMake(x, y);
    p2[2] = CGPointMake(x, y + margin);
    CGContextAddLines(context, p2, 3);
    CGContextSetLineWidth(context, self.size.width);
    CGContextDrawPath(context, kCGPathStroke);
    
    x = self.scanRect.origin.x;
    y = CGRectGetMaxY(self.scanRect);
    
    CGPoint p3[3];
    p3[0] = CGPointMake(x, y - margin);
    p3[1] = CGPointMake(x, y);
    p3[2] = CGPointMake(x + margin, y);
    CGContextAddLines(context, p3, 3);
    CGContextSetLineWidth(context, self.size.width);
    CGContextDrawPath(context, kCGPathStroke);
    
    x = CGRectGetMaxX(self.scanRect);
    y = CGRectGetMaxY(self.scanRect);
    
    CGPoint p4[3];
    p4[0] = CGPointMake(x, y - margin);
    p4[1] = CGPointMake(x, y);
    p4[2] = CGPointMake(x - margin, y);
    CGContextAddLines(context, p4, 3);
    CGContextSetLineWidth(context, self.size.width);
    CGContextDrawPath(context, kCGPathStroke);
}

@end


@interface SLQRBottomView ()
@property (nonatomic, strong) UIButton *button;
@end


@implementation SLQRBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.button];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = CGRectGetWidth(self.frame);
    self.button.frame = CGRectMake(0, 0, w, 44);
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"相册" forState:UIControlStateNormal];
    }
    return _button;
}

- (void)setTarget:(id)target {
    _target = target;
    [self.button addTarget:target action:@selector(photoLibraryAction) forControlEvents:UIControlEventTouchUpInside];
}

@end
