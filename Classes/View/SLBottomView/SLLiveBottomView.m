//
//  SLLiveBottomView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveBottomView.h"
#import "SLLiveBottomCollectionViewCell.h"
#import "SLBottomLikeCollectionViewCell.h"
#import "SLVolumeView.h"
#import "SLMusicView.h"
#import "SLShadowLabel.h"
#import "CBAutoScrollLabel.h"
#import "SLLoopView.h"
#import "HomeHeader.h"
#import "SLBottomAimationView.h"
#import "ShowHomeBaseController.h"

static CGFloat kCellWidth60 = 60;
static CGFloat kCellWidth30 = 30;
static CGFloat kCellWidth42 = 42;
static CGFloat kCellMargin  = 8;
static CGFloat kLRMargin    = 15;

@interface SLLiveBottomView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray * cellArray;
@property (nonatomic, strong) UIView * volumeView;
@property (nonatomic, copy)   NSString * shareCount;
@property (nonatomic, strong) SLLoopView *loopView;
@property (nonatomic, strong) UIButton *centerBtn;

@end

@implementation SLLiveBottomView {
    NSString *_nickName;
}

-(void)dealloc
{
    NSLog(@"[gxx] bottom view dealloc");
    [self.loopView endAnimation];
    [self removeNotification];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.loopView];
        [self addSubview:self.collectionView];
        [self.collectionView addSubview:self.volumeView];
        [self.collectionView addSubview:self.centerBtn];
        [self addNotification];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.loopView.frame = CGRectMake(0, 0, w, kSLLoopViewHeight);
    self.volumeView.frame = CGRectMake(0, 0, w, 1);
    CGFloat collectY = h - KTabBarHeight;
    CGFloat collectH = 49;
    self.collectionView.frame = CGRectMake(0, collectY, w, collectH);
    self.centerBtn.bounds = CGRectMake(0, 0, 75.5, 44.5);
    self.centerBtn.center = CGPointMake(w / 2, collectH / 2);
}

@end

