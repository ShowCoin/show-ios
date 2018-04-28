//
//  SLLiveRightView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/25.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLLiveRightView.h"
#import "SLRightMemberView.h"
#import "SLMemberListView.h"
#import "SLCoinView.h"
#import "SLHeadPortrait.h"
#import "SLLiveMemberListAction.h"
#import "SLMiniCardManager.h"
@interface SLLiveRightView()<SLRightMemberViewProtocol>

@property(nonatomic,strong)SLHeadPortrait * avatarView;
@property(nonatomic,strong)SLMemberListView * memberListView;
@property(nonatomic,strong)SLRightMemberView * memberView;
@property(nonatomic,strong)SLCoinView * coinView;
@property(nonatomic,strong)UIButton * watchesButton;
@property(nonatomic,strong)UILabel * idLabel;
@property(nonatomic,strong)SLLiveListModel * model;
@property(nonatomic,strong)UIImageView * followImageView;

@end
@implementation SLLiveRightView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.avatarView];
        [self addSubview:self.memberView];
        [self addSubview:self.coinView];
        [self addSubview:self.watchesButton];
        [self addSubview:self.idLabel];
        
    }
    return self;
    
}

-(void)addObserNotice
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(focusChange:) name:kFollowUserStatusWithUidNotification object:nil];
    
}
-(void)focusChange:(NSNotification*)notice
{
    
    NSDictionary * noticeDic= (NSDictionary*)notice.object;
    NSString * uid=[noticeDic valueForKey:@"uid"];
    NSString * anchorId = [NSString stringWithFormat:@"%@",self.model.master.uid];
    NSInteger type = [[noticeDic valueForKey:@"type"] integerValue];
    if ([uid isEqualToString:anchorId]) {

       self.followImageView.hidden =  (type == 1)?YES:NO;

    }
    
}

-(void)dealloc
{
    NSLog(@"[gx] right view dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
 
}


-(void)showAnchorMinicard
{
    BOOL isManager = (self.controllerType == SLLiveContollerTypeLive)?YES:NO;
    NSString * uid = (self.controllerType == SLLiveContollerTypeLive)?[AccountModel shared].uid:self.model.master.uid;
    [[SLMiniCardManager shareInstance] showMiniCard:uid isManager:isManager];
}

#pragma mark -- memeberView protocal
-(void)selectMember:(SLMemberListModel *)model
{
    BOOL isManager = (self.controllerType == SLLiveContollerTypeLive)?YES:NO;
    [[SLMiniCardManager shareInstance] showMiniCard:model.uid isManager:isManager];
}


-(void)setAvatar:(NSString*)avatar
{
    [self.avatarView setRoundStyle:YES imageUrl:avatar imageHeight:50 vip:NO attestation:NO];
}

-(void)updateWatches:(NSString*)watches
{

    [self.watchesButton setTitle:[NSString stringWithFormat:@"%@人",watches] forState:UIControlStateNormal];
}
//id
-(void)setAnchorId:(NSString*)anchorId
{
    self.idLabel.text = [NSString stringWithFormat:@"%@秀号",anchorId];
}
//秀币
-(void)updateCoin:(NSString*)coin;
{
    [self.coinView updateCoin:coin];
}
//增加秀币
-(void)addCoin:(NSInteger)coin
{
    [self.coinView addCoin:coin];
}
//看播数据
-(void)updateData:(SLLiveListModel *)listModel;
{
    self.model = listModel;
    [self updateCoin:listModel.receive];
    [self setAnchorId:listModel.master.popularNo];
    self.followImageView.hidden = ([listModel.master.isFollowed isEqualToString:@"1"])?YES:NO;
    [self setAvatar:listModel.master.avatar];
    [self updateWatches:listModel.online_users];
}

//拉取成员列表
-(void)getMemberList:(NSString*)roomId
{
    SLLiveMemberListAction * action = [SLLiveMemberListAction action];
    action.roomId = roomId;
    action.cursor = @"0";
    action.count = @"20";
    @weakify(self);
    [self sl_startRequestAction:action Sucess:^(id result) {
        @strongify(self);
        NSArray * array  = [result valueForKey:@"userList"];
        NSArray * userArray = [SLMemberListModel mj_objectArrayWithKeyValuesArray:array];
        [self updateMemberList:userArray];
        
    } FaildBlock:^(NSError *error) {
        
    }];
    
}

//更新成员列表
-(void)updateMemberList:(NSArray*)array
{
    self.memberView.memberArray = array;
    self.memberListView.memberArray = array;
}


-(void)setControllerType:(SLLiveContollerType)controllerType
{
    _controllerType = controllerType;
    
    if (controllerType==SLLiveContollerTypePlayer) {
        [self addSubview:self.followImageView];
        [self addObserNotice];
    }
 
}

-(void)showMemberListView
{
    [self.memberListView show];
}

-(SLHeadPortrait*)avatarView
{
    if (!_avatarView) {
        _avatarView = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(5, 0, 50, 50)];
        [_avatarView removeTap];
        
        UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAnchorMinicard)];
        [_avatarView addGestureRecognizer:tapGesture];
    }
    return _avatarView;
}


-(SLCoinView*)coinView
{
    if (!_coinView) {

        _coinView = [[SLCoinView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.avatarView.frame)+5,60, 40)];
    }
    return _coinView;
}

- (SLRightMemberView*)memberView
{
    if (!_memberView) {
        _memberView= [[SLRightMemberView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.coinView.frame)+5,60,240) style:UITableViewStyleGrouped];
        _memberView.backgroundColor = [UIColor clearColor];
        _memberView.protocol =self;
    }
    return _memberView;
}

-(UIButton*)watchesButton
{
    if (!_watchesButton) {
        _watchesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _watchesButton.frame = CGRectMake(10,CGRectGetMaxY(self.memberView.frame)+5,40,40.f);
        [_watchesButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_watchesButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _watchesButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _watchesButton.layer.cornerRadius = 10;
        _watchesButton.layer.masksToBounds = YES;
        [_watchesButton addTarget:self action:@selector(showMemberListView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _watchesButton;
}

-(UILabel*)idLabel
{
    if (!_idLabel) {
        _idLabel = [[UILabel alloc]initWithFrame:CGRectMake(-41,CGRectGetMaxY(self.watchesButton.frame)+5,96, 20.f)];
        _idLabel.font = [UIFont systemFontOfSize:12];
        _idLabel.textColor = [UIColor whiteColor];
        _idLabel.textAlignment = NSTextAlignmentCenter;
        _idLabel.layer.shadowRadius = 4.0f;
        _idLabel.layer.shadowOpacity = 0.5;
        _idLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        _idLabel.layer.shadowOffset = CGSizeMake(2, 2);
        _idLabel.layer.masksToBounds = NO;

    }
    return _idLabel;
}

-(SLMemberListView*)memberListView
{
    if (!_memberListView) {
        
        _memberListView = [[SLMemberListView alloc]initWithSuperView:self.superview
                                                     animationTravel:0.1
                                                          viewHeight:412+KTabbarSafeBottomMargin];
   
    }
    return _memberListView;
}

-(UIImageView*)followImageView
{
    if (!_followImageView) {
        _followImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 35, 30, 30)];
        _followImageView.image = [UIImage imageNamed:@"sl_live_foucus"];
        _followImageView.userInteractionEnabled =  YES;

        UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(followAnchor)];
        [_followImageView addGestureRecognizer:tapGesture];
    }
    return _followImageView;
}

-(void)followAnchor
{
    
    [[UserManager manager] followUser:self.model.master status:FollowTypeAdd finish:^(FollowType type) {
        
    } error:^(NSError * error) {
        
    }];
}

-(void)setRightViewHide:(BOOL)hide
{
    self.hidden = hide;
}

-(void)disMissMemberListView
{
    [self.memberListView disMiss];
}

@end
