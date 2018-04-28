//
//  BKChatRoomMessage.h
//  show-ios
//
//  Created by Mac on 18/4/15.
//  Copyright © 2019年 SouYu. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>
/*!
 文本消息的类型名
 */
#define ChatRoomMessageTypeIdentifier @"chatRoomMsg"
@interface ChatRoomMessage : RCMessageContent
/*!
 文本消息的内容
 */
@property(nonatomic, strong) NSString *content;

+ (instancetype)messageWithContent:(NSString *)content;

@end
