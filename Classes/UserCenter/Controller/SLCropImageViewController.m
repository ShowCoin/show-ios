//
//  SLCropImageViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/5/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLCropImageViewController.h"

@interface SLCropImageViewController ()
@property (nonatomic,strong)UIImage *cropImg;

@end

@implementation SLCropImageViewController

- (instancetype)initWithCropImage:(UIImage *)cropImage{
    
    if (self = [super init]) {
        self.cropImg = cropImage;
        [self viewConfig];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBarView setNavigationColor:NavigationColorClear];
    self.navigationBarView.leftView.hidden =YES;
    self.view.backgroundColor = kBlackThemeBGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewConfig{
    
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    cancleBtn.frame = CGRectMake(0, kMainScreenHeight- KTabBarHeight, [UIScreen mainScreen].bounds.size.width/2, 50);
    cancleBtn.backgroundColor = kBlackThemeBGColor;
    [cancleBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cancleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [cancleBtn lineDockTopWithColor:HexRGBAlpha(0xffffff, .2)];
    [self.view addSubview:cancleBtn];
    
    UIButton *okBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    okBtn.backgroundColor = kBlackThemeBGColor;
    [okBtn addTarget:self action:@selector(okBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    okBtn.frame = CGRectMake(CGRectGetMaxX(cancleBtn.frame), CGRectGetMinY(cancleBtn.frame), CGRectGetWidth(cancleBtn.frame), CGRectGetHeight(cancleBtn.frame));
    [okBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    okBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    okBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [okBtn lineDockTopWithColor:HexRGBAlpha(0xffffff, .2)];
    [self.view addSubview:okBtn];
}

- (void)viewDidAppear:(BOOL)animated{
    _tkImageView.cropAspectRatio = 0;
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
