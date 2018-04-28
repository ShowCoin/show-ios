//
//  ShowHomeViewController.m
//  ShowLive
//
//  Created by Mac on 2018/4/7.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowHomeViewController.h"
#import "ShowHomeBaseController.h"
#import "ShowLoginAction.h"

#import "HomeHeader.h"
#import "ShowReqAction.h"
#import "AccountModel.h"

#import "SLPlayerViewController.h"
#import "SLChatRoomView.h"
#import "AccountModel.h"
#import "SLConfigAction.h"

@interface showModel:BaseModel
@property (nonatomic,strong)NSArray *array;
@end

@implementation showModel
@end

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

@property (nonatomic,strong) ShowAction *action ;
@property (nonatomic,strong) NSMutableArray *actionArray;

@end

@implementation ShowHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor = kThemeWhiteColor;
    [self setNavView];
    self.actionArray = [NSMutableArray arrayWithCapacity:0];
}
- (void)setNavView{
    [self.view addSubview:self.bkscrollerView];
    [self.view addSubview:self.homeheader];
    [self.bkscrollerView addSubview:self.firstVC.view];
    [self.bkscrollerView addSubview:self.secondVC.view];
    [self.bkscrollerView addSubview:self.thirdVC.view];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [self request];
}
- (void)request{

    ShowReqAction * action = [ShowReqAction action];
    action.tid = @"18910026892";
    action.pwd = @"123456";
    action.verify_code = @"000001";
    action.type = @"phone";
    action.modelClass =  AccountModel.self ;
    [self startRequestAction:action Sucess:^(AccountModel * reponseModel) {
        AccountModel *model = [AccountModel shared];
        model.state = UserAccountState_Login;
        [model updateInfo:reponseModel];
        [model save];
        [IMSer connectRongCloud];
    } FaildBlock:^(NSError *error) {
        [HDHud _showMessageInView:self.view title:error.userInfo[@"msg"]];
    }];

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
        _firstVC = [[ShowHomeBaseController alloc]initWithViewCount:HomeViewLines_Two homeViewType:HomeViewType_Concer];
        _firstVC.view.frame = CGRectMake(0, 0, KScreenWidth, _bkscrollerView.height);
    }
    return _firstVC;
}
-(ShowHomeBaseController *)secondVC
{
    if (!_secondVC) {
        _secondVC = [[ShowHomeBaseController alloc] initWithViewCount:HomeViewLines_One homeViewType:HomeViewType_Hot];
        _secondVC.view.frame = CGRectMake(KScreenWidth, 0, KScreenWidth, _bkscrollerView.height);
    }
    return _secondVC;
}
-(ShowHomeBaseController *)thirdVC
{
    if (!_thirdVC) {
        _thirdVC = [[ShowHomeBaseController alloc] initWithViewCount:HomeViewLines_Three homeViewType:HomeViewType_New];
        _thirdVC.view.frame = CGRectMake(KScreenWidth*2, 0, KScreenWidth, _bkscrollerView.height);
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
