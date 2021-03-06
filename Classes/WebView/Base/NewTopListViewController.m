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
- (void)requestWithMore:(BOOL)more
{
   
    if (self.action ) {
        [self.action cancel];
        self.action = nil;
    }
    SLNewTopListAction *action = [SLNewTopListAction action];
    action.uid = self.uid;
    action.site = self.site;
    action.category = self.category;
    action.type = self.type;
    action.cursor = self.cursor;
    action.count = self.count;
    @weakify(self);
    action.finishedBlock = ^(NSDictionary * result)
    {
        @strongify(self);
        self.price = [[result objectForKey:@"object"] objectForKey:@"price"];
        self.show = [[result objectForKey:@"object"] objectForKey:@"show"];
        self.time = [[result objectForKey:@"object"] objectForKey:@"time"];
        
        self.dataModelList = [ShowUserModel mj_objectArrayWithKeyValuesArray:[result objectForKey:@"list"]];
        if (more) {
            [self.dataSource addObjectsFromArray:self.dataModelList];
        }else{
            self.dataSource = [NSMutableArray arrayWithArray:self.dataModelList];
        }

        self.cursor = [result objectForKey:@"cursor"];
        self.count = [result objectForKey:@"count"];
        
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
        if (!more) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.TableView setContentOffset:CGPointZero animated:YES];
            });
        }
    };
    action.failedBlock = ^(NSError *error) {
        [HDHud showMessageInView:self.view title:error.userInfo[@"msg"]];

    };
    action.cancelledBlock = ^{
        
    };
    [action start];

    self.action = action;
}
-(void)resetParameter
{
    self.site = @"1";
    self.category = @"1";
    self.type = @"1";
    self.cursor = @"0";
    self.count = @"20";
}
-(void)resetOthers
{
    self.cursor = @"0";
    self.count = @"20";
}
//uitableView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NewTopListHeader * header = [[NewTopListHeader alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 145*Proportion375)];
    if (self.category.integerValue == 1) {
        header.firstL.text = @"礼物价值";
        header.secL.text = [NSString stringChangeMoneyWithStr:self.price numberStyle:NSNumberFormatterDecimalStyle];
        header.thirdL.text = @"CNY";
        header.fouthL.text = [NSString stringWithFormat:@"合计 %@ SHOW",self.show];

    }else if (self.category.integerValue == 2){
        header.firstL.text = @"获得";
        header.secL.text = [NSString stringChangeMoneyWithStr:self.show numberStyle:NSNumberFormatterDecimalStyle];
        header.thirdL.text = @"SHOW";
        header.fouthL.text = [NSString stringWithFormat:@"合计 %@ CNY",self.price];

    }else if (self.category.integerValue == 3){
        header.firstL.text = @"累计观看";
        header.secL.text = [NSString stringChangeMoneyWithStr:self.time numberStyle:NSNumberFormatterDecimalStyle];
        header.thirdL.text = @"小时";
        header.fouthL.text = [NSString stringWithFormat:@"价值 %@ CNY",self.price];
        header.fouthL.text = [NSString stringWithFormat:@"累计使用 %@ SHOW",self.show];
    }

    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 145*Proportion375;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.category.integerValue == 1) {
        return 146*Proportion375;
    }
    return 161*Proportion375;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"SLTopListGivingCell";
    NewTopListCell * Cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!Cell) {
        Cell = [[NewTopListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == 0) {
        Cell.NumImg.hidden = NO;
        Cell.NumLab.hidden = YES;
        Cell.headPortraitBg.hidden = NO;
        Cell.NumImg.image = [UIImage imageNamed:@"userhome_level_first_tag"];
        [Cell.headPortraitBg setImage:[UIImage imageNamed:@"userhome_level_first_bg"]];
    }else if (indexPath.row == 1){
        Cell.NumImg.hidden = NO;
        Cell.NumLab.hidden = YES;
        Cell.headPortraitBg.hidden = NO;
        Cell.NumImg.image = [UIImage imageNamed:@"userhome_level_second_tag"];
        [Cell.headPortraitBg setImage:[UIImage imageNamed:@"userhome_level_second_bg"]];

    }else if (indexPath.row == 2){
        Cell.NumImg.hidden = NO;
        Cell.NumLab.hidden = YES;
        Cell.headPortraitBg.hidden = NO;
        Cell.NumImg.image = [UIImage imageNamed:@"userhome_level_third_tag"];
        [Cell.headPortraitBg setImage:[UIImage imageNamed:@"userhome_level_third_bg"]];

    }else{
        Cell.NumImg.hidden = YES;
        Cell.NumLab.hidden = NO;
        Cell.headPortraitBg.hidden = YES;
        Cell.NumLab.text = [NSString stringWithFormat:@"NO.%ld",indexPath.row+1];
    }
    [Cell setmodel:[self.dataSource objectAtIndex:indexPath.row] withCellType:self.category.integerValue];
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ShowUserModel * model = [self.dataSource objectAtIndex:indexPath.row];
//    [PageMgr pushToUserCenterControllerWithUid:model.uid];
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    cell.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        cell.alpha = 1;
    }];
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
