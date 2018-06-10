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




@end
