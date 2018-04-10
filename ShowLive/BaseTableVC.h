//
//  BaseTableVC.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "ShowAction.h"

@interface BaseTableVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic)UITableView *tableView;
//数据源
@property (strong,nonatomic)NSArray *dataSource;
//请求的标题数组
@property (strong,nonatomic)NSMutableArray *sectionIndexTitles;
//请求的参数
@property (strong,nonatomic)NSDictionary *paramters;

//是否可以下拉刷新
@property (assign,nonatomic) BOOL shouldPullToRefresh ;
//是否可以上拉刷新
@property (assign,nonatomic) BOOL shouldInfiniteScrolling ;
//当前页数
@property (assign,nonatomic) NSInteger page ;
//总共显示的页数
@property (assign,nonatomic) NSInteger perpage;
//请求失败的error
@property (assign,nonatomic)NSError *error;



/**
 该接口为请求列表数据的总结口

 @param page 当前的页数
 @param perpage 单次刷新的最大页数，比如一次10页
 @param paramters 请求的参数
 @param successBlock 成功的回调
 @param faildBlock 失败回调
 */
- (void)requestWithPage:(NSInteger)page perPage:(NSInteger)perpage paramters:(NSDictionary *)paramters SuccessBlock:(void(^)(BOOL sucess))successBlock FaildBlock:(void(^)(NSError *error))faildBlock;

/**
 需要刷新tableView的action请求，为子类开放重写

 @return action请求
 */
- (ShowAction *)requestaction;

/**
 成功拿到数据以后的操作

 @param data 得到的数据
 */
- (void)parseSucessData:(id)data;

@end
