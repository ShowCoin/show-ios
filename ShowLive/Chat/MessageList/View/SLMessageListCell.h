//
//  SLMessageListCell.h
//  ShowLive
//
//  Created by 周华 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <RongIMLib/RongIMLib.h>

/// 是否显示在线状态
#define SLMessageList_Show_Online_Status 0

@interface SLMessageListCell : BaseTableViewCell<HeadPortraitDelegate>
@property(nonatomic,strong)UILabel          * nickNameLabel;    //昵称
@property(nonatomic,strong)UILabel          * contentLabel; //消息内容
@property(nonatomic,strong)UILabel          * timeLabel; //消息时间
@property(nonatomic,strong)UILabel          * unreadLabel; //未读消息数量
@property (nonatomic,strong)UIView          * lineView;
@property (strong, nonatomic) SLHeadPortrait *headPortrait;//用户头像

@property (nonatomic,assign) NSUInteger unreadCount; //未读消息数量
@property (nonatomic,assign) NSTimeInterval msgTime;    //消息时间
@property (nonatomic, copy) void (^avatarTapedBlock)(SLMessageListCell *sendr);//按钮点击事件

@property (nonatomic,copy) void (^longPressBlock)(SLMessageListCell *sender);
@property (nonatomic, copy)RCConversation *cellData;

@end
