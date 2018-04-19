//
//  BKMessageInfo.m
//  ShowLive
//
//  Created by mac on 16/5/27.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import "SLChatRoomMessage.h"

@implementation SLChatRoomMessage
//初始化
+ (instancetype)messageWithContent:(NSString *)content {
    SLChatRoomMessage *text = [[SLChatRoomMessage alloc] init];
    if (text) {
        text.content = content;
    }
    return text;
}

///消息是否存储，是否计入未读数
+ (RCMessagePersistent)persistentFlag {
    return (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED);
}


/// 会话列表中显示的摘要
- (NSString *)conversationDigest {
    return self.content;
}

///消息的类型名
+ (NSString *)getObjectName {
    return ChatRoomMessageTypeIdentifier;
}

@end
