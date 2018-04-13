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
    SLMiniCardButtonType_AtUser   //@某人
};

@interface SLMiniCardView : UIView

//是否是自己
@property (nonatomic,assign)BOOL isMe;

//是否是主播
@property (nonatomic,assign)BOOL isAnchor;

//是否指向主播
@property (nonatomic,assign)BOOL targetAnchor;

//展示
-(void)show;

//隐藏
-(void)hide;

@end
