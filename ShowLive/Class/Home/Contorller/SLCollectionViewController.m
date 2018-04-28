//
//  SLCollectionViewController.m
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLCollectionViewController.h"

@interface SLCollectionViewController ()

@end

@implementation SLCollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.page =0 ;
    self.perpage = 20;
    self.isRefresh = YES;
    //    self.viewCount = HomeViewLines_Two;
    @weakify(self);
    //监听dataSource刷新tableView
//    self.action = [self createAction];
    [[[[[RACObserve(self, dataSource) distinctUntilChanged] skip:1]deliverOnMainThread]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSArray *dataSource) {
        @strongify(self);
        [self reloadData];
//        NSUInteger totalCount = 0 ;
//        for (NSArray *array in dataSource) {
//            totalCount   += array.count ;
//        }
//        BOOL nomore = (totalCount!=0 && totalCount / 20 !=0 );
        BOOL nomore = (self.page == -1)?YES:NO;
        if([self shouldInfiniteScrolling]){
            self.mainCollectionView.mj_footer.hidden = nomore ;
            if(nomore == NO){
                //   self.mainCollectionView.mj_header = [[UIView alloc]init];
            }else if (nomore){
                //  self.mainCollectionView.tableFooterView = nil ;
            }
        }
    }];
    //请求成功需要将error置为空
    [[[RACObserve(self, error) distinctUntilChanged] skip:1] subscribeNext:^(id x) {
        @strongify(self);
        NSUInteger totalCount = 0 ;
        for (NSArray *array in self.dataSource) {
            totalCount   += array.count ;
        }
        if(x && self.page ==1 && (totalCount ==0)){ //当前页面有error并且是第一页
            self.mainCollectionView.emptyDataSetDelegate = self;
            self.mainCollectionView.emptyDataSetSource = self;
            [self.mainCollectionView reloadEmptyDataSet];
        }else if (!x && self.page ==1){//error变为空，将错误页面清除
            self.mainCollectionView.emptyDataSetDelegate = nil;
            self.mainCollectionView.emptyDataSetSource = nil;
            [self.mainCollectionView reloadEmptyDataSet];
        }else if(x){ //正常的错误提示
            [HDHud showHUDInView:self.view title:self.error.userInfo[@"message"]];
        }
    }];
    
    //下拉刷新统一处理
    if ([self shouldPullToRefresh]) {
        self.mainCollectionView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self)
            self.page = 0;
            self.isRefresh = YES;

            @weakify(self);
            [self requestWithPage:self.page perPage:self.perpage paramters:[self createAction] SuccessBlock:^(id result){
                @strongify(self);
                [self.mainCollectionView.mj_header endRefreshing];
                [self.mainCollectionView.mj_footer endRefreshing];

            } FaildBlock:^(NSError *error) {
                @strongify(self);
                [self.mainCollectionView.mj_header endRefreshing];
            }];
        }];
    }
    //上拉刷新统一处理
    if ([self shouldInfiniteScrolling]) {
        @weakify(self);
        self.mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.isRefresh = NO;
            [self requestWithPage:self.page perPage:self.perpage paramters:[self createAction] SuccessBlock:^(id result) {
//                self.page ++;
                if ([[result objectForKey:@"next_cursor"] integerValue] == -1) {
                    [self.mainCollectionView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.mainCollectionView.mj_footer endRefreshing];
                }
            } FaildBlock:^(NSError *error) {
                [self.mainCollectionView.mj_footer endRefreshing];
            }];
        }];
    }
    if([self refreshWhenViewLoad]){
        [self requestWithPage:self.page perPage:self.perpage paramters:[self createAction] SuccessBlock:^(id result) {
//            self.page ++;
        } FaildBlock:^(NSError *error) {
        }];
    }
    // Do any additional setup after loading the view.
}


- (ShowAction *)action {
    return   nil ;
}

- (BOOL)refreshWhenViewLoad{
    return YES ;
}

- (BOOL)shouldInfiniteScrolling{
    return YES;
}
- (BOOL)shouldPullToRefresh{
    return YES;
}

- (void)reloadData{
    [self.mainCollectionView reloadData];
}

- (void)dealloc {
    self.mainCollectionView.dataSource = nil;
    self.mainCollectionView.delegate = nil;
    self.mainCollectionView.emptyDataSetDelegate = nil;
    self.mainCollectionView.emptyDataSetSource = nil;
}
#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isError) {
        return  nil;
    }
    return  [[NSAttributedString alloc] initWithString:[self emptyDataDesc] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isError){
        return [super imageForEmptyDataSet:scrollView];;
    }
    return [self emptyDataImage];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.isError) {
        return [super buttonTitleForEmptyDataSet:scrollView forState:state];
    }
    return nil;
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isError) {
        return [super titleForEmptyDataSet:scrollView];;
    }
    return [[NSAttributedString alloc] initWithString:[self emptyDataTitle] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14.f]}];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return [super emptyDataSetShouldDisplay:scrollView] || self.dataSource == nil || !self.dataSource.count;
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    if ([self useDefaultLoadingErrorPage] && !self.shouldPullToRefresh) {
        @weakify(self);
        [self requestWithPage:self.page perPage:self.perpage paramters:[self action] SuccessBlock:^(id result) {
            @strongify(self);
//            self.page ++ ;
        }FaildBlock:nil];
    }else{
        [self.mainCollectionView.mj_header beginRefreshing];
    }
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    if (!self.shouldPullToRefresh) {
        [self requestWithPage:0 perPage:self.perpage paramters:[self action] SuccessBlock:^(id result){
//            self.perpage ++ ;
        }FaildBlock:nil];
    }else{
        [self.mainCollectionView.mj_header beginRefreshing];
    }
}

#pragma mark -数据请求

- (void)requestWithPage:(NSInteger)page perPage:(NSInteger)perpage paramters:(ShowAction *)action SuccessBlock:(ShowActionFinishedBlock)successBlock FaildBlock:(ShowActionFinishedBlock)faildBlock{
    @weakify(self);
    if(!action){
        faildBlock(nil);
        return ;
    }
    [self startRequestAction:action Sucess:^(id result) {
        @strongify(self);
        [self parserModelWithResult:result];
        successBlock(result);
    } FaildBlock:^(NSError *error) {
        [HDHud _showMessageInView:self.view title:error.userInfo[@"msg"]];
    }];
}


- (void)parserModelWithResult:(id)result{
    
}
- (ShowAction *)createAction {
    return   nil ;
}
- (UIImage *)emptyDataImage{
    return nil;
}

-(NSString *)emptyDataTitle{
    return @"暂时没有数据";
}

-(NSString *)emptyDataDesc{
    return @"";
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
