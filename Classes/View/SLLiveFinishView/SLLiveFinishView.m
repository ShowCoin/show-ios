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
    
    NSDictionary * attris1 = @{NSForegroundColorAttributeName:[UIColor yellowColor],NSBackgroundColorAttributeName:[UIColor clearColor],NSFontAttributeName: Font_Trebuchet(40*WScale)};
    [mutableAttriStr setAttributes:attris1 range:NSMakeRange(1,rank.length)];
    
    NSDictionary * attris2 = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor clearColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:30*WScale]};
    [mutableAttriStr setAttributes:attris2 range:NSMakeRange(rank.length+1,1)];
    self.rankLabel.attributedText = mutableAttriStr;
}

-(void)setFinishModel:(SLFinishModel*)model
{
    self.cnyitem.value = [NSString stringWithFormat:@"%.2f",model.cny];
    self.watchesItem.value =[NSString stringWithFormat:@"%ld",model.viewed];
    self.receiveItem.value = [NSString stringWithFormat:@"%ld",(long)model.receive];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.gradeTitle];
    [self setPara:[NSString stringWithFormat:@"%@",model.gradeDuan]];
}

-(void)setLiveListModel:(SLLiveListModel*)model
{
//    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.master.large_avatar]];
//
//    self.nickLabel.text = [NSString stringWithFormat:@"%@",model.master.nickname];
//    [self.nickLabel sizeToFit];
//    self.nickLabel.mj_x =  (KScreenWidth/2-self.nickLabel.width/2);
//    [self.avatarView setRoundStyle:YES imageUrl:model.master.avatar imageHeight:40 vip:NO attestation:NO];
//    self.titleLabel.text = @"直播结束";
}

-(void)initData:(SLLiveFinishType)reason
{
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[AccountModel shared].large_avatar]];
    self.nickLabel.text = [NSString stringWithFormat:@"%@",[AccountModel shared].nickname];

    [self.nickLabel sizeToFit];
    self.nickLabel.mj_x =  (KScreenWidth/2-self.nickLabel.width/2);
    [self.avatarView setRoundStyle:YES imageUrl:[AccountModel shared].avatar imageHeight:40 vip:NO attestation:NO];
    
    switch (reason) {
        case SLLiveFinishTypeNormal:
        {
            self.titleLabel.text = @"直播结束";
        }
            break;
        case SLLiveFinishTypeConnectFail:
        {
            self.titleLabel.text = @"断开直播";
        }
            break;
        case SLLiveFinishTypeOperating:
        {
            self.titleLabel.text = @"关闭直播";
        }
            break;
        case SLLiveFinishTypeLiveOpenFail:
        {
            self.titleLabel.text = @"直播失败";
        }
            break;
        default:
            break;
    }
}

-(void)updateValue:(SLLiveStopModel*)model
{
    self.watchesItem.value =[NSString stringWithFormat:@"%ld",model.viewed];
    self.receiveItem.value = [NSString stringWithFormat:@"%ld",(long)model.receive];
    self.cnyitem.value = [NSString stringWithFormat:@"%.2f",model.cny];
    
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.gradeTitle];
    [self setPara:[NSString stringWithFormat:@"%@",model.gradeDuan]];
}

-(void)requestData:(SLLiveStartModel*)model
{
    SLLiveStopAction * action = [SLLiveStopAction action];
    action.liveId = model.liveId;
    action.modelClass = SLLiveStopModel.self;
    @weakify(self);
    [self sl_startRequestAction:action Sucess:^(SLLiveStopModel * model) {
        @strongify(self);
        [self updateValue:model];
    } FaildBlock:^(NSError *error) {
        
    }];
}

-(void)deleteLive:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除本次回放？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteLiveVideo];
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    [self.viewController presentViewController:alert animated:YES completion:nil];
}

- (void)deleteLiveVideo {
    self.deleteButton.userInteractionEnabled = NO;
    NSLog(@"[gx] 删除接口liveid %@",self.liveid);
    if (self.action) {
        [self.action cancel];
        self.action = nil;
    }
    self.action = [SLLiveDelete action];
    self.action.liveId = self.liveid;
    self.action.modelClass = SLLiveStopModel.self;
    @weakify(self);
    [self sl_startRequestAction:self.action Sucess:^(id  result) {
        @strongify(self);
        [self.deleteButton setTitle:@"已删除" forState:UIControlStateNormal];
        [self.backButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    } FaildBlock:^(NSError *error) {
        self.deleteButton.userInteractionEnabled = YES;
        [HDHud showMessageInView:self title:@"删除失败"];
    }];
}

-(UIImageView*)bgImageView
{
//    if (!_bgImageView) {
//        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
//        
//    }
    return _bgImageView;
}

-(UIVisualEffectView*)effectView
{
//    if (!_effectView) {
//        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//        _effectView.frame = self.bounds;
//
//    }
    return _effectView;
}

@end
