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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationBarView setNavigationColor:NavigationColorBlack];
    self.navigationBarView.hidden = YES;
    self.view.backgroundColor = kBlackWith21;
    self.dataModelList = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.mainCollectionView];
    [self.view addSubview:self.floatView];
//    _nodataLab = [[UILabel alloc] initWithFrame:CGRectMake(0, HeaderHeightWithoutWords + self.wordsHeight + 70*Proportion375, kMainScreenWidth, 17)];

    [self resetParameter];
    [self requestWithMore:NO];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNotificationLogout object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.dataSource removeAllObjects];
        [self.mainCollectionView reloadData];
        self.cursor= @"0";
    }];
    
}

- (UICollectionView*)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowlayout;
        flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.itemSize = CGSizeMake(cellWith, cellWith /10 * 16);
        flowlayout.minimumLineSpacing = 1;
        flowlayout.minimumInteritemSpacing = 1;
//        flowlayout.sectionHeadersPinToVisibleBounds = YES;
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kMainScreenHeight) collectionViewLayout:flowlayout];
        if (!_IsMe) {
            _mainCollectionView.height = kMainScreenHeight;
        }
        if (@available(iOS 11.0, *)) {
            _mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _mainCollectionView.alwaysBounceHorizontal = NO;
        _mainCollectionView.backgroundColor = kBlackWith1e;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.scrollEnabled = YES;
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        [_mainCollectionView registerClass:[ShowHomeMiddleCell class] forCellWithReuseIdentifier:@"ShowHomeMiddleCell"];
        [_mainCollectionView registerClass:[SLUserViewHeader class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        @weakify(self);
//        _mainCollectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//            @strongify(self);
//            [self resetParameter];
//            [self requestWithMore:NO];
//        }];
        _mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self requestWithMore:YES];
        }];
    }
    return _mainCollectionView;
}

- (UIView*)floatView
{
    if (!_floatView) {
        _floatView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, KNaviBarHeight)];
        _floatView.backgroundColor = kNavigationBGColor;
         UIButton * _worksBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _worksBtn.frame = CGRectMake(0, 0, kMainScreenWidth/2, 45*Proportion375);
        _worksBtn.bottom = KNaviBarHeight;
        [_worksBtn setTitle:@"作品" forState:UIControlStateNormal];
        [_worksBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _worksBtn.titleLabel.font = Font_Medium(15*Proportion375);
        [[_worksBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
           
        } ];
        [_floatView addSubview:_worksBtn];
        
        UIButton * _likesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likesBtn.frame = CGRectMake(kMainScreenWidth/2, 0, kMainScreenWidth/2, 45*Proportion375);
        _likesBtn.bottom = KNaviBarHeight;
        [_likesBtn setTitle:@"喜欢" forState:UIControlStateNormal];
        [_likesBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _likesBtn.titleLabel.font = Font_Medium(15*Proportion375);
        [[_likesBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
        }
         ];
        [_floatView addSubview:_likesBtn];
        _floatView.hidden = YES;
    }
    return _floatView;
}

- (SLUserShareView *)shareview {
    if (!_shareview) {
        _shareview = [[SLUserShareView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        _shareview.delegaet = self;
        _shareview.alpha = 0;
    }
    return _shareview;
}

#pragma mark---------collectionDelegates-----------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowHomeMiddleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowHomeMiddleCell" forIndexPath:indexPath];
    SLLiveListModel * model =[self.dataSource objectAtIndex:indexPath.row];
    model.cellType = SLLiveListCellType_Usercenter;
    cell.dataModel = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    if([AccountModel shared].isLiveing){
//        [HDHud showMessageInView:self.view title:@"您正在直播，无法观看其他人的回放"];
//        return ;
//    }
       [HDHud showMessageInView:self.view title:@"敬请期待"];
    
//    [ShowHomeLargeCell pausePlayer];
//
//    @weakify(self);
//    [SLReportManager reportEvent:self.IsMe?kReport_Me:kReport_Others andSubEvent:self.IsMe?kReport_Me_HistoryPlay:kReport_Others_HistoryPlay];
//
//    SLLiveListModel * model =[self.dataSource objectAtIndex:indexPath.row];
//    model.master= self.userModel;
//    
//    [PageMgr pushToReplayRoomControllerWithData:model RefreshBlock:^{
//        @strongify(self);
//        self.cursor = 0;
//        [self requestWithMore:NO];
//        [self.mainCollectionView.mj_header beginRefreshing];
//    } isMe:self.IsMe];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SLUserViewHeader * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"forIndexPath:indexPath];
        headerView.isMe = self.IsMe;
        headerView.userModel = self.userModel;
        headerView.delegate = self;
        headerView.fromController = self.fromController;
        headerView.layer.shadowOpacity =0.1f;
        headerView.layer.shadowRadius = 6;
        headerView.layer.shadowOffset  = CGSizeMake(0, 2);
        CGMutablePathRef squarePath = CGPathCreateMutable();
        //让图形的形状为正方形
        CGPathAddRect(squarePath, NULL, headerView.bounds);
        //设定阴影图形
        headerView.layer.shadowPath = squarePath;
//        headerView.layer.shadowColor = [UIColor redColor].CGColor;
        CGPathRelease(squarePath);

        return headerView;
    }
   return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMainScreenWidth, HeaderHeightWithoutWords + self.wordsHeight + KTopHeight);
}

#pragma mark---------scrollView-----------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > HeaderHeightWithoutWords + _wordsHeight + KTopHeight - KNaviBarHeight) {
        self.floatView.hidden = NO;
    }else{
        self.floatView.hidden = YES;
    }
    
    if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}
#pragma mark---------actions-----------

- (void)walletViewclickAction:(UITapGestureRecognizer *)sender
{
    [PageMgr presentLoginViewController];
}

#pragma mark---------method-----------

- (void)requestWithMore:(BOOL)more
{
    SLHistoryWorksAction * action = [SLHistoryWorksAction action];
    if (!_IsMe) {
        action.uid = _userModel.uid;
    }
    action.cursor = self.cursor;
    action.count = self.count;
    @weakify(self);
    [self startRequestAction:action Sucess:^(id result) {
        @strongify(self);
        self.dataModelList = [SLLiveListModel mj_objectArrayWithKeyValuesArray:[result objectForKey:@"list"]];
        if (more) {
            [self.dataSource addObjectsFromArray:self.dataModelList];
        }else{
            self.dataSource = [NSMutableArray arrayWithArray:self.dataModelList];
        }
        self.cursor = [result objectForKey:@"next_cursor"];
        
        if (more) {
            if (self.cursor.integerValue == -1) {
                [self.mainCollectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.mainCollectionView.mj_footer endRefreshing];
            }
        }else{
            [self.mainCollectionView.mj_header endRefreshing];
            if (self.dataSource.count == 0) {
                self.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 200*Proportion375 + KTabBarHeight, 0);

                UIView * nodataview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 200)];
                nodataview.backgroundColor =kBlackWith1e;
                UILabel * nodataLab =[UILabel labelWithText:@"TA还没有发布过任何作品哦~" textColor:kGrayWith999999 font:Font_Medium(14*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
                nodataLab.frame = CGRectMake(0, 90*Proportion375, kMainScreenWidth, 20*Proportion375);
                [nodataview addSubview:nodataLab];
                [self.mainCollectionView.mj_footer addSubview:nodataview];
            }
        }
        
        [self.mainCollectionView reloadData];
    } FaildBlock:^(NSError *error) {
        
    }];

}
- (void)dealloc{
    
}




@end

