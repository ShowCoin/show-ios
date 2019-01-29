//
//  NewTopListViewController.m
//  ShowLive
//
//  Created by vning on 2019/1/25.
//  Copyright © 2019 vning. All rights reserved.
//

#import "NewTopListViewController.h"
#import "NewTopListCell.h"
#import "ShowUserModel.h"
#import "NewTopListHeader.h"
@interface NewTopListViewController ()

@property(retain,nonatomic)NSString * price;
@property(retain,nonatomic)NSString * show;
@property(retain,nonatomic)NSString * time;

@end

@implementation NewTopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationColor:NavigationColor1717];
    self.view.backgroundColor = kBlackWith1c;
    self.dataModelList = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    [self configTopviews];
    [self.view addSubview:self.TableView];
}
-(void)setUid:(NSString *)uid
{
    _uid = uid;
    [self resetParameter];
    [self requestWithMore:NO];
}
-(void)configTopviews
{
    @weakify(self)
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"个人" forState:UIControlStateNormal];
    [leftBtn setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
    leftBtn.titleLabel.font = Font_Regular(18*Proportion375);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.navigationBarView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationBarView.mas_centerX).offset(- 35*Proportion375);
        make.centerY.equalTo(self.navigationBarView.middleView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60*Proportion375, 44*Proportion375));
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"全站" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
    rightBtn.titleLabel.font = Font_Regular(18*Proportion375);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.navigationBarView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationBarView.mas_centerX).offset(35*Proportion375);
        make.centerY.equalTo(self.navigationBarView.middleView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60*Proportion375, 44*Proportion375));
    }];
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [leftBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
        [rightBtn setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
        self.site = @"2";
        NSLog(@"site ==%@   type === %@   category === %@",self.site,self.type,self.category);
        [self resetOthers];
        [self requestWithMore:NO];
    }];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [leftBtn setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
        [rightBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
        self.site = @"1";
        [self resetOthers];
        [self requestWithMore:NO];

    }];

    
    UIView * navFloatView =[[UIView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight, kMainScreenWidth, 98*Proportion375)];
    navFloatView.backgroundColor = kBlackWith17;
    [self.view addSubview:navFloatView];
    NSArray * titleArray = @[@"礼物",@"分红",@"时长",@"秀币",@"币天"];
    for (int i = 1; i<6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:[titleArray objectAtIndex:i-1] forState:UIControlStateNormal];
        if (i == 1) {
            [btn setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
            
        }else{
            [btn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];

        }
        btn.titleLabel.font = Font_Regular(16*Proportion375);
        [navFloatView addSubview:btn];
        CGFloat xxx = kMainScreenWidth/5 *(i - 1);
        btn.frame = CGRectMake(xxx, 10*Proportion375, kMainScreenWidth/5, 44*Proportion375);
        [btn addTarget:self action:@selector(chooseTitle:) forControlEvents:UIControlEventTouchUpInside];
    }
    _LineSep = [[UIView alloc] initWithFrame:CGRectMake(0, 53*Proportion375, kMainScreenWidth, 1*Proportion375)];
    _LineSep.backgroundColor = kBlackWith1c;
    [navFloatView addSubview:_LineSep];
    _LineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 52*Proportion375, 26*Proportion375, 2*Proportion375)];
    _LineOne.layer.cornerRadius = 1*Proportion375;
    _LineOne.backgroundColor = kGoldWithPoster;
    _LineOne.centerX = kMainScreenWidth/5/2;
    [navFloatView addSubview:_LineOne];

    UIButton *dayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dayBtn setTitle:@"日榜" forState:UIControlStateNormal];
    [dayBtn setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
    dayBtn.titleLabel.font = Font_Regular(14*Proportion375);
    [navFloatView addSubview:dayBtn];
    dayBtn.frame = CGRectMake(0, 54*Proportion375, kMainScreenWidth/3, 44*Proportion375);
    
    UIButton *weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weekBtn setTitle:@"周榜" forState:UIControlStateNormal];
    [weekBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
    weekBtn.titleLabel.font = Font_Regular(14*Proportion375);
    [navFloatView addSubview:weekBtn];
    weekBtn.frame = CGRectMake(kMainScreenWidth/3, 54*Proportion375, kMainScreenWidth/3, 44*Proportion375);
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allBtn setTitle:@"总榜" forState:UIControlStateNormal];
    [allBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
    allBtn.titleLabel.font = Font_Regular(14*Proportion375);
    [navFloatView addSubview:allBtn];
    allBtn.frame = CGRectMake(kMainScreenWidth/3*2, 54*Proportion375, kMainScreenWidth/3, 44*Proportion375);
    
    _LineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 96*Proportion375, 26*Proportion375, 2*Proportion375)];
    _LineTwo.backgroundColor = kGoldWithPoster;
    _LineTwo.layer.cornerRadius = 1*Proportion375;
    _LineTwo.centerX = dayBtn.centerX;
    [navFloatView addSubview:_LineTwo];
    [[dayBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [dayBtn setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
        [weekBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
        [allBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
        self.type = @"1";
        [self resetOthers];
        [self requestWithMore:NO];
        self.LineTwo.centerX = dayBtn.centerX;
    }];
    [[weekBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [dayBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
        [weekBtn setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
        [allBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
        self.type = @"2";
        [self resetOthers];
        [self requestWithMore:NO];
        self.LineTwo.centerX = weekBtn.centerX;

    }];
    [[allBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [dayBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
        [weekBtn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
        [allBtn setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
        self.type = @"3";
        [self resetOthers];
        [self requestWithMore:NO];
        self.LineTwo.centerX = allBtn.centerX;

    }];
    
}

-(void)chooseTitle:(UIButton *)sender
{
    for (int i = 1; i < 6; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:i];
        [btn setSelected:NO];
        if (!btn.selected) {
            [btn setTitleColor:kGrayTextWithb6 forState:UIControlStateNormal];
        }
    }
    UIButton *button = (UIButton *)sender;
    self.category = [NSString stringWithFormat:@"%ld",(long)button.tag];
    [button setSelected:YES];
    [button setTitleColor:kGoldWithPoster forState:UIControlStateNormal];
    [self resetOthers];
    [self requestWithMore:NO];
    _LineOne.centerX = sender.centerX;
}

-(UITableView *)TableView
{
    if (!_TableView) {
        _TableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 98*Proportion375 + KNaviBarHeight, kMainScreenWidth, kMainScreenHeight - 98*Proportion375 - KNaviBarHeight) style:UITableViewStyleGrouped];
        _TableView.delegate = self;
        _TableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _TableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _TableView.estimatedRowHeight = 0;
            _TableView.estimatedSectionHeaderHeight = 0;
            _TableView.estimatedSectionFooterHeight = 0;
        } else {
        }
        [_TableView registerClass:[NewTopListCell class] forCellReuseIdentifier:@"SLTopListGivingCell"];
        _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _TableView.backgroundColor = kBlackWith17;
        @weakify(self);
        _TableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self resetOthers];
            [self requestWithMore:NO];
        }];
        _TableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self requestWithMore:YES];
        }];
//        [_TableView.mj_header beginRefreshing];
    }
    return _TableView;
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
