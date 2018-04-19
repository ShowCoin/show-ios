//
//  SLChatMessageCellConstants.h
//  ShowLive
//
//  Created by 周华 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#ifndef SLChatMessageCellConstants_h
#define SLChatMessageCellConstants_h


#endif /* SLChatMessageCellConstants_h */
// cell 类型个数
static const NSInteger ChatMessageCellTypeCount = 8;
// cell 类型
typedef NS_ENUM(NSInteger, SLChatMessageCellType) {
    SLChatMessageCellTypeBase,          // 占位
    SLChatMessageCellTypeText,          // 文本
    SLChatMessageCellTypeRich,          // 图文
    SLChatMessageCellTypeVoice,         // 声音
    SLChatMessageCellTypeGift,          // 礼物
    SLChatMessageCellTypeNotice,        // 提醒
    SLChatMessageCellTypeDice,          // 骰子
    SLChatMessageCellTypeLocation,      // 位置
};


/**
 cell方向，按照消息发送和接受来表达,send头像在右，received头像在左
 
 - SLChatMessageDirectionSend: 接受消息的类型，头像在左
 - SLChatMessageDirectionReceived: 发送消息的类型，头像在右
 */
typedef NS_ENUM(NSInteger, SLChatMessageDirection) {
    SLChatMessageDirectionSend,
    SLChatMessageDirectionReceived
};

#ifndef _CHAT_USE_YYLABEL
#define _CHAT_USE_YYLABEL

#define CHAT_USE_YYLABEL 0 // yylabe 在ios11 下竖布局有bug，等待作者更新。。。
#endif
