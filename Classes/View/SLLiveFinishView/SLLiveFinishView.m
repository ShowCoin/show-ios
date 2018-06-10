//
//  SLLiveFinishView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveFinishView.h"
#import "SLLiveStopAction.h"
#import "SLLiveStopModel.h"
#import "SLLiveFinishItem.h"
#import "SLHeadPortrait.h"
#import "SLShadowLabel.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SLLiveDelete.h"

@interface SLLiveFinishView ()

@property(nonatomic,strong) UIImageView *bgImageView;
@property(nonatomic,strong) UIVisualEffectView *effectView;
@property(nonatomic,strong) SLShadowLabel     *titleLabel;
@property(nonatomic,strong) SLHeadPortrait *avatarView;
@property(nonatomic,strong) SLShadowLabel     *nickLabel;
@property(nonatomic,strong) NSMutableArray *itemArray;
@property(nonatomic,strong) UIView * line1, *line2;
@property(nonatomic,strong) SLLiveFinishItem * cnyitem;
@property(nonatomic,strong) SLLiveFinishItem * watchesItem;
@property(nonatomic,strong) SLLiveFinishItem * receiveItem;
@property(nonatomic,strong) UILabel * paragraphLabel;
@property(nonatomic,strong) UILabel * rankLabel;

@property(nonatomic,strong) UIButton * deleteButton;
@property(nonatomic,strong) UIButton * shareButton;
@property(nonatomic,strong) UIButton * closeShareButton;
@property(nonatomic,strong) UIImageView * qrcodeImageView;
@property(nonatomic,strong) UIImageView * shareView;
//朋友圈
@property (nonatomic,strong) UIButton * friendBotton;
//微信
@property (nonatomic,strong) UIButton * wechatBotton;
//手机
@property (nonatomic,strong) UIButton * phoneBotton;
@property (nonatomic,copy) NSString * liveid;
@property (nonatomic,strong) SLLiveDelete * action;


@end

@implementation SLLiveFinishView

-(void)dealloc
{
    NSLog(@"[gx] finishView dealloc");
}

-(void)showOnView:(UIView*)view
           reason:(SLLiveFinishType)reason
            model:(SLLiveStartModel*)model
{
    
    _liveid = model.liveId;
    [view addSubview:self];
    [self addAnchorChildView];
    [self addSubview:self.deleteButton];
    [self addSubview:self.shareButton];
    [self addSubview:self.paragraphLabel];
    [self addSubview:self.rankLabel];
    [self addSubview:self.qrcodeImageView];
    [self initData:reason];
    [self requestData:model];
}

-(void)showOnView:(UIView*)view
            model:(SLLiveListModel*)model
{
    SLFinishModel * finishModel = [[SLFinishModel alloc]init];
    finishModel.liked  = [model.liked integerValue];
    finishModel.receive  = [model.receive integerValue];
    finishModel.viewed  = [model.online_users integerValue];
    [self showOnView:view finishModel:finishModel liveModel:model isAnchor:NO];
    
}


@end
