//
//  SLMiniCardView.h
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SLMiniCardButtonType) {
    SLMiniCardButtonType_Report = 0,
    SLMiniCardButtonType_Gag,//禁言
    SLMiniCardButtonType_PullBlack,//拉黑
    SLMiniCardButtonType_Follow,//关注
    SLMiniCardButtonType_Message,//私信
    SLMiniCardButtonType_Home,//跳转个人页
    SLMiniCardButtonType_CancelFollow,//取消关注
    SLMiniCardButtonType_CancelGag,//取消禁言
    SLMiniCardButtonType_CancelPullBlack,//取消拉黑
    SLMiniCardButtonType_KickOut, //踢出
    SLMiniCardButtonType_FieldCotroller,//设置场控
    SLMiniCardButtonType_CancelFieldCotroller,//取消场控
    SLMiniCardButtonType_Openguardian,//开通守护
    SLMiniCardButtonType_AtUser,  //@某人

};

@protocol SLMiniCardViewDelegate <NSObject>

-(void)didSelectedButton:(SLMiniCardButtonType)type;

@end

@interface SLMiniCardView : UIView



//代理
@property(nonatomic, weak)id<SLMiniCardViewDelegate> delegate;
//更新数据
-(void)updateInfo:(ShowUserModel*)userModel;

//创建子视图
-(void)creatChildViewWithUid:(NSString*)uid
                   isManager:(BOOL)isManager;

//展示
-(void)show;

//隐藏
-(void)hide;


-(void)setFollowState:(BOOL)follow;

@end
