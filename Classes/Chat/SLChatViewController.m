//
//  SLChatViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatViewController.h"
#import "SLChatViewController+BlankView.h"
// Views
#import "SLMessageListCell.h"
#import "SLConvListSystemTableViewCell.h"

static NSString * const TABLEVIEW_CELL_REUSEKEY_CONV = @"TABLEVIEW_CELL_REUSEKEY_CONV";
static NSUInteger const CellAndSectionHeight = 75;  //cell的高度

@interface SLChatViewController ()<UITableViewDataSource,UITableViewDelegate>
/// 当前移动索引
@property (nonatomic, assign) int currentScrollIndex;

@end

@implementation SLChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftDefault];
    [self.navigationBarView setRightIconImage:[UIImage imageNamed:@"chat_userlist"] forState:UIControlStateNormal];
    [self.navigationBarView setNavigationTitle:@"私信"];
    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.view.backgroundColor = kBlackThemeBGColor;
    _dataArray = [NSMutableArray array];
    _searchResultsArray = [NSMutableArray array];
    
    [self setupViews];
    [self addNotifications];

    // Do any additional setup after loading the view.
}
- (void)clickRightButton:(UIButton *)sender;
{
    [PageMgr pushToFriendListViewController];
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
