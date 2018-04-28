//
//  BaseViewController.h
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/3/29.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowNavigationBar.h"
#import "UIScrollView+EmptyDataSet.h"

typedef void (^CallbackBlock)(RACTuple *tupe);

@interface BaseViewController : UIViewController<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/**
 *  错误，用于显示空的页面或者错误页面
 */
@property (assign,nonatomic)BOOL  isError;

/**
 *  navigationBar
 */
@property (strong,nonatomic) ShowNavigationBar *navigationBarView;
/**
 *  回调
 */
@property (copy,nonatomic) CallbackBlock callBackBlock;


+ (instancetype)initVC ;


/**
 *  是否使用默认错误reload样式
 *
 *  @return bool
 */
- (BOOL)useDefaultLoadingErrorPage;

//是否启用默认的加载错误的页面
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView ;

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView ;

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView ;

/**
 *  push的方法带回调
 *
 */
-(void)pushViewController:(BaseViewController *)viewController callBackBlock:(CallbackBlock)callBlock animated:(BOOL)animated;

/**
 *  present的方法带回调
 *
 */
-(void)presentViewController:(BaseViewController *)viewController callBackBlock:(CallbackBlock)callBlock animated:(BOOL)animated completion:(void(^)(void))completion;

@property (nonatomic, copy) void (^onNext)(BaseViewController *configController);

@property (nonatomic, copy) void (^onLoad)(BaseViewController *configController);

@end
