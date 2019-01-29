//
//  UserCenterViewController.m
//  ShowLive
//
//  Created by vning on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UserCenterViewController.h"
#import "ShowSettingViewController.h"
#import "SLUserInfoViewController.h"
#import "ShowHomeMiddleCell.h"
#import <YYTextLayout.h>
#import "SLGetUserInfoAction.h"
#import "SLHistoryWorksAction.h"
#import "SLLiveListModel.h"
#import "UserInfoViewController.h"
#import "ShowHomeLargeCell.h"

#define cellWith        (KScreenWidth - 2)/3

@interface UserCenterViewController () <SLUserShareViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) CGFloat wordsHeight;
@property (nonatomic, strong) SLGetUserInfoAction *action;
@property (nonatomic, strong) NSString * testStr;
@property (nonatomic, strong) NSString * cursor;
@property (nonatomic, strong) NSString * count;
@property (nonatomic, strong) NSMutableArray  * dataSource;
@property (nonatomic, strong) NSMutableArray  * dataModelList;
//@property (nonatomic,strong)UILabel * nodataLab;
///分享view
@property (nonatomic, strong) SLUserShareView *shareview;

@end

@implementation UserCenterViewController

- (instancetype)initWithIsMe:(BOOL)isme andUserModel:(ShowUserModel *)usermodel
{
    self = [super init];
    if (self) {
        self.IsMe = isme;
        if (_IsMe) {
            NSDictionary * dic =  AccountUserInfoModel.mj_keyValues;
            ShowUserModel * user =[ShowUserModel mj_objectWithKeyValues:dic];
            self.userModel =user;
            [self getUserInfo];
        }else{
            self.userModel = usermodel;
        }
        _wordsHeight = 0;
        [self fitDescriptionsHeight];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getUserInfo];
    if (self.IsMe) {
        [SLReportManager reportPageBegin:kReport_MyHomePage];
    } else {
        [SLReportManager reportPageBegin:kReport_OthersHomePage];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.IsMe) {
        [SLReportManager reportPageEnd:kReport_MyHomePage];
    } else {
        [SLReportManager reportPageEnd:kReport_OthersHomePage];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [PageMgr setRootScrollEnabled:NO];
}

- (void)getUserInfo
{
    self.action = [SLGetUserInfoAction action];
//    self.action.modelClass = AccountModel.self;
    if (!_IsMe) {
        self.action.uid = _userModel.uid;
    }
    @weakify(self);
    self.action.finishedBlock = ^(NSDictionary * dic) {
        @strongify(self);
        if (self.IsMe) {
            AccountModel * reponseModel = [AccountModel mj_objectWithKeyValues:dic];
            AccountModel *model = [AccountModel shared];
            reponseModel.token = model.token;
            model.state = UserAccountState_Login;
            [model updateInfo:reponseModel];
            [model save];
            NSLog(@"uid+++:%@",AccountUserInfoModel.uid);
            NSLog(@"avatar+++:%@",AccountUserInfoModel.avatar);
        }
        self.userModel = [ShowUserModel mj_objectWithKeyValues:dic];
        //计算个性签名高度
        [self fitDescriptionsHeight];
        [self.mainCollectionView reloadData];
    };
    self.action.failedBlock = ^(NSError *err) {
        
    };
    [self.action start];

}

- (void)fitDescriptionsHeight
{
    if (IsStrEmpty(self.userModel.descriptions)) {
        self.userModel.descriptions = @"宝宝还没有想到个性的签名";
    }
    self.testStr = self.userModel.descriptions;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 0; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //    设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *strdic = @{NSFontAttributeName:Font_Regular(14*Proportion375), NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                             };
    if (IsStrEmpty(self.testStr)) {
        return;
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.testStr attributes:strdic];
    
    CGSize size = CGSizeMake(kMainScreenWidth-40 *Proportion375, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attributeStr];
    self.wordsHeight = layout.textBoundingSize.height;
    NSLog(@"header height  2    =====     %f",self.wordsHeight);

    if (!self.dataSource.count) {
        [self.tableView setContentSize:CGSizeMake(kMainScreenWidth, HeaderHeightWithoutWords + self.wordsHeight + 100*Proportion375)];
    }
}


@end

