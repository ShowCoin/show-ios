//
//  SLToplistSubView.m
//  ShowLive
//
//  Created by vning on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//
#define tagsViewHeight        45*Proportion375

#import "SLToplistSubView.h"
#import "SLTopListTabelView.h"
@interface SLToplistSubView()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * bkscrollerView;
@property (nonatomic, strong) UIButton * dayBtn;
@property (nonatomic, strong) UIButton * weekBtn;
@property (nonatomic, strong) UIButton * allBtn;
@property (nonatomic, strong) UIView * aniLine;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic,strong)SLTopListTabelView * dayTableView;
@property (nonatomic,strong)SLTopListTabelView * weekTableView;
@property (nonatomic,strong)SLTopListTabelView * allTableView;
@end
@implementation SLToplistSubView

+ (instancetype)authViewWithFrame:(CGRect)frame andUid:(NSString *)uid
{
    SLToplistSubView * view = [[SLToplistSubView alloc]initWithFrame:frame uid:uid];
    return view;
}
-(instancetype)initWithFrame:(CGRect)frame uid:(NSString *)uid{
    if (self = [super initWithFrame:frame]) {
        self.uid = uid;
        self.backgroundColor = kBlackWith17;
        [self tagsTopView];
    }
    return self;
}
-(void)setViewType:(TopViewType)viewType
{
    _viewType = viewType;
    [self addSubview:self.bkscrollerView];
    [self.bkscrollerView addSubview:self.dayTableView];
    [self.bkscrollerView addSubview:self.weekTableView];
    [self.bkscrollerView addSubview:self.allTableView];
}
- (UIScrollView *)bkscrollerView{
    if (!_bkscrollerView) {
        _bkscrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45*Proportion375, kMainScreenWidth, kMainScreenHeight - KNaviBarHeight - 45*Proportion375)];
        _bkscrollerView.contentSize = CGSizeMake(kMainScreenWidth * 3, 0);
        _bkscrollerView.backgroundColor = kThemeWhiteColor;
        if (@available(iOS 11.0, *)) {
            _bkscrollerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
//            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _bkscrollerView.bounces=NO;
        _bkscrollerView.pagingEnabled = YES;
        _bkscrollerView.delegate = self;
        _bkscrollerView.showsHorizontalScrollIndicator = YES;
        _bkscrollerView.showsVerticalScrollIndicator = YES;
        [_bkscrollerView setContentOffset:CGPointMake(0, 0) animated:YES];
        _currentPage = 2;
        
    }
    return _bkscrollerView;
}
-(SLTopListTabelView *)dayTableView
{
    if (!_dayTableView) {
        _dayTableView = [[SLTopListTabelView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - KNaviBarHeight - 45*Proportion375)];
        if (_viewType == TopViewType_Contribution) {
            _dayTableView.topListType = TopListType_Contribution_Day;
        }else{
            _dayTableView.topListType = TopListType_Encourage_Day;
        }
        _dayTableView.uid = self.uid;
    }
    return _dayTableView;
}
-(SLTopListTabelView *)weekTableView
{
    if (!_weekTableView) {
        _weekTableView = [[SLTopListTabelView alloc] initWithFrame:CGRectMake(kMainScreenWidth, 0, kMainScreenWidth, kMainScreenHeight - KNaviBarHeight - 45*Proportion375)];

        if (_viewType == TopViewType_Contribution) {
            _weekTableView.topListType = TopListType_Contribution_Week;
        }else{
            _weekTableView.topListType = TopListType_Encourage_Week;
        }
        _weekTableView.uid = self.uid;

    }
    return _weekTableView;
}
-(SLTopListTabelView *)allTableView
{
    if (!_allTableView) {
        _allTableView = [[SLTopListTabelView alloc] initWithFrame:CGRectMake(kMainScreenWidth*2, 0, kMainScreenWidth, kMainScreenHeight - KNaviBarHeight - 45*Proportion375)];
        if (_viewType == TopViewType_Contribution) {
            _allTableView.topListType = TopListType_Contribution_All;
        }else{
            _allTableView.topListType = TopListType_Encourage_All;
        }
        _allTableView.uid = self.uid;
    }
    return _allTableView;
}
-(void)tagsTopView{
    _dayBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth/3, 45*Proportion375)];
    _dayBtn.titleLabel.font = Font_Regular(16*Proportion375);
    [_dayBtn setTitleColor:kGoldWithNorm forState:UIControlStateNormal];
    [_dayBtn setTitle:@"日榜" forState:UIControlStateNormal];
    [self addSubview:_dayBtn];
    
    _weekBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/3, 0, kMainScreenWidth/3, 45*Proportion375)];
    _weekBtn.titleLabel.font = Font_Regular(16*Proportion375);
    [_weekBtn setTitleColor:kTextWith8b forState:UIControlStateNormal];
    [_weekBtn setTitle:@"周榜" forState:UIControlStateNormal];
    [self addSubview:_weekBtn];
    
    _allBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/3*2, 0, kMainScreenWidth/3, 45*Proportion375)];
    [_allBtn setTitleColor:kTextWith8b forState:UIControlStateNormal];
    _allBtn.titleLabel.font = Font_Regular(16*Proportion375);
    [_allBtn setTitle:@"总榜" forState:UIControlStateNormal];
    [self addSubview:_allBtn];
    
//    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44*Proportion375, kMainScreenWidth, 1*Proportion375)];
//    lineView.backgroundColor = kSeparationColor;
//    [self addSubview:lineView];
    
    _aniLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43*Proportion375, 28*Proportion375, 2*Proportion375)];
    _aniLine.backgroundColor = kGoldWithNorm;
    _aniLine.centerX = _dayBtn.centerX;
    [self addSubview:_aniLine];
    
    @weakify(self);
    [[_dayBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [self.bkscrollerView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }];
    [[_weekBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.bkscrollerView setContentOffset:CGPointMake(kMainScreenWidth , 0) animated:YES];

    }];
    [[_allBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.bkscrollerView setContentOffset:CGPointMake(kMainScreenWidth * 2, 0) animated:YES];
    }];
}

#pragma mark--  scrollviewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( scrollView == _bkscrollerView) {
        int page = 0;
        page = floor((scrollView.contentOffset.x - kMainScreenWidth / 2) / kMainScreenWidth) + 1;
        if (_currentPage == page) {
            return;
        }
        _currentPage = floor((scrollView.contentOffset.x - kMainScreenWidth / 2) / kMainScreenWidth) + 1;
        if (_currentPage == 0) {
            _aniLine.centerX = _dayBtn.centerX;
            [_dayBtn setTitleColor:kGoldWithNorm forState:UIControlStateNormal];
            [_weekBtn setTitleColor:kTextWith8b forState:UIControlStateNormal];
            [_allBtn setTitleColor:kTextWith8b forState:UIControlStateNormal];
        }else if (_currentPage == 1){
            _aniLine.centerX = _weekBtn.centerX;
            [_dayBtn setTitleColor:kTextWith8b forState:UIControlStateNormal];
            [_weekBtn setTitleColor:kGoldWithNorm forState:UIControlStateNormal];
            [_allBtn setTitleColor:kTextWith8b forState:UIControlStateNormal];
            
        }else if (_currentPage == 2){
            _aniLine.centerX = _allBtn.centerX;
            [_dayBtn setTitleColor:kTextWith8b forState:UIControlStateNormal];
            [_weekBtn setTitleColor:kTextWith8b forState:UIControlStateNormal];
            [_allBtn setTitleColor:kGoldWithNorm forState:UIControlStateNormal];
        }
    }
}

@end
