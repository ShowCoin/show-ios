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

@end
