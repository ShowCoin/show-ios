//
//  SLFansViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLFansViewController.h"
#import "SLUserListCell.h"
#import "SLFansModel.h"
#import "SLMeFansListAction.h"
#import "SLMeConcernListAction.h"

static NSString * const kNoFansMessage = @"还没有粉丝，完善信息让更多人关注你";
static NSString * const kNoAttentionMessage = @"你还没有关注任何人呦";
static NSString * const kNoNetMessage = @"唔唔唔，没有网了";

@interface SLFansViewController ()<UITableViewDataSource,UITableViewDelegate,SLUserListCellDelegate>
@property (nonatomic,strong)UITableView * TableView;

//页面参数
@property (nonatomic,copy)NSString * cursor;

//dataSource
@property (nonatomic,strong)NSMutableArray * tableArray;

@property (nonatomic,strong)NSMutableArray * tableModelArray;

@property (nonatomic,strong)NSMutableArray * tableListArray;

@property (nonatomic,strong)UIImage * backimage;

@property (nonatomic, assign)BOOL network;

@property (nonatomic, strong) SLMeFansListAction *fansListAction;
@property (nonatomic, strong) SLMeConcernListAction *corcernListAction;

@end

@implementation SLFansViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (_type ==1) {
        if ([self.uid isEqualToString:AccountUserInfoModel.uid]) {
            [SLReportManager reportPageBegin:kReport_MyFansListPage];

        }else{
            [SLReportManager reportPageBegin:kReport_OthersFansListPage];

        }

    }else{
        if ([self.uid isEqualToString:AccountUserInfoModel.uid]) {
            [SLReportManager reportPageBegin:kReport_MyFollowListPage];

        }else{
            [SLReportManager reportPageBegin:kReport_OthersFollowListPage];

        }
    }
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if (_type ==1) {
        if ([self.uid isEqualToString:AccountUserInfoModel.uid]) {
            [SLReportManager reportPageEnd:kReport_MyFansListPage];
        }else{
            [SLReportManager reportPageEnd:kReport_OthersFansListPage];
        }
    }else{
        if ([self.uid isEqualToString:AccountUserInfoModel.uid]) {
            [SLReportManager reportPageEnd:kReport_MyFollowListPage];
            
        }else{
            [SLReportManager reportPageEnd:kReport_OthersFollowListPage];
            
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
