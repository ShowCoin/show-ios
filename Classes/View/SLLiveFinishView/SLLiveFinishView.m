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
//    [self sl_startRequestAction:self.action Sucess:^(id  result) {
//        @strongify(self);
//        [self.deleteButton setTitle:@"已删除" forState:UIControlStateNormal];
//        [self.backButton sendActionsForControlEvents:UIControlEventTouchUpInside];
//    } FaildBlock:^(NSError *error) {
//        self.deleteButton.userInteractionEnabled = YES;
//        [HDHud showMessageInView:self title:@"删除失败"];
//    }];
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
    return _effectView;
}

-(SLShadowLabel*)titleLabel
{
    if (!_titleLabel) {
        CGFloat width =KScreenWidth-100, height = 25;
        CGFloat x = 50, y = KNaviBarHeight;
        _titleLabel = [[SLShadowLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font       = [UIFont boldSystemFontOfSize:22];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

-(SLShadowLabel*)nickLabel
{
    if (!_nickLabel) {
        CGFloat width= KScreenWidth-100, height = 25;
        CGFloat x =50, y = CGRectGetMaxY(self.avatarView.frame) + 10;
        _nickLabel = [[SLShadowLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _nickLabel.textColor = [UIColor whiteColor];
        _nickLabel.font       = [UIFont boldSystemFontOfSize:16];
        _nickLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nickLabel;
}

-(SLHeadPortrait*)avatarView
{
    if (!_avatarView) {
        _avatarView = [[SLHeadPortrait alloc]initWithFrame:CGRectMake(KScreenWidth/2-40,CGRectGetMaxY(self.titleLabel.frame) + 20, 80, 80)];
    }
    return _avatarView;
}

-(UIView*)line1
{
    if (!_line1) {
        
        CGFloat y = (KScreenHeight>667)?330:300;
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(32, y, KScreenWidth-64, 1)];
        _line1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    return _line1;
}

-(SLLiveFinishItem*)cnyitem
{
    if (!_cnyitem) {
        _cnyitem = [[SLLiveFinishItem alloc] initWithFrame:CGRectMake(KScreenWidth/4, CGRectGetMaxY(self.line1.frame)+85,KScreenWidth/2,45)];
        _cnyitem.title = @"CNY";
        _cnyitem.valueColor =[UIColor whiteColor];
        [_cnyitem setTitleFont:[UIFont systemFontOfSize:10]];
        [_cnyitem setValueFont:[UIFont systemFontOfSize:25]];
    }
    return _cnyitem;
}

-(SLLiveFinishItem*)receiveItem
{
    if (!_receiveItem) {
        _receiveItem =[[SLLiveFinishItem alloc] initWithFrame:CGRectMake(32,CGRectGetMaxY(self.line1.frame)+10,KScreenWidth-64,70)];
        [_receiveItem setTitleFont:[UIFont systemFontOfSize:14]];
        [_receiveItem setValueFont:[UIFont systemFontOfSize:45]];
        _receiveItem.title = @"本场直播秀币收入";
        _receiveItem.valueColor = [UIColor whiteColor];
    }
    return _receiveItem;
}

-(UIView*)line2
{
    if (!_line2) {
        _line2 = [[UIView alloc]initWithFrame:CGRectMake(32,CGRectGetMaxY(self.line1.frame)+140, KScreenWidth-64, 1)];
        _line2.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    return _line2;
}

-(UIButton*)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"live_finish_back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

-(UIButton*)closeShareButton
{
    if (!_closeShareButton) {
        
        _closeShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeShareButton.frame = CGRectMake(kMainScreenWidth-75,KNaviBarSafeBottomMargin+40,44, 44);
        [_closeShareButton setImage:[UIImage imageNamed:@"live_shareClose_button"] forState:UIControlStateNormal];
        _closeShareButton.hidden =YES;
        @weakify(self);
        [[_closeShareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self removeShareview];
        }];
    }
    return _closeShareButton;
}


@end
