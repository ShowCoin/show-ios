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

@end
