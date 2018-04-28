//
//  SLLiveFinishView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLLiveFinishView.h"
#import "SLLiveStopAction.h"
#import "SLLiveStopModel.h"
#import "SLLiveFinishItem.h"
#import "SLHeadPortrait.h"
@interface SLLiveFinishView ()

@property(nonatomic,strong)UIImageView *    bgImageView;
@property(nonatomic,strong)UIVisualEffectView * effectView;
@property(nonatomic,strong)UILabel     *    titleLabel;
@property(nonatomic,strong)SLHeadPortrait * avatarView;
@property(nonatomic,strong)UILabel     *    nickLabel;
@property(nonatomic,strong)NSMutableArray * itemArray;
@property(nonatomic,strong)UIView * line1,*line2;
@property(nonatomic,strong)SLLiveFinishItem *item;

@end
@implementation SLLiveFinishView

-(void)dealloc
{
    NSLog(@"[gx] finishView dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
    
}

-(void)showOnView:(UIView*)view
           reason:(SLLiveFinishType)reason
            model:(SLLiveStartModel*)model
{
 
    [view addSubview:self];
    [self addAnchorChildView];
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
    [self showOnView:view finishModel:finishModel liveModel:model];
    
}

-(void)showOnView:(UIView*)view
      finishModel:(SLFinishModel*)finishModel
        liveModel:(SLLiveListModel*)liveModel;
{
     [view addSubview:self];
     [self addAnchorChildView];
     [self setFinishModel:finishModel];
     [self setLiveListModel:liveModel];
}

-(void)addAnchorChildView
{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.effectView];
    [self addSubview:self.backButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.avatarView];
    [self addSubview:self.nickLabel];
    [self addSubview:self.line1];
    [self addSubview:self.item];
    [self addSubview:self.line2];
    [self initInfoView];

}
-(void)initInfoView
{

     NSArray *titleArray = @[@"时长",@"观看",@"喜欢"];
     NSArray *colorArray = @[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor]];
     CGFloat width = (kScreenWidth - 100)/3, height = 45;
     CGFloat x = 49, y = CGRectGetMaxY(self.line2.frame) + 20;
    
    for (int i = 0; i < titleArray.count; i ++) {
        
        SLLiveFinishItem *item = [[SLLiveFinishItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        item.title = titleArray[i];
        item.valueColor = colorArray[i];
        [self addSubview:item];
        [self.itemArray addObject:item];
        x += width;
    }
}

-(void)setFinishModel:(SLFinishModel*)model
{
    self.item.value = [NSString stringWithFormat:@"%ld",model.receive];
    
    SLLiveFinishItem *item0 = (SLLiveFinishItem *)self.itemArray[0];
    item0.value = [NSString stringWithFormat:@"%@",model.duration];
    
    SLLiveFinishItem *item1 = (SLLiveFinishItem *)self.itemArray[1];
    item1.value = [NSString stringWithFormat:@"%ld",model.viewed];
    
    SLLiveFinishItem *item2 = (SLLiveFinishItem *)self.itemArray[2];
    item2.value = [NSString stringWithFormat:@"%ld",model.liked];
}

-(void)setLiveListModel:(SLLiveListModel*)model
{
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.master.avatar]];
    
    self.nickLabel.text = [NSString stringWithFormat:@"%@",model.master.nickname];
    [self.nickLabel sizeToFit];
    self.nickLabel.mj_x =  (KScreenWidth/2-self.nickLabel.width/2);
    [self.avatarView setRoundStyle:YES imageUrl:model.master.avatar imageHeight:40 vip:NO attestation:NO];
    self.titleLabel.text = @"直播结束";
}

-(void)initData:(SLLiveFinishType)reason
{
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[AccountModel shared].avatar]];
    
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
    self.item.value = [NSString stringWithFormat:@"%ld",model.receive];
    
    SLLiveFinishItem *item0 = (SLLiveFinishItem *)self.itemArray[0];
    item0.value = [NSString stringWithFormat:@"%@",model.duration];

    SLLiveFinishItem *item1 = (SLLiveFinishItem *)self.itemArray[1];
    item1.value = [NSString stringWithFormat:@"%ld",model.viewed];
    
    SLLiveFinishItem *item2 = (SLLiveFinishItem *)self.itemArray[2];
    item2.value = [NSString stringWithFormat:@"%ld",model.liked];
    
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

-(UIImageView*)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        
    }
    return _bgImageView;
}
-(UIVisualEffectView*)effectView
{
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.frame = self.bounds;
      
    }
    return _effectView;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        CGFloat width =KScreenWidth-100, height = 25;
        CGFloat x = 50, y = KNaviBarHeight;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font       = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


-(UILabel*)nickLabel
{
    if (!_nickLabel) {
        CGFloat width= KScreenWidth-100, height = 25;
        CGFloat x =50, y = CGRectGetMaxY(self.avatarView.frame) + 10;
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _nickLabel.textColor = [UIColor whiteColor];
        _nickLabel.font       = [UIFont systemFontOfSize:18];
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
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(50, kScreenHeight/2, KScreenWidth-100, 1)];
        _line1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    return _line1;
}

-(SLLiveFinishItem*)item
{
    if (!_item) {
        _item = [[SLLiveFinishItem alloc] initWithFrame:CGRectMake(KScreenWidth/4, CGRectGetMaxY(self.line1.frame)+20,KScreenWidth/2, 80)];
        _item.title = @"本场秀币收入";
        _item.valueColor =[UIColor whiteColor];
        [_item setValueFont:[UIFont systemFontOfSize:24]];
    }
    return _item;
}

-(UIView*)line2
{
    if (!_line2) {
        _line2 = [[UIView alloc]initWithFrame:CGRectMake(50,CGRectGetMaxY(self.item.frame), KScreenWidth-100, 1)];
        _line2.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    return _line2;
}

-(UIButton*)backButton
{
    if (!_backButton) {
 
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(10,KNaviBarSafeBottomMargin+20,44, 44);
        [_backButton setImage:[UIImage imageNamed:@"live_finish_back"] forState:UIControlStateNormal];

    }
    
    return _backButton;
}



-(NSMutableArray*)itemArray
{
    if(!_itemArray)
    {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}


@end
