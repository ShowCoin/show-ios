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
    UILabel * headLab;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        cellheight = 65*Proportion375;
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
        
        headLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15*Proportion375, kMainScreenWidth, 25*Proportion375)];
        headLab.textAlignment = NSTextAlignmentCenter;
        headLab.text = @"94893393829.0";
        headLab.textColor =kthemeBlackColor;
        headLab.font = Font_Medium(16*Proportion375);
        [header addSubview:headLab];
        
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
        return 0;
    }else{
        return 65*Proportion375;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
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
