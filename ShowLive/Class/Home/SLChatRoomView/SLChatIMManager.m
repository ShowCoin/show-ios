//
//  SLChatIMManager.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatIMManager.h"
#import <RongIMLib/RongIMLib.h>// 融云IM SDK
#import "SLMessageInfo.h"
#import "SLChatRoomMessage.h"
@interface SLChatIMManager()

@property (copy,nonatomic)NSString *chatRoomId;

@property (strong,nonatomic)NSMutableArray * sendErrorArray;
@property (strong,nonatomic)NSMutableArray * messageArray;
@property (strong,nonatomic)NSMutableArray * noSpeakArray;

@property (strong,nonatomic)NSTimer *timer ;
@end

@implementation SLChatIMManager

- (instancetype)initWithchatRoomId:(NSString *)chatRoomId{
    if(self = [super init]){
        self.chatRoomId = chatRoomId;
        [self initDataSource];
        [self registerNotifation];
        [self initTimer];
    }
    return self ;
}

- (void)initDataSource{
    self.sendErrorArray = [NSMutableArray arrayWithCapacity:0];
    self.messageArray = [NSMutableArray arrayWithCapacity:0];
    self.noSpeakArray = [NSMutableArray arrayWithCapacity:0];
}
- (void)registerNotifation{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delegate_ReceivedMessage:) name:@"" object:nil];
}

- (void)delegate_ReceivedMessage:(SLMessageInfo *)messageInfo{
    if (![messageInfo.roomId isEqualToString: self.chatRoomId])
    {
        return;
    }
    if ([messageInfo.objectName isEqualToString:@"RC:TxtMsg"])
    {
        [self addObjectForMessagePool:messageInfo];
    }else if(messageInfo){
        if (messageInfo.type ==1)
        {}else if (messageInfo.type ==2){
            
        }
    }
}
- (void)initTimer {
    
    // 创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.1f
                                                  target:self
                                                selector:@selector(getMessageFromMessagePool:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)getMessageFromMessagePool:(SLMessageInfo *)messageInfo{

}

- (void)addObjectForMessagePool:(SLMessageInfo *)messageInfo{
    if (!messageInfo)
    {
        return;
    }
    if (messageInfo.type>0)
    {
        SLChatRoomMessage *message = [SLChatRoomMessage messageWithContent:messageInfo.messageContent];
        if (message.content == nil)
        {
            return;
        }
        [self.messageArray addObject:message];
    }
    else
    {
        RCTextMessage *message = [RCTextMessage messageWithContent:messageInfo.messageContent];
        /// ios8特殊字符闪退问题
        if (message.content == nil)
        {
            return;
        }
        NSDictionary * userInfo=[NSString dictionaryWithJsonString:messageInfo.messageExtra];

        message.senderUserInfo = [[RCUserInfo alloc] initWithUserId:[userInfo valueForKey:@"id"]  name:[userInfo valueForKey:@"name"] portrait:messageInfo.portraitUri];
        message.extra = messageInfo.messageExtra;
        [self.messageArray addObject:message];
        
    }
}
#pragma mark - ******************************** NSNotification **********************************


- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil ;
    [[NSNotificationCenter   defaultCenter]removeObserver:self];
}
@end
