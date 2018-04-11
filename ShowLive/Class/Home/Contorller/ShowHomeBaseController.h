//
//  ShowHomeBaseController.h
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,HomeViewLines) {//列样式
    HomeViewLines_One  = 1,
    HomeViewLines_Two  = 2,
    HomeViewLines_Three= 3,
};
typedef NS_ENUM(NSInteger,HomeViewType) {
    HomeViewType_Concer  = 0,//关注
    HomeViewType_Hot  = 1,//热门
    HomeViewType_New  = 2,//推荐
};

@interface ShowHomeBaseController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,assign)HomeViewType viewTag;//类别
@property (nonatomic,assign)HomeViewLines viewCount;//样式
@property (nonatomic,strong)UICollectionView * mainCollectionView;

@end
