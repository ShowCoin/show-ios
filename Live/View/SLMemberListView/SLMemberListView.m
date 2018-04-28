//
//  SLMemberListView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMemberListView.h"
#import "SLMemberListTableViewCell.h"
#import "SLMiniCardManager.h"
@interface SLMemberListView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UIView * headerView;

@property(nonatomic,strong)UILabel * headerLabel;

@property(nonatomic,strong)UIView * lineView;

@end
@implementation SLMemberListView

- (void)dealloc
{
    NSLog(@"[gx] dealloc memberview");
}
// 初始化子视图
- (void)initView
{
    [super initView];
    [self addSubview:self.tableView];

}

#pragma mark -- UI
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.memberArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"SLMemberListTableViewCell";
    
    SLMemberListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SLMemberListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    cell.model = self.memberArray[indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    SLMemberListModel * model = self.memberArray[indexPath.row];
    [[SLMiniCardManager shareInstance] showMiniCard:model.uid isManager:NO];
}

-(UIView*)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 60)];
        [_headerView addSubview:self.headerLabel];
        [_headerView addSubview:self.lineView];
    }
    return _headerView;
}

-(UILabel*)headerLabel
{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]init];
        _headerLabel.frame = CGRectMake(24, 0,KScreenWidth-48, 59.5);
        _headerLabel.textColor = [UIColor blackColor];
        _headerLabel.font = [UIFont systemFontOfSize:18];
        _headerLabel.textAlignment = NSTextAlignmentLeft;
        _headerLabel.text = @"在线用户";
    }
    return _headerLabel;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.frame = CGRectMake(0, 59.5,KScreenWidth, 0.5);
        _lineView.backgroundColor =Color(@"fafafa");
    }
    return _lineView;
}


- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.width,self.height) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor =  Color(@"fafafa");
        _tableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _tableView;
}
-(void)setMemberArray:(NSArray *)memberArray
{
    // NSLog(@"[sortMemeber] gx reload");
    _memberArray = memberArray;
    [self.tableView reloadData];
}

@end
