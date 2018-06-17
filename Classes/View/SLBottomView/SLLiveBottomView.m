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

@interface SLLiveBottomView () <UICollectionViewDataSource,UICollectionViewDelegate>


@end

@implementation SLLiveBottomView

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

