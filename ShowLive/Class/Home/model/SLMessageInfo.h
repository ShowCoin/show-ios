//
//  SLMessageInfo.h
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/4/13.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "BaseModel.h"

@interface SLMessageInfo : BaseModel

// 用户id
@property(nonatomic, strong) NSString *userId;
// 用户名字
@property(nonatomic, strong) NSString *name;
// 用户头像
@property(nonatomic, strong) NSString *portraitUri;
// 消息内容
@property (nonatomic, strong) NSString *messageContent;
// 消息扩展内容 目前该变量只存放消息类型
@property (nonatomic, strong) NSString *messageExtra;
// 消息类型的字符串表示形式
@property (nonatomic, strong) NSString *messageTypeStr;
//消息的类型名
@property(nonatomic, strong) NSString *objectName;
@property(nonatomic, assign) long type;
@property(nonatomic, strong) NSString * roomId;

@property(nonatomic, strong) NSDictionary *data;

@end
