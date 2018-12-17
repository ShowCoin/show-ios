//
//  SLTopListViewController.m
//  ShowLive
//
//  Created by vning on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLTopListViewController.h"
#import "SLToplistSubView.h"

@interface SLTopListViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * bkscrollerView;
@property (nonatomic,strong)SLToplistSubView * contributionView;//贡献榜
@property (nonatomic,strong)SLToplistSubView * encourageView;//激励榜
@end

@implementation SLTopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationColor:NavigationColor1717];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if ([_uid isEqualToString:AccountUserInfoModel.uid]) {
        [SLReportManager reportPageBegin:kReport_MyRankListPage];
    }
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if ([_uid isEqualToString:AccountUserInfoModel.uid]) {
        [SLReportManager reportPageEnd:kReport_MyRankListPage];
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
