//
//  SLCollectionViewController.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"

@interface SLCollectionViewController : BaseViewController

@property (nonatomic,strong)UICollectionView * mainCollectionView;

@property(nonatomic,strong) NSMutableArray *dataSource ;
@property (nonatomic,strong)NSError *error ;

@property (nonatomic,assign)NSInteger page ;
@property (nonatomic,assign)NSInteger perpage ;

@property (nonatomic,strong)ShowAction *action;

@property (nonatomic,assign)BOOL isRefresh ;

@end
