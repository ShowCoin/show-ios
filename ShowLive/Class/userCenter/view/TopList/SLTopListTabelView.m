//
//  SLTopListTabelView.m
//  ShowLive
//
//  Created by vning on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLTopListTabelView.h"
#import "SLTopListGivingCell.h"
@implementation SLTopListTabelView
{
    CGFloat cellheight;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        cellheight = 65*Proportion375;
        self.dataModelList = [NSMutableArray array];
        self.dataSource = [NSMutableArray array];
        
    }
    return self;
}
-(void)setTopListType:(TopListType)topListType
{
    _topListType = topListType;
    switch (topListType) {
        case TopListType_Contribution_Day:
            self.backgroundColor = [UIColor greenColor];
            break;
        case TopListType_Contribution_Week:
            self.backgroundColor = [UIColor redColor];
            break;
        case TopListType_Contribution_All:
            self.backgroundColor = [UIColor grayColor];
            break;
        case TopListType_Encourage_Day:
            self.backgroundColor = [UIColor blueColor];
            break;
        case TopListType_Encourage_Week:
            self.backgroundColor = [UIColor yellowColor];
            break;
        case TopListType_Encourage_All:
            self.backgroundColor = [UIColor purpleColor];
            break;
        default:
            break;
    }
    [self addSubview:self.TableView];

}
-(void)resetParameter
{
    self.cursor = @"0";
    self.count = @"20";
}
- (void)requestWithMore:(BOOL)more
{
    
    if (_topListType == TopListType_Contribution_Day ||_topListType == TopListType_Contribution_Week ||_topListType == TopListType_Contribution_All) {
        switch (_topListType) {
            case TopListType_Contribution_Day:
                self.action = [SLDefenderListAction action];
                self.action.type = @"2";
                break;
            case TopListType_Contribution_Week:
                self.action = [SLDefenderListAction action];
                self.action.type = @"3";
                break;
            case TopListType_Contribution_All:
                self.action = [SLDefenderListAction action];
                self.action.type = @"1";
                break;
            default:
                break;
        }
        self.action.count = self.count;
        self.action.cursor = self.cursor;
        self.action.uid = AccountUserInfoModel.uid;
        @weakify(self);
        [self sl_startRequestAction:self.action Sucess:^(id result) {
            @strongify(self);
            self.dataModelList = [ShowUserModel mj_objectArrayWithKeyValuesArray:[result objectForKey:@"list"]];
            if (more) {
                [self.dataSource addObjectsFromArray:self.dataModelList];
            }else{
                self.dataSource = [NSMutableArray arrayWithArray:self.dataModelList];
            }
            self.cursor = [result objectForKey:@"next_cursor"];
            if (more) {
                if (self.cursor.integerValue == -1) {
                    [self.TableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.TableView.mj_footer endRefreshing];
                }
            }else{
                [self.TableView.mj_header endRefreshing];
            }
            
            [self.TableView reloadData];
            
        } FaildBlock:^(NSError *error) {
            [self.TableView.mj_header endRefreshing];
            [self.TableView.mj_footer endRefreshing];
            
        }];

    }else{
        
        switch (_topListType) {
            case TopListType_Encourage_Day:
                self.Urgeaction = [SLUrgeListAction action];
                self.Urgeaction.type = @"2";
                break;
            case TopListType_Encourage_Week:
                self.Urgeaction = [SLUrgeListAction action];
                self.Urgeaction.type = @"3";
                break;
            case TopListType_Encourage_All:
                self.Urgeaction = [SLUrgeListAction action];
                self.Urgeaction.type = @"1";
                break;
            default:
                break;
        }
        self.Urgeaction.count = self.count;
        self.Urgeaction.cursor = self.cursor;
        self.Urgeaction.uid = AccountUserInfoModel.uid;
        @weakify(self);
        [self sl_startRequestAction:self.Urgeaction Sucess:^(id result) {
            @strongify(self);
            self.dataModelList = [ShowUserModel mj_objectArrayWithKeyValuesArray:[result objectForKey:@"list"]];
            if (more) {
                [self.dataSource addObjectsFromArray:self.dataModelList];
            }else{
                self.dataSource = [NSMutableArray arrayWithArray:self.dataModelList];
            }
            self.cursor = [result objectForKey:@"next_cursor"];
            self.urgeNum = [NSString stringWithFormat:@"%@",[result objectForKey:@"urge_show_coins"]];
            if (more) {
                if (self.cursor.integerValue == -1) {
                    [self.TableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.TableView.mj_footer endRefreshing];
                }
            }else{
                [self.TableView.mj_header endRefreshing];
            }
                [self.TableView reloadData];

        } FaildBlock:^(NSError *error) {
            [self.TableView.mj_header endRefreshing];
            [self.TableView.mj_footer endRefreshing];
            
        }];
        
    }
    

}
-(UITableView *)TableView
{
    if (!_TableView) {
        _TableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - kNaviBarHeight - 45*Proportion375) style:UITableViewStyleGrouped];
        _TableView.delegate = self;
        _TableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _TableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _TableView.estimatedRowHeight = 0;
            _TableView.estimatedSectionHeaderHeight = 0;
            _TableView.estimatedSectionFooterHeight = 0;
        } else {
        }
        [_TableView registerClass:[SLTopListGivingCell class] forCellReuseIdentifier:@"SLTopListGivingCell"];
        _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        @weakify(self);
        _TableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self resetParameter];
            [self requestWithMore:NO];
        }];
        _TableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self requestWithMore:YES];
        }];
        [_TableView.mj_header beginRefreshing];
    }
    return _TableView;
}

#pragma mark - tableView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_topListType == TopListType_Contribution_Day || _topListType == TopListType_Contribution_Week || _topListType == TopListType_Contribution_All) {
        return nil;

    }else{
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 65*Proportion375)];
        header.backgroundColor = kThemeWhiteColor;
        [header lineDockBottomWithColor:kSeparationColor];
        
        self.headLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15*Proportion375, kMainScreenWidth, 25*Proportion375)];
        self.headLab.textAlignment = NSTextAlignmentCenter;
        self.headLab.textColor =kthemeBlackColor;
        self.headLab.text = self.urgeNum;
        self.headLab.font = Font_Medium(16*Proportion375);
        [header addSubview:self.headLab];
        
        UILabel * showLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 42*Proportion375, kMainScreenWidth, 15*Proportion375)];
        showLab.textAlignment = NSTextAlignmentCenter;
        showLab.text = @"秀币";
        showLab.font = Font_Medium(14*Proportion375);
        showLab.textColor =kGrayBGColor;
        [header addSubview:showLab];
        return header;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (_topListType == TopListType_Contribution_Day || _topListType == TopListType_Contribution_Week || _topListType == TopListType_Contribution_All) {
        return 0.1;
    }else{
        return 65*Proportion375;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        cellheight = 230*Proportion375;

    }else if (indexPath.row == 1 || indexPath.row == 2){
        cellheight = 92*Proportion375;

    }else{
        cellheight = 65*Proportion375;
    }
    return cellheight;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"SLTopListGivingCell";
    SLTopListGivingCell * Cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!Cell) {
        Cell = [[SLTopListGivingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.row == 0) {
        Cell.celltype = CellType_First;
    }else if (indexPath.row == 1 ){
        Cell.celltype = CellType_Second;
    }else if(indexPath.row == 2){
        Cell.celltype = CellType_Second;
    }else{
        Cell.celltype = CellType_Normal;
    }
    Cell.topListType = _topListType;
    Cell.datamodel = [self.dataSource objectAtIndex:indexPath.row];
    Cell.index = indexPath.row;
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    cell.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        cell.alpha = 1;
    }];
}

@end
