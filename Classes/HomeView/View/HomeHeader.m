//
//  HomeHeader.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "HomeHeader.h"

static BOOL isHot = NO;

@interface HomeHeader ()

@property (nonatomic, strong) UIImageView * grayBg;
@property (nonatomic, strong) UIButton * navBtnA;
@property (nonatomic, strong) UIButton * navBtnB;
@property (nonatomic, strong) UIButton * navBtnC;
@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UIView   * lineView;

@end

@implementation HomeHeader

+ (instancetype)authViewWithFrame:(CGRect)frame
{
    HomeHeader * view = [[HomeHeader alloc]initWithFrame:frame];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupViews{
    [self addSubview:self.grayBg];
    [self addSubview:self.navBtnB];
    [self addSubview:self.navBtnA];
    [self addSubview:self.navBtnC];
    [self addSubview:self.leftBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.rightBtn];
    isHot = YES ;
    
    if (@available(iOS 11.0, *)) {
        NSInteger  count =  [[ShowCIoundIMService sharedManager] getTotalUnreadCount];
        self.rightBtn.hasMessage = (count>0)?YES:NO;
    }
    if (@available(iOS 11.0, *)) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateTotalUnreadCount:) name:kUpdateTotalUnreadCountNotification object:nil];
        
    }
}


@end
