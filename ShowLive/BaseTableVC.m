//
//  BaseTableVC.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseTableVC.h"
#import "UIScrollView+EmptyDataSet.h"
#import "ShowLoginAction.h"
#import "HDHud.h"
@interface BaseTableVC ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation BaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - self.navigationBarView.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView = tableFooterView;
    
    self.page = 1 ;
    self.perpage = 5 ;
    
    @weakify(self)
   //监听dataSource刷新tableView
    [[[[[RACObserve(self, dataSource) distinctUntilChanged] skip:1]deliverOnMainThread]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSArray *dataSource) {
        @strongify(self);
        [self reloadData];
        NSUInteger totalCount = 0 ;
        for (NSArray *array in dataSource) {
            totalCount   += array.count ;
        }
        BOOL nomore = (totalCount!=0 && totalCount / 10 !=0 );
        if([self shouldInfiniteScrolling]){
            self.tableView.mj_footer.hidden = nomore ;
            if(totalCount == 0){
                self.tableView.tableFooterView = [[UIView alloc]init];
            }else if (nomore){
                self.tableView.tableFooterView = nil ;
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
        self.tableView.emptyDataSetDelegate = self;
        self.tableView.emptyDataSetSource = self;
        [self.tableView reloadEmptyDataSet];
        }else if (!x && self.page ==1){//error变为空，将错误页面清除
        self.tableView.emptyDataSetDelegate = nil;
        self.tableView.emptyDataSetSource = nil;
        [self.tableView reloadEmptyDataSet];
        }else if(x){ //正常的错误提示
        [HDHud showHUDInView:self.view title:self.error.userInfo[@"message"]];
        }
    }];
    
    //上拉刷新统一处理
   if ([self shouldPullToRefresh]) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            self.page = 1;
            @weakify(self);
            [self requestWithPage:self.page perPage:self.perpage paramters:self.paramters SuccessBlock:^(BOOL sucess){
                @strongify(self);
                [self.tableView.mj_header endRefreshing];
            } FaildBlock:^(NSError *error) {
                @strongify(self);
                [self.tableView.mj_header endRefreshing];
            }];
        }];
    }
    //下拉刷新统一处理
    if ([self shouldInfiniteScrolling]) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self requestWithPage:self.page perPage:self.perpage paramters:self.paramters SuccessBlock:^(BOOL sucess) {
                if(sucess){
                    self.page ++;
                }
                [self.tableView.mj_footer endRefreshing];
            } FaildBlock:^(NSError *error) {
                [self.tableView.mj_footer endRefreshing];
            }];
        }];
    }
    if([self shouldRequestWhenViewDidLoad]){
        [self.tableView.mj_header beginRefreshing];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 参数设置

- (BOOL)shouldPullToRefresh{
    return YES ;
}
- (BOOL)shouldInfiniteScrolling{
    return YES ;
}
- (BOOL)shouldRequestWhenViewDidLoad{
    return YES;
}

#pragma mark -数据请求

- (void)requestWithPage:(NSInteger)page perPage:(NSInteger)perpage paramters:(NSDictionary *)paramters SuccessBlock:(void(^)(BOOL sucess))successBlock FaildBlock:(void(^)(NSError *error))faildBlock{
    
    NSMutableDictionary *requestParamters = [NSMutableDictionary dictionaryWithCapacity:0];
    [requestParamters addEntriesFromDictionary:paramters];
    [requestParamters setValue:@(self.page) forKey:@"page"];
    [requestParamters setValue:@(self.perpage) forKey:@"perpage"];

    //例子后期改
    ShowAction *action = [self requestaction];
    action.finishedBlock = ^(id result) {
        successBlock(YES);
        //请求成功
        NSDictionary * response=(NSDictionary *)result;
        if ([response isKindOfClass:[NSDictionary class]])
        {
            [self parseSucessData:response];
            //model转换或其他处理
        }
    };
    action.failedBlock = ^(NSError *error) {
        self.error = error ;
        faildBlock(error);
    };
    [action start];
}

#pragma mark -需要重新定义子类的方法

- (ShowAction *)requestaction{
    return nil ;
}

- (void)parseSucessData:(id)data{
    self.error = nil ;
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count ? self.dataSource.count :1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    id object = self.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
   id object = self.dataSource[indexPath.section][indexPath.row];
    return  [self configureCellHeightWithTableViewCell:cell AtIndexPath:indexPath  withObject:object];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= self.sectionIndexTitles.count) return nil;
    return self.sectionIndexTitles[section];
}

#pragma mark - 后期子类自定义的东西

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

- (CGFloat)configureCellHeightWithTableViewCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath withObject:(id)object{return 0.0f;}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)dealloc {
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    self.tableView.emptyDataSetDelegate = nil;
    self.tableView.emptyDataSetSource = nil;
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
        [self requestWithPage:self.page perPage:self.perpage paramters:self.paramters SuccessBlock:^(BOOL sucess){
            @strongify(self);
            if(sucess){
                self.page ++ ;
            }
        }FaildBlock:nil];
    }else{
        [self.tableView.mj_header beginRefreshing];
    }
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    if (!self.shouldPullToRefresh) {
        [self requestWithPage:1 perPage:self.perpage paramters:self.paramters SuccessBlock:^(BOOL sucess) {
            if(sucess){
                self.perpage ++ ;
            }
        }FaildBlock:nil];
    }else{
        [self.tableView.mj_header beginRefreshing];
    }
}

-(UIImage *)emptyDataImage{
    return nil;
}

-(NSString *)emptyDataTitle{
    return @"暂时没有数据";
}

-(NSString *)emptyDataDesc{
    return @"";
}


@end
