//
//  ShowHomeViewController.m
//  ShowLive
//
//  Created by 周华 on 2018/4/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeViewController.h"
#import "ShowLiveConcernsController.h"
#import "ShowLiveHotViewController.h"
#import "ShowLiveNewViewController.h"

@interface ShowScrollerView: UIScrollView
@end

@implementation ShowScrollerView


@end

@interface ShowHomeViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton * navBtnA;
@property (nonatomic, strong) UIButton * navBtnB;
@property (nonatomic, strong) UIButton * navBtnC;
@property (nonatomic, strong) ShowLiveConcernsController * ConcernVC;
@property (nonatomic, strong) ShowLiveHotViewController * HotVC;
@property (nonatomic, strong) ShowLiveNewViewController * NewVC;
@property (nonatomic,strong)ShowScrollerView * bkscrollerView;

@end

@implementation ShowHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor = kthemeBlackColor;
    [self setNavView];
}
- (void)setNavView{
    UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0, KTopHeight + 20, 85*Proportion375 * 3, 43)];
    customView.centerX = kMainScreenWidth/2;
    customView.backgroundColor = kthemeBlackColor;
    [self.view addSubview:customView];
    
    _navBtnA=[UIButton buttonWithType:UIButtonTypeCustom];
    _navBtnA.frame=CGRectMake(0, 0, 85*Proportion375, 43);
    [_navBtnA setTitle:@"关注" forState:UIControlStateNormal];
    [_navBtnA setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
    
    _navBtnB=[UIButton buttonWithType:UIButtonTypeCustom];
    _navBtnB.frame=CGRectMake(85*Proportion375, 0, 85*Proportion375, 43);
    [_navBtnB setTitle:@"热门" forState:UIControlStateNormal];
    [_navBtnB setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
    
    _navBtnC=[UIButton buttonWithType:UIButtonTypeCustom];
    _navBtnC.frame=CGRectMake(85*Proportion375*2, 0, 85*Proportion375, 43);
    [_navBtnC setTitle:@"最新" forState:UIControlStateNormal];
    [_navBtnC setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
    
    [customView addSubview:_navBtnA];
    [customView addSubview:_navBtnB];
    [customView addSubview:_navBtnC];
    
    [self.view addSubview:self.bkscrollerView];
    [self.bkscrollerView addSubview:self.ConcernVC.view];
    [self.bkscrollerView addSubview:self.HotVC.view];
    [self.bkscrollerView addSubview:self.NewVC.view];

}
- (ShowScrollerView *)bkscrollerView{
    if (!_bkscrollerView) {
        _bkscrollerView = [[ShowScrollerView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth, kMainScreenHeight - kNaviBarHeight)];
        _bkscrollerView.contentSize = CGSizeMake(kMainScreenWidth * 3, 0);
        _bkscrollerView.backgroundColor = kThemeWhiteColor;
        if (@available(iOS 11.0, *)) {
            _bkscrollerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_bkscrollerView setContentOffset:CGPointMake(0, 0)];
        _bkscrollerView.bounces=NO;
        _bkscrollerView.pagingEnabled = YES;
        _bkscrollerView.delegate = self;
        _bkscrollerView.showsHorizontalScrollIndicator = YES;
        _bkscrollerView.showsVerticalScrollIndicator = YES;
    }
    return _bkscrollerView;
}
-(ShowLiveConcernsController *)ConcernVC
{
    if (!_ConcernVC) {
        _ConcernVC = [ShowLiveConcernsController initVC];
        _ConcernVC.view.frame = CGRectMake(0, 0, kMainScreenWidth, _bkscrollerView.height);
    }
    return _ConcernVC;
}
-(ShowLiveHotViewController *)HotVC
{
    if (!_HotVC) {
        _HotVC = [ShowLiveHotViewController initVC];
        _HotVC.view.frame = CGRectMake(kMainScreenWidth, 0, kMainScreenWidth, _bkscrollerView.height);
    }
    return _HotVC;
}
-(ShowLiveNewViewController *)NewVC
{
    if (!_NewVC) {
        _NewVC = [ShowLiveNewViewController initVC];
        _NewVC.view.frame = CGRectMake(kMainScreenWidth*2, 0, kMainScreenWidth, _bkscrollerView.height);
    }
    return _NewVC;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
