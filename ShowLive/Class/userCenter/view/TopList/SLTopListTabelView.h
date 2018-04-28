//
//  SLTopListTabelView.h
//  ShowLive
//
//  Created by VNing on 2018/4/12.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLDefenderListAction.h"
#import "SLUrgeListAction.h"
typedef NS_ENUM(NSInteger,TopListType) {//
    TopListType_Contribution_Day  = 0,//贡献榜
    TopListType_Contribution_Week  = 1,
    TopListType_Contribution_All  = 2,
    TopListType_Encourage_Day  = 3,//激励榜
    TopListType_Encourage_Week  = 4,
    TopListType_Encourage_All  = 5,
};

@interface SLTopListTabelView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * TableView;
@property(nonatomic,assign)TopListType topListType;
@property (nonatomic,strong)SLDefenderListAction *action;
@property (nonatomic,strong)SLUrgeListAction *Urgeaction;

@property (nonatomic,strong)NSString * testStr;
@property (nonatomic,strong)NSString * cursor;
@property (nonatomic,strong)NSString * count;
@property (nonatomic,strong)NSMutableArray  * dataSource;
@property (nonatomic,strong)NSMutableArray  * dataModelList;
@property (nonatomic,strong)UILabel * headLab;
@property (nonatomic,strong)NSString * urgeNum;



@end
