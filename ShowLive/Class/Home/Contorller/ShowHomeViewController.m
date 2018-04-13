//
//  ShowHomeViewController.m
//  ShowLive
//
//  Created by 周华 on 2018/4/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeViewController.h"
#import "ShowHomeBaseController.h"
#import "ShowLoginAction.h"

#import "HomeHeader.h"
#import "ShowReqAction.h"
#import "AccountModel.h"

#import "SLPlayerViewController.h"
@interface ShowScrollerView: UIScrollView

@end

@implementation ShowScrollerView

//-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
//    if (![gestureRecognizer respondsToSelector:@selector(translationInView:)]) {
//        return YES;
//    }
//    CGPoint translation = [gestureRecognizer translationInView:self.superview];
//    CGFloat absX = fabs(translation.x);
//    CGFloat absY = fabs(translation.y);
//    return absX > absY;
//}

@end

@interface ShowHomeViewController ()<UIScrollViewDelegate,HomeHeaderDelegate>
@property (nonatomic, strong) HomeHeader * homeheader;
@property (nonatomic, strong) UIButton * navBtnA;
@property (nonatomic, strong) UIButton * navBtnB;
@property (nonatomic, strong) UIButton * navBtnC;
@property (nonatomic, strong) ShowHomeBaseController * firstVC;
@property (nonatomic, strong) ShowHomeBaseController * secondVC;
@property (nonatomic, strong) ShowHomeBaseController * thirdVC;
@property (nonatomic,strong)ShowScrollerView * bkscrollerView;
@property (nonatomic, assign) NSInteger currentPage;



@end

@implementation ShowHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor = kThemeWhiteColor;
    [self setNavView];
    
//    ShowLoginAction *action = [ShowLoginAction action];
//    action.phone = @"130000000000";
//    action.pwd =@"123456";
//    action.modelClass = [BaseModel class] ;
//    action.finishedBlock = ^(id result) {
//        //请求成功
//        NSDictionary * response=(NSDictionary *)result;
//        if ([response isKindOfClass:[NSDictionary class]])
//        {
//            //model转换或其他处理
//        }
//    };
//    action.failedBlock = ^(NSError *error) {
//
//    };
//    [action start];
    ShowReqAction *action  = [ShowReqAction action];
    action.type = @"phone";
    action.tid = @"13011851573";
    action.pwd = @"198755";
    action.verify_code = @"198755";
    [action startRequestSucess:^(id result) {
        
    } FaildBlock:^(NSError *error) {
        
    }];
    
    AccountModel *model = [AccountModel shared];
    [NSKeyedArchiver  archivedDataWithRootObject:model];
    
}
- (void)setNavView{
    [self.view addSubview:self.bkscrollerView];
    [self.view addSubview:self.homeheader];
    [self.bkscrollerView addSubview:self.firstVC.view];
    [self.bkscrollerView addSubview:self.secondVC.view];
    [self.bkscrollerView addSubview:self.thirdVC.view];
}
-(HomeHeader *)homeheader
{
    if (!_homeheader) {
        _homeheader = [HomeHeader authViewWithFrame:CGRectMake(0, 0, kMainScreenWidth, kNaviBarHeight)];
        _homeheader.delegate = self;
    }
    return _homeheader;
}
- (ShowScrollerView *)bkscrollerView{
    if (!_bkscrollerView) {
        _bkscrollerView = [[ShowScrollerView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        _bkscrollerView.contentSize = CGSizeMake(kMainScreenWidth * 3, 0);
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
        [_bkscrollerView setContentOffset:CGPointMake(kMainScreenWidth, 0) animated:YES];
        _currentPage = 1;
    }
    return _bkscrollerView;
}
-(ShowHomeBaseController *)firstVC
{
    if (!_firstVC) {
        _firstVC = [ShowHomeBaseController initVC];
        _firstVC.view.frame = CGRectMake(0, 0, KScreenWidth, _bkscrollerView.height);
        _firstVC.viewCount = 2;
        _firstVC.viewTag = 1;
    }
    return _firstVC;
}
-(ShowHomeBaseController *)secondVC
{
    if (!_secondVC) {
        _secondVC = [ShowHomeBaseController initVC];
        _secondVC.view.frame = CGRectMake(KScreenWidth, 0, KScreenWidth, _bkscrollerView.height);
        _secondVC.viewCount = 1;
        _secondVC.viewTag = 1;
    }
    return _secondVC;
}
-(ShowHomeBaseController *)thirdVC
{
    if (!_thirdVC) {
        _thirdVC = [ShowHomeBaseController initVC];
        _thirdVC.view.frame = CGRectMake(KScreenWidth*2, 0, KScreenWidth, _bkscrollerView.height);
        _thirdVC.viewCount = 3;
        _thirdVC.viewTag = 1;
    }
    return _thirdVC;
}

#pragma mark--  deledates
-(void)navTabAaction:(UIButton *)sender;
{
    [_bkscrollerView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)navTabBaction:(UIButton *)sender;
{
    [_bkscrollerView setContentOffset:CGPointMake(kMainScreenWidth, 0) animated:YES];
}
-(void)navTabCaction:(UIButton *)sender;
{
    [_bkscrollerView setContentOffset:CGPointMake(kMainScreenWidth*2, 0) animated:YES];
}
-(void)leftBtnClick:(UIButton *)sender;
{
    SLPlayerViewController * playerVc = [[SLPlayerViewController alloc]init];
    playerVc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:playerVc animated:YES];
}
-(void)rightBtnClick:(UIButton *)sender;
{
    [PageMgr pushToChatViewController];
}
#pragma mark--  scrollviewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( scrollView == _bkscrollerView) {
        int page = 0;
        page = floor((scrollView.contentOffset.x - kMainScreenWidth / 2) / kMainScreenWidth) + 1;
        NSLog(@"^^^^^^^^^^^^^%d",page);
        if (_currentPage == page) {
            return;
        }
        _currentPage = floor((scrollView.contentOffset.x - kMainScreenWidth / 2) / kMainScreenWidth) + 1;
        if (_currentPage == HomeViewType_Concer) {
            [_homeheader changePageIndex:0];
        }else if (_currentPage == HomeViewType_Hot){
            [_homeheader changePageIndex:1];
        }else if (_currentPage == HomeViewType_New){
            [_homeheader changePageIndex:2];
        }
    }
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
