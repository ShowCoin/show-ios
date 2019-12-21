//
//  SLSearchViewController.h
//  ShowLive
//
//  Created by iori_chou on 2019/3/8.
//  Copyright © 2019 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "SLSearchBar.h"
#import "SLFollowUserAction.h"
#import "SLSearchUserAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface SLSearchViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,SLSearchBarDelegate>
{
    BOOL _network;
}

@property (nonatomic,strong)UITableView * TableView;

//图片视图
@property (nonatomic,strong)UIView * SearchBarView;

@property (nonatomic,strong)UIImageView * magnifyingImageView;

@property (nonatomic,strong)SLSearchUserAction * searchUserAction;

@property (nonatomic,strong)SLFollowUserAction * followUserAction;
//搜索框
@property (nonatomic,strong)SLSearchBar * SearchBar;

@property (nonatomic,strong)NSString * keyWord;

//页面参数
@property (nonatomic,strong)NSString * cursor;

@property (nonatomic,strong)NSMutableArray * tableArray;

@property (nonatomic,strong)NSMutableArray * tableModelArray;

@property (nonatomic,strong)NSMutableArray * tableListArray;



@end

NS_ASSUME_NONNULL_END
