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


@end
