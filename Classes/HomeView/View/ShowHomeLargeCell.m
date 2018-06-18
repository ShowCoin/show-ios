//
//  ShowHomeLargeCell.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeLargeCell.h"
#import "SLFollowUserAction.h"
#import "SLPlayerViewController+HomePageReuse.h"
#import "HomeHeader.h"
#import "ShowHomeBaseController.h"
#import "SLBottomAimationView.h"

static SLPlayerViewController *lastPlayerVC = nil ;
static SLLiveListModel *lastDataModel = nil ;
static BOOL showPlayerMessage = YES ;

@interface ShowHomeLargeCell ()

@end

@implementation ShowHomeLargeCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self.contentView addSubview:self.coverImage];
        self.otherContentView.userInteractionEnabled = NO;
        [self.contentView addSubview:self.otherContentView];
        [self.headPortrait addSubview:self.addBtn];
        [self.otherContentView addSubview:self.headPortrait];
        [self.otherContentView addSubview:self.coinView];
        [self.otherContentView addSubview:self.thumbBtn];
        [self.otherContentView addSubview:self.commentBtn];
        [self.otherContentView addSubview:self.shareBtn];
        [self.otherContentView addSubview:self.peopleText];
        [self.otherContentView addSubview:self.peopleNum];
        [self.otherContentView addSubview:self.nickName];
        [self.otherContentView addSubview:self.liveTitle];
        [self.otherContentView addSubview:self.testLab];
        self.otherContentView.hidden = YES;
        
        [self.otherContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);        }];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.equalTo(@(5));
            make.top.equalTo(@(30));
        }];
        [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 40));
            make.centerX.equalTo(self.headPortrait).with.offset(3);
            make.top.equalTo(self.headPortrait.mas_bottom).with.offset(16);
        }];
        [self.thumbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coinView.mas_bottom).with.offset(20);
            make.centerX.equalTo(self.headPortrait.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.thumbBtn.mas_bottom).with.offset(30);
            make.centerX.equalTo(self.headPortrait.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentBtn.mas_bottom).with.offset(30);
            make.centerX.equalTo(self.headPortrait.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        
        [self.peopleText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-80*Proportion375 - KTabBarHeight);
            make.right.equalTo(self).with.offset(-10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 10*Proportion375));
        }];
        [self.peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.peopleText.mas_top).with.offset(-1*Proportion375);
            make.right.equalTo(self.peopleText.mas_right);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 22*Proportion375));
        }];
        [self.testLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-9 - KTabBarHeight);
            make.left.equalTo(self).with.offset(12);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth/2-20, 20.f));
        }];
        [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-28.f - KTabBarHeight);
            make.left.equalTo(self.testLab);
            make.size.mas_equalTo(CGSizeMake(93, 20.f));
        }];
        [self.liveTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.nickName.mas_top).with.offset(-10);
            make.left.equalTo(self.nickName);
            make.width.equalTo(@(280*Proportion375));
        }];
        
        [self.contentView insertSubview:self.plyerContentView aboveSubview:self.coverImage];
        [self.plyerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.parentVC = (UIViewController*)self.nextResponder.nextResponder.nextResponder;
        [self.parentVC addChildViewController:self.playerVC];
        [self.plyerContentView addSubview:self.playerVC.view];
        [self.playerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.plyerContentView);
        }];
        
        self.headPortrait.hidden = YES ;
        self.coinView.hidden = YES;
        self.thumbBtn.hidden = YES;
        self.shareBtn.hidden = YES;
        self.commentBtn.hidden = YES ;
        self.shareBtn.hidden = YES ;
        self.nickName.hidden = YES ;
        self.liveTitle.hidden = YES ;
        self.nickLabel.hidden = YES;
        self.liveNameLabel.hidden = YES;
        self.lineView.hidden = YES;

        
        [self.otherContentView addSubview:self.nickLabel];
        [self.otherContentView addSubview:self.lineView];
        [self.otherContentView addSubview:self.liveNameLabel];
        [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-23.f- KTabBarHeight);
            make.left.equalTo(self.testLab);
            make.height.equalTo(@20.0f);
            make.width.lessThanOrEqualTo(@93);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nickLabel.mas_right).with.offset(5);
            make.width.equalTo(@1);
            make.height.equalTo(@12);
            make.centerY.equalTo(self.nickLabel);
        }];
        [self.liveNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).with.offset(5);
            make.centerY.equalTo(self.nickLabel);
        }];
        
        [self.otherContentView addSubview:self.showLabel];
        [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-60.f- KTabBarHeight);
            make.right.equalTo(self.otherContentView).with.offset(-11);
        }];
        
        [self.otherContentView addSubview:self.showNumberLabel];
        [self.showNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.showLabel.mas_left).with.offset(-4);
            make.centerY.equalTo(self.showLabel);
            make.height.equalTo(@15);
        }];
        
    }
    return self;
}

