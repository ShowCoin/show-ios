//
//  BaseViewController.m
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/3/29.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<ShowNavigationBarDelegate>

//获取需要滑动时隐藏navigation的ScrollerView
@property (weak,nonatomic)UIScrollView *hideNavigationScrollerView;
//错误页面需要展示的scrollerView
@property (strong,nonatomic)UIScrollView *errorReloadView;
//需要收集回调参数的tuple
@property (strong,nonatomic)RACTuple *tuple;

@end

@implementation BaseViewController

+ (instancetype)initVC{
    return [[self alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor =HexRGBAlpha(0xeeeeee, 1);
    // 隐藏系统的navigationBar
    [self.navigationController setNavigationBarHidden:YES];
    // 添加自定义的  navigationBarView
    [self.view addSubview:self.navigationBarView];
    //设置默认的line
    [self.navigationBarView setNavigationLineType:NavigationLineDefault];
    //设置是否需要隐藏navigationBar
    self.navigationBarView.hidden = [self isNeedstatusBarHiddenClasses:NSStringFromClass(self.class)];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HDHud hideHUD];
}

#pragma mark - viewWillAppear

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置切换StatusBar的颜色
    if ([self isNeedStatusBarStyleBlackContent:NSStringFromClass([self class])]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    //设置是否需要隐藏StatusBar
    if ([self isNeedstatusBarHiddenClasses:NSStringFromClass([self class])]) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
}

//在这里添加需要切换为黑色StatusBar的VC
-(NSArray *)statusBarStyleBlackContentClasses{
    return @[@"WithdrawViewController",@"WithdrawAddressViewController",@"ShowAddAddressViewController",@"WalletBuildingController",@"RecoveringWalletController",@"RecoveringKeyWordsController",@"IdentifyKeyWordsController",@"UserCenterViewController",@"ShowLoginViewController",@"ShowSettingViewController",@"ShowForUsViewController",@"UserInfoViewController",@"ChangeheadportraitController",@"ChangeTextController",@"ChangeGenderViewController"];    
}
-(BOOL)isNeedStatusBarStyleBlackContent:(NSString *)className{
    return [[self statusBarStyleBlackContentClasses] containsObject:className];
}


#pragma mark -左右按钮的事件-

//自动处理push 与pop
- (void)popBack{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
        {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)clickLeftButton:(UIButton *)sender{
    [self popBack];
}

- (void)clickRightButton:(UIButton *)sender{
    
}

#pragma mark -是否隐藏navigationbar-

//在这里添加需要隐藏StatusBar的VC
- (NSArray *)statusBarHiddenClasses{
    return @[];
}

-(BOOL)isNeedstatusBarHiddenClasses:(NSString *)className{
    return [[self statusBarHiddenClasses] containsObject:className];
}

#pragma -开启选项-

//是否启用默认的加载错误的页面
- (BOOL)useDefaultLoadingErrorPage{
    return YES ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  懒加载 navigationBar
 */
- (ShowNavigationBar *)navigationBarView
{
    if (!_navigationBarView) {
        _navigationBarView = [ShowNavigationBar createNavigationBar];
        _navigationBarView.delegate = self;
    }
    return _navigationBarView;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float  alpha = scrollView.contentOffset.y/600;
    if (alpha > 1) {
        alpha = 1;
    }
    if (scrollView == self.hideNavigationScrollerView && [self enableHideNavigateWhenScroller]) {
        self.navigationBarView.backgroundColor = kDefaultBackgroundColorAlpha(alpha);
    }
}  


-(void)pushViewController:(BaseViewController *)viewController callBackBlock:(CallbackBlock)callBlock animated:(BOOL)animated{
    if (self.childViewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    viewController.callBackBlock = callBlock;
    [self.navigationController pushViewController:viewController animated:animated];
}

-(void)presentViewController:(BaseViewController *)viewController callBackBlock:(CallbackBlock)callBlock animated:(BOOL)animated completion:(void(^)(void))completion{
    viewController.callBackBlock = callBlock;
    [self presentViewController:viewController animated:animated completion:completion];
}

- (BOOL)enableHideNavigateWhenScroller{
    return NO ;
}
#pragma mark -错误页面展示

#pragma mark - DZNEmptyDataSetDelegate

//是否启用默认的加载错误的页面
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return  -(scrollView.contentInset.top - scrollView.contentInset.bottom) / 2;
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    
}
-(UIScrollView *)errorReloadView{
    if (!_errorReloadView) {
        _errorReloadView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        //_errorReloadView.backgroundColor = [self.resourceService colorForKey:COLOR_KAPPCOLOR];
        _errorReloadView.layer.zPosition = 10;
        _errorReloadView.emptyDataSetSource = self;
        _errorReloadView.emptyDataSetDelegate = self;
    }
    return _errorReloadView;
}

-(void)showErrorLoadingView{
    if (!self.errorReloadView.superview) {
        [self.view addSubview:self.errorReloadView];
        [self.errorReloadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.view);
            make.top.equalTo(self).with.offset(64);
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            self.errorReloadView.alpha = 1;
        }];
    }
    [self.errorReloadView reloadEmptyDataSet];
}

-(void)hideErrorLoadingView{
    @weakify(self);
    if (self.errorReloadView.superview) {
        [UIView animateWithDuration:0.25 animations:^{
            @strongify(self);
            self.errorReloadView.alpha = 0;
        } completion:^(BOOL finished) {
            @strongify(self);
            [self.errorReloadView removeFromSuperview];
        }];
    }
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
