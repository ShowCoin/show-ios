//
//  IdentificationViewController.m
//  test
//
//  Created by chenyh on 2018/7/2.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLAuthIdentityViewController.h"
#import "SLAuthenticationView.h"
#import "ImagePicker.h"

@interface SLAuthIdentityViewController ()

/// scrollView
@property (nonatomic, weak) UIScrollView *scrollView;
/// countryView
@property (nonatomic, weak) SLAICountryView *countryView;
/// prosView
@property (nonatomic, weak) SLAuthenticationView *prosView;
/// consView
@property (nonatomic, weak) SLAuthenticationView *consView;
/// handView
@property (nonatomic, weak) SLAuthenticationView *handView;
@property (nonatomic, weak) UIView *tipView;
@property (nonatomic, weak) UITextView *payLabel;
@property (nonatomic, weak) UILabel *bottomLabel;
@property (nonatomic, weak) UIButton *submit;

@property (nonatomic, strong) SLCountryModalView *modalView;

@end

@implementation SLAuthIdentityViewController

/**
 viewDidLoad
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction)];
    [self setupUI];
}

/**
 refreshAction
 */
- (void)refreshAction {
    int i = arc4random_uniform(3);
    if (i == 0) {
        self.prosView.errorMsg = @"提示：快点傻女，赶紧湖区家里，嗷嗷add多多";
        self.consView.errorMsg = @"";
        self.handView.errorMsg = @"";
    } else if ( i== 1) {
        self.consView.errorMsg = @"提示：快点傻女那是多久，卡多少地，顶顶顶顶请求打点的的的的";
        self.prosView.errorMsg = @"";
        self.handView.errorMsg = @"";
    } else {
        self.prosView.errorMsg = @"";
        self.consView.errorMsg = @"";
        self.handView.errorMsg = @"提示：快点傻女，嗯哼哼看看密码奥奥奥，欧浓";
    }
    
    [self viewDidLayoutSubviews];
}

/**
 setupUI
 */
- (void)setupUI {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    SLAICountryView *countryView = [SLAICountryView countryView];//[[SLAICountryView alloc] init];
    [scrollView addSubview:countryView];
    self.countryView = countryView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCity)];
    [countryView addGestureRecognizer:tap];
    
    SLAuthenticationView *prosView = [[SLAuthenticationView alloc] init];
    prosView.type = SLIdCardTypePros;
    __weak typeof(self) wself = self;
    prosView.clickBlock = ^{
        [wself selectProsImage];
    };
    [scrollView addSubview:prosView];
    self.prosView = prosView;
    
    SLAuthenticationView *consView = [[SLAuthenticationView alloc] init];
    consView.type = SLIdCardTypeCons;
    consView.clickBlock = ^{
        [wself selectConsImage];
    };
    [scrollView addSubview:consView];
    self.consView = consView;
    
    SLAuthenticationView *handView = [[SLAuthenticationView alloc] init];
    handView.type = SLIdCardTypeHand;
    handView.clickBlock = ^{
        [wself selectHandImage];
    };
    [scrollView addSubview:handView];
    self.handView = handView;
    
    UITextView *textView = [[UITextView alloc] init];
    textView.textContainerInset = UIEdgeInsetsMake(15, 13, 15, 13);
    textView.textColor = [UIColor redColor];
    textView.font = [UIFont systemFontOfSize:12];
    textView.backgroundColor = SLNormalColor;
    textView.userInteractionEnabled = NO;
    textView.text = @"每提交一次KYC认证，系统将扣除价值人民币1.00元的SHOW币，请谨慎上传证件照片。";
    [scrollView addSubview:textView];
    self.payLabel = textView;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请确认使用您的真实身份参加验证";
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:label];
    self.bottomLabel = label;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // bg 333333
    // enable 808080
    button.backgroundColor = SLNormalColor;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.enabled = NO;
    [scrollView addSubview:button];
    self.submit = button;
}

/**
 viewDidLayoutSubviews
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    self.scrollView.frame = CGRectMake(0, 0, w, h);
    
    CGFloat marginX = 15;
    CGFloat labelW = w - marginX * 2;
    
    CGFloat cityY = 13;//CGRectGetMaxY(self.tipLabel.frame) + 13;
    CGFloat cityH = 45;
    self.countryView.frame = CGRectMake(0, cityY, w, cityH);
    
    CGFloat prosY = CGRectGetMaxY(self.countryView.frame) + 15;
    self.prosView.frame = CGRectMake(0, prosY, w, self.prosView.viewH);
    
    CGFloat consY = CGRectGetMaxY(self.prosView.frame);
    self.consView.frame = CGRectMake(0, consY, w, self.consView.viewH);
    
    CGFloat handY = CGRectGetMaxY(self.consView.frame);
    self.handView.frame = CGRectMake(0, handY, w, self.handView.viewH);
    
    CGFloat payY = CGRectGetMaxY(self.handView.frame) + 15;
    CGFloat payH = [self.payLabel.text boundingRectWithSize:CGSizeMake(labelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.payLabel.font} context:nil].size.height + self.payLabel.textContainerInset.top + self.payLabel.textContainerInset.bottom;
    self.payLabel.frame = CGRectMake(0, payY, w, payH);
    
    CGFloat bottomY = CGRectGetMaxY(self.payLabel.frame) + 60;
    self.bottomLabel.frame = CGRectMake(0, bottomY, w, self.bottomLabel.font.lineHeight);
    
    CGFloat submitY = CGRectGetMaxY(self.bottomLabel.frame) + 15;
    self.submit.frame = CGRectMake(0, submitY, w, 45);
    
    CGFloat sizeH = CGRectGetMaxY(self.submit.frame) + 50;
    self.scrollView.contentSize = CGSizeMake(0, sizeH);
}



/**
 selectCity
 */
- (void)selectCity {
    if (!self.modalView) {
        self.modalView = [[SLCountryModalView alloc] initWithSuperView:self.view animationTravel:0.25 viewHeight:200];
    }
    self.submit.enabled = YES;
    [self.modalView show];
}

/**
 selectProsImage
 */
- (void)selectProsImage {
    ImagePicker.sharedInstance.currentViewController = self;
    [ImagePicker.sharedInstance showActionSheetWithViewController:self];
    __weak typeof(self) wself = self;
    ImagePicker.sharedInstance.pickerImage = ^(UIImage *image) {
        wself.prosView.imageView.image = image;
    };
}

/**
 selectConsImage
 */
- (void)selectConsImage {
    ImagePicker.sharedInstance.currentViewController = self;
    [ImagePicker.sharedInstance showActionSheetWithViewController:self];
    __weak typeof(self) wself = self;
    ImagePicker.sharedInstance.pickerImage = ^(UIImage *image) {
        wself.consView.imageView.image = image;
    };
}

/**
 selectHandImage
 */
- (void)selectHandImage {
    ImagePicker.sharedInstance.currentViewController = self;
    [ImagePicker.sharedInstance showActionSheetWithViewController:self];
    __weak typeof(self) wself = self;
    ImagePicker.sharedInstance.pickerImage = ^(UIImage *image) {
        wself.handView.imageView.image = image;
    };
}

/**
 submitAction
 */
- (void)submitAction {
    [self.prosView showAuthImageType:SLAuthImageTypeSuccess];
    [self.consView showAuthImageType:SLAuthImageTypeFailed];
    [self.handView showAuthImageType:SLAuthImageTypeNormal];
}

/**
 dealloc
 */
- (void)dealloc {
    NSLog(@"%s", __func__);
    if (self.modalView) {
        [self.modalView disMiss];
    }
}

@end
