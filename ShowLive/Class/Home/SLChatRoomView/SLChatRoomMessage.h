//
//  BKMessageInfo.h
//  show-ios
//
//  Created by zhangxingong on 18/4/13.
//  Copyright © 2018年 show.one All rights reserved.
//

#import "BaseModel.h"

/*!
 文本消息的类型名
 */
#define ChatRoomMessageTypeIdentifier @"chatRoomMsg"
@interface SLChatRoomMessage : BaseModel

@property(nonatomic, strong) NSString *content;

+ (instancetype)messageWithContent:(NSString *)content;

@end
