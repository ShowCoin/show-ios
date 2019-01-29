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
