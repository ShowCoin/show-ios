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

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) SLAICountryView *countryView;
@property (nonatomic, weak) SLAuthenticationView *prosView;
@property (nonatomic, weak) SLAuthenticationView *consView;
@property (nonatomic, weak) SLAuthenticationView *handView;
@property (nonatomic, weak) UIView *tipView;
@property (nonatomic, weak) UITextView *payLabel;
@property (nonatomic, weak) UILabel *bottomLabel;
@property (nonatomic, weak) UIButton *submit;

@property (nonatomic, strong) SLCountryModalView *modalView;

@end

@implementation SLAuthIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction)];
    [self setupUI];
}


@end
