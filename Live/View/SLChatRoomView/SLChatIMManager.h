//
//  SLChatIMManager.h
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/4/13.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLMessageInfo.h"


@interface SLChatIMManager : NSObject

@property (strong,nonatomic)NSDictionary *paramters;
@property (copy,nonatomic)NSString *chatRoomId;

@property (strong,nonatomic)NSMutableArray * sendErrorArray;
@property (strong,nonatomic)NSMutableArray * messageArray;
@property (strong,nonatomic)NSMutableArray * noSpeakArray;

- (instancetype)initWithchatRoomParamters:(NSDictionary *)paramters;

- (void)joinChatRoom:(NSString *)chatroomId;

- (void)addMessageFromDataSourceWithChatArray:(NSMutableArray *)chatArray;

-(void)sendMessage:(NSString *)inputText Type:(NSInteger)type;

- (void)removeLastObjeserver;
@end
