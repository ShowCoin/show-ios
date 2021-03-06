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

-(UIButton *)friendBotton
{
    if (!_friendBotton)
    {
        _friendBotton=[UIButton buttonWithType:UIButtonTypeCustom];
        _friendBotton.frame=CGRectMake(_wechatBotton.right+5, _shareView.bottom-90*Proportion375, 60*WScale, 90*Proportion375);
    }
    return _friendBotton;
}

-(UIButton *)wechatBotton
{
    if (!_wechatBotton)
    {
        _wechatBotton=[UIButton buttonWithType:UIButtonTypeCustom];
        _wechatBotton.frame=CGRectMake(_phoneBotton.right+ 110, _shareView.bottom-90*Proportion375, 60*WScale, 90*Proportion375);
    }
    return _wechatBotton;
}

-(UIButton *)phoneBotton {
    if (!_phoneBotton) {
        _phoneBotton=[UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBotton.frame=CGRectMake(50, _shareView.bottom-90*Proportion375, 60*WScale, 90*Proportion375);
        [_phoneBotton setImage:[UIImage imageNamed:@"live_shareSave_button"] forState:UIControlStateNormal];
        [_phoneBotton setTitle:@"保存至手机" forState:UIControlStateNormal];
        _phoneBotton.titleLabel.font =[UIFont systemFontOfSize:11];
        [_phoneBotton setTitleColor:WhiteColor forState:UIControlStateNormal];
        [_phoneBotton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
        _phoneBotton.hidden = YES;"
    }
    return _phoneBotton;
}

-(NSMutableArray*)itemArray
{
    if(!_itemArray)
    {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

-(UILabel*)paragraphLabel
{
    if(!_paragraphLabel)
    {
        _paragraphLabel = [[UILabel alloc]initWithFrame:CGRectMake(32, CGRectGetMaxY(self.nickLabel.frame)+5, KScreenWidth-64, 60*WScale)];
        _paragraphLabel.layer.shadowRadius = 0.0f;
        _paragraphLabel.layer.shadowOpacity = 1;
        _paragraphLabel.layer.shadowColor = [UIColor whiteColor].CGColor;
        _paragraphLabel.layer.shadowOffset = CGSizeMake(3.3,3.3);
        _paragraphLabel.layer.masksToBounds = NO;
        CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-10 * (CGFloat)M_PI / 180), 1, 0, 0);
        _paragraphLabel.transform = matrix;
        _paragraphLabel.textColor = Color(@"ff004f");
        _paragraphLabel.font = [UIFont boldSystemFontOfSize:60*WScale];
        _paragraphLabel.textAlignment =  NSTextAlignmentCenter;
        
    }
    return _paragraphLabel;
}

-(UILabel*)rankLabel
{
    if (!_rankLabel) {
        _rankLabel =  [[UILabel alloc]initWithFrame:CGRectMake(32, CGRectGetMaxY(self.paragraphLabel.frame), KScreenWidth-64, 40*WScale)];
        _rankLabel.textColor = [UIColor whiteColor];
        _rankLabel.font = Font_Trebuchet(20*WScale);
        _rankLabel.textAlignment =  NSTextAlignmentCenter;
    }
    return _rankLabel;
}

-(UIButton*)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat spacing  = KScreenHeight/2 - CGRectGetMaxY(self.qrcodeImageView.frame)/2;
        CGFloat y   = CGRectGetMaxY(self.qrcodeImageView.frame)+spacing -22.5;
        
        _deleteButton.frame = CGRectMake(32,y,112, 45);
        [_deleteButton setTitle:@"删除回放" forState:UIControlStateNormal];
        [_deleteButton setBackgroundColor:Color(@"333333") forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_deleteButton setTitleColor:Color(@"F1F1F1") forState:UIControlStateNormal];
        _deleteButton.layer.cornerRadius = 22.6;
        _deleteButton.layer.masksToBounds = YES;
        [_deleteButton addTarget:self action:@selector(deleteLive:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

-(UIButton*)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame = CGRectMake(CGRectGetMaxX(self.deleteButton.frame)+15,CGRectGetMinY(self.deleteButton.frame),KScreenWidth-64-112-15,45);
        [_shareButton setTitle:@"分享成就" forState:UIControlStateNormal];
        [_shareButton setBackgroundColor:Color(@"F1F1F1") forState:UIControlStateNormal];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_shareButton setTitleColor:Color(@"333333") forState:UIControlStateNormal];
        _shareButton.layer.cornerRadius = 22.6;
        _shareButton.layer.masksToBounds = YES;
        @weakify(self);
        [[_shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self showScreenshot];
        }];
    }
    return _shareButton;
}

- (UIImageView *)shareView
{
    if (!_shareView) {
        _shareView  = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _shareView;
}

-(UIImageView*)qrcodeImageView
{
    if (!_qrcodeImageView) {
        _qrcodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-40, CGRectGetMaxY(self.line2.frame)+77, 80, 100)];
        _qrcodeImageView.image = [UIImage imageNamed:@"live_finish_qr"];
        
    }
    return _qrcodeImageView;
}
'
@end
