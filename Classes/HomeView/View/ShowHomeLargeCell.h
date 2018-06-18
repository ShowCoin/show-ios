//
//  ShowHomeLargeCell.h
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLShadowLabel.h"
#import "SLPlayerViewController.h"
#import "SLCoinView.h"

@class ShowHomeLargeCell;

@protocol ShowHomeLargeCellDelegate <NSObject>

- (void)LargeCellConcernActionDelegateWithModel:(SLLiveListModel *)model;

@optional

@end

@interface ShowHomeLargeCell : UICollectionViewCell <HeadPortraitDelegate>

@property (nonatomic, strong) YYAnimatedImageView    * coverImage;
@property (nonatomic, strong) SLHeadPortrait         * headPortrait;
@property (nonatomic, strong) UIButton               * addBtn;
@property (nonatomic, strong) SLCoinView             * coinView;
@property (nonatomic, strong) UIButton               * thumbBtn;
@property (nonatomic, strong) UIButton               * commentBtn;
@property (nonatomic, strong) UIButton               * shareBtn;
@property (nonatomic, strong) UILabel                * thumbLab;
@property (nonatomic, strong) UILabel                * commentLab;
@property (nonatomic, strong) UILabel                * shareLab;

@property (nonatomic, strong) UILabel                * peopleNum;
@property (nonatomic, strong) UILabel                * peopleText;
@property (nonatomic, strong) SLShadowLabel          * nickName;
@property (nonatomic, strong) UILabel                * liveTitle;
@property (nonatomic, strong) SLShadowLabel          * testLab;
@property (nonatomic, strong) SLLiveListModel        * dataModel;
@property (nonatomic, weak) id<ShowHomeLargeCellDelegate> delegate;

@property (nonatomic, strong)UIViewController *parentVC;
@property (nonatomic, strong)SLPlayerViewController *playerVC;
@property (nonatomic, strong)UIView *plyerContentView;
@property (nonatomic, strong)UIView *otherContentView;

@property (nonatomic, strong) SLShadowLabel *nickLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) SLShadowLabel *liveNameLabel;
@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, strong) UILabel *showNumberLabel;

- (void)updateCellState;
+ (void)resetLastPlyerVC;
+ (void)clearPlayer;
+ (void)replayer;
+ (void)pausePlayer;
+ (void)showControllerView:(BOOL)show;
- (void)showCellContentView:(BOOL)show;
+ (void)updateShowHideContent:(BOOL)show;
+ (SLPlayerViewController*)lastplayer;
+ (void)showLargeCellPlayerView;
+(BOOL)showPlayerMessage;
+(void)hidePlayerAllSubViews;

-(void)destructionCell;
@end
