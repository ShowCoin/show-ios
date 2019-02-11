//
//  SLTopListViewController.m
//  ShowLive
//
//  Created by vning on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLTopListViewController.h"
#import "SLToplistSubView.h"

@interface SLTopListViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * bkscrollerView;
@property (nonatomic, strong) SLToplistSubView * contributionView;//贡献榜
@property (nonatomic, strong) SLToplistSubView * encourageView;//激励榜

@end

@implementation SLTopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
}

- (void)setUid:(NSString *)uid
{
    _uid = uid;
    UIButton * contributionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contributionBtn setTitle:@"激励榜" forState:UIControlStateNormal];
    [contributionBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
    [self.view addSubview:contributionBtn];
    
    UIButton * encourageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [encourageBtn setTitle:@"贡献榜" forState:UIControlStateNormal];
    [encourageBtn setTitleColor:kGrayWithaaaaaa forState:UIControlStateNormal];
    [self.view addSubview:encourageBtn];

    @weakify(self);
    [[contributionBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [contributionBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [encourageBtn setTitleColor:kGrayWithaaaaaa forState:UIControlStateNormal];
        [self.bkscrollerView setContentOffset:CGPointMake(0, 0) animated:NO];
    }];
    [[encourageBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [encourageBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [contributionBtn setTitleColor:kGrayWithaaaaaa forState:UIControlStateNormal];
        [self.bkscrollerView setContentOffset:CGPointMake(kMainScreenWidth, 0) animated:NO];
        
    }];
    
    
    [contributionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationBarView.leftView);
        //        make.right.equalTo(self.view).with.offset(kMainScreenWidth/2);
        make.left.equalTo(self.view).with.offset(kMainScreenWidth/2 - 100*Proportion375);
        
        make.size.mas_equalTo(CGSizeMake(100*Proportion375, 40));
    }];
    
    [encourageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationBarView.leftView);
        make.left.equalTo(self.view).with.offset(kMainScreenWidth/2);
        make.size.mas_equalTo(CGSizeMake(100*Proportion375, 40));
    }];
    
    [self.view addSubview:self.bkscrollerView];

}
- (UIScrollView *)bkscrollerView{
    if (!_bkscrollerView) {
        _bkscrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KNaviBarHeight, kMainScreenWidth, kMainScreenHeight - KNaviBarHeight)];
        _bkscrollerView.contentSize = CGSizeMake(kMainScreenWidth * 2, 0);
        _bkscrollerView.backgroundColor = kThemeWhiteColor;
        if (@available(iOS 11.0, *)) {
            _bkscrollerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _bkscrollerView.bounces=NO;
        _bkscrollerView.pagingEnabled = YES;
        _bkscrollerView.delegate = self;
        _bkscrollerView.showsHorizontalScrollIndicator = YES;
        _bkscrollerView.showsVerticalScrollIndicator = YES;
        _bkscrollerView.scrollEnabled = NO;
        [_bkscrollerView setContentOffset:CGPointMake(0, 0) animated:NO];
        [_bkscrollerView addSubview:self.contributionView];
        [_bkscrollerView addSubview:self.encourageView];
    }
    return _bkscrollerView;
}

- (SLToplistSubView *)contributionView
{
    if (!_contributionView) {
        _contributionView = [SLToplistSubView authViewWithFrame:CGRectMake(kMainScreenWidth, 0, kMainScreenWidth, kMainScreenHeight - KNaviBarHeight) andUid:self.uid];
        _contributionView.viewType = TopViewType_Contribution;
    }
        return _contributionView;
}

- (SLToplistSubView *)encourageView
{
    if (!_encourageView) {
        _encourageView = [SLToplistSubView authViewWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - KNaviBarHeight) andUid:self.uid];
        _encourageView.viewType = TopViewType_Encourage;
    }
    return _encourageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
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
