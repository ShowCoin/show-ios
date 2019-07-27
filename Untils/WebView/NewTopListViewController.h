//
//  NewTopListViewController.h
//  ShowLive
//
//  Created by vning on 2019/1/25.
//  Copyright © 2019 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "SLNewTopListAction.h"
#import "NSString+SLMoney.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewTopListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(retain,nonatomic)NSString * uid;
@property(retain,nonatomic)UIView * topNav;
@property(retain,nonatomic)UIView * LineOne;
@property(retain,nonatomic)UIView * LineTwo;
@property(retain,nonatomic)UIView * LineSep;

@property(retain,nonatomic)NSString * site;
@property(retain,nonatomic)NSString * category;
@property(retain,nonatomic)NSString * type;
@property(retain,nonatomic)NSString * cursor;
@property(retain,nonatomic)NSString * count;

@property(nonatomic,strong)UITableView * TableView;
@property(nonatomic,strong)SLNewTopListAction *__nullable action;

@property (nonatomic,strong)NSMutableArray  * dataSource;
@property (nonatomic,strong)NSMutableArray  * dataModelList;


@end

NS_ASSUME_NONNULL_END
