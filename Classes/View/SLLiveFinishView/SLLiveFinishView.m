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
    [self showOn
     
     View:view finishModel:finishModel liveModel:model isAnchor:NO];
    
}

-(void)showOnView:(UIView*)view
      finishModel:(SLFinishModel*)finishModel
        liveModel:(SLLiveListModel*)liveModel
         isAnchor:(BOOL)isAnchor

{
    
    [view addSubview:self];
    [self addAnchorChildView];
    if (isAnchor==YES) {
        [self addSubview:self.deleteButton];
        [self addSubview:self.shareButton];
        [self addSubview:self.paragraphLabel];
        [self addSubview:self.rankLabel];
        [self addSubview:self.qrcodeImageView];
    }
    [self setLiveListModel:liveModel];
    [self setFinishModel:finishModel];
}

-(void)addAnchorChildView
{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.effectView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.avatarView];
    [self addSubview:self.nickLabel];
    [self addSubview:self.line1];
    [self addSubview:self.receiveItem];
    [self addSubview:self.cnyitem];
    [self addSubview:self.line2];
    [self addSubview:self.watchesItem];
    [self addSubview:self.backButton];
    
}

-(void)setPara:(NSString*)para
{
    self.paragraphLabel.text = para;
}

-(void)setRank:(NSString*)rank
         total:(NSString*)total
{
    
    NSString * string = [NSString stringWithFormat:@"第%@/%@",rank,total];
    if (IsStrEmpty(string)) {
        return;
    }
    
     NSMutableAttributedString * mutableAttriStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSDictionary * attris = @{NSForegroundColorAttributeName:[UIColor yellowColor],NSBackgroundColorAttributeName:[UIColor clearColor],NSFontAttributeName: [UIFont boldSystemFontOfSize:30*WScale]};
    [mutableAttriStr setAttributes:attris range:NSMakeRange(0,1)];
    
    
}

@end
