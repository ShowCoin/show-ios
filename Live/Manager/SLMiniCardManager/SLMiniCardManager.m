//
//  SLMiniCardManager.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/19.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLMiniCardManager.h"
#import "SLMiniCardView.h"
#import "SLGetUserInfoAction.h"
static SLMiniCardManager *instance = nil;
@interface SLMiniCardManager ()<SLMiniCardViewDelegate>

@property(nonatomic,strong)SLMiniCardView * miniCardView;
@property(nonatomic,assign)BOOL targetIsAnchor;
@property(nonatomic,assign)BOOL isManager;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,strong)ShowAction *action;

@end

@implementation SLMiniCardManager


+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[SLMiniCardManager alloc]init];
    });
    
    return instance;
}

-(SLMiniCardView*)miniCardView
{
    if (!_miniCardView) {
        _miniCardView= [[SLMiniCardView alloc]initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight)];
    }
    return _miniCardView;
}

-(void)showMiniCard:(NSString*)userId
          isManager:(BOOL)isManager
{
    [HDHud hideHUD];
    
    _uid = userId;
    _isManager = isManager;
    
    self.miniCardView.delegate = self;
    [self.miniCardView creatChildViewWithUid:userId isManager:isManager];
    [[UIApplication sharedApplication].keyWindow addSubview:self.miniCardView];
    UITapGestureRecognizer * tapMiniCard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    self.miniCardView.userInteractionEnabled = YES ;
    [self.miniCardView addGestureRecognizer:tapMiniCard];
    [[UIApplication sharedApplication].keyWindow  makeKeyAndVisible];
   [self.miniCardView show];
    
    [self.action cancel];
    self.action  = nil ;
    SLGetUserInfoAction *action = [SLGetUserInfoAction action];
    action.uid = userId;
    action.modelClass = ShowUserModel.self;
    @weakify(self);
    self.action = action ;
    action.finishedBlock = ^(ShowUserModel *model) {
        @strongify(self);
        //更新minicard面板数据
        [self.miniCardView updateInfo:model];
    };
    
    action.failedBlock = ^(NSError *error) {
        @strongify(self);
        [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"请求个人资料失败"];
        [self hide];
    };
    
    [action start];
    
}

-(void)hide
{
    if (!_miniCardView) {
        return;
    }
    [self.miniCardView hide];
}

-(void)didSelectedButton:(SLMiniCardButtonType)type
{
    switch (type) {
        case SLMiniCardButtonType_Report://举报
        {
      
        }
            break;
        case SLMiniCardButtonType_Gag://禁言
        {
   
        }
            break;
        case SLMiniCardButtonType_PullBlack://拉黑
        {
          
        }
            break;
        case SLMiniCardButtonType_Follow://关注
        {
            [self followUser];
        }
            break;
        case SLMiniCardButtonType_Message://私信
        {
        
        }
            break;
        case SLMiniCardButtonType_Home://主页
        {
       
        }
            break;
        case SLMiniCardButtonType_CancelFollow://取消关注
        {
         
        }
            break;
        case SLMiniCardButtonType_CancelGag://取消禁言
        {
          
        }
            break;
        case SLMiniCardButtonType_CancelPullBlack: //取消拉黑
        {
        
        }
            break;
        case SLMiniCardButtonType_KickOut://踢出
        {
           
        }
            break;
        case SLMiniCardButtonType_FieldCotroller://设置场控
        {
   
            
        }
            break;
        case SLMiniCardButtonType_CancelFieldCotroller://取消场控
        {
            
           
            
        }break;
        case SLMiniCardButtonType_Openguardian: //开通守护
        {
          ;
        }
            break;
        case SLMiniCardButtonType_AtUser: //@某人
        {
        
        }
            break;
        default:
            break;
    }
}

-(void)followUser
{
    ShowUserModel * model = [[ShowUserModel alloc]init];
    model.uid = self.uid;
    @weakify(self);
    [[UserManager manager] followUser:model status:FollowTypeAdd finish:^(FollowType type) {
      
        @strongify(self);
        [self.miniCardView setFollowState:YES];
        
    } error:^(NSError * error) {
        
    }];
}


@end
