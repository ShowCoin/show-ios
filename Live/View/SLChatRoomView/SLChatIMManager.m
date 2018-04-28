
//
//  SLChatIMManager.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatIMManager.h"
#import <RongIMLib/RongIMLib.h>// 融云IM SDK
#import "ShowCIoundIMService.h"
#import "SLCharRoomContentHelp.h"
#import "SLSystemConfigModel.h"
#import "ChatRoomMessage.h"
#import "UserManager.h"
#import "SLLivePlayAction.h"
#import "ChatRoomMessage.h"
#import "SystemMessgae.h"


static SLChatIMManager *imManager;
@interface SLChatIMManager()

//消息队列
@property(nonatomic, strong)NSMutableArray <SLMessageInfo*>*messageQueue;
@property(nonatomic, strong)NSString *lastRichMan;

@end

@implementation SLChatIMManager

- (instancetype)initWithchatRoomParamters:(NSDictionary *)paramters{
    if(self = [super init]){
        imManager  =self ;
        self.paramters = paramters;
        self.chatRoomId = [paramters valueForKey:@"roomId"];
        [self initDataSource];
        [self registerNotifation];
    }
    return self ;
}

- (void)removeLastObjeserver{
    [[NSNotificationCenter defaultCenter]removeObserver:imManager];
}

- (void)initDataSource{
    self.sendErrorArray = [NSMutableArray arrayWithCapacity:0];
    self.messageArray = [NSMutableArray arrayWithCapacity:0];
    self.noSpeakArray = [NSMutableArray arrayWithCapacity:0];
}
- (void)registerNotifation{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delegate_ReceivedMessage:) name:SLLive_kNotification_ChatRoomMessage object:nil];
}

- (void)delegate_ReceivedMessage:(NSNotification  *)info{
    RCMessage *rcMessage = info.object;
    if (![rcMessage.targetId isEqualToString:self.chatRoomId])
    {
        return;
    }

    SLMessageInfo *messageInfo = [self chatRoomMessage:rcMessage];
    
    
    if(messageInfo.type == SLChatRoomMessageTypeRanking){//取出这个人如果下次还是这个人将不再提醒
        if([self.lastRichMan isEqualToString:messageInfo.userId]){
            return ;
        }
        self.lastRichMan = messageInfo.userId;
    };
    //gx 聊天室
    [self dealMessageInMessageQueue:messageInfo];
    
    if (([messageInfo.objectName isEqualToString:@"RC:TxtMsg"]||[messageInfo.objectName isEqualToString:@"chatRoomMsg"]) &&(messageInfo.type != SLChatRoomMessageTypeUserlist)&&(messageInfo.type !=SLChatRoomMessageTypeBeigin))
    {
        [self addObjectForMessagePool:messageInfo];
    }
}

- (void)filter{
    
}

#pragma mark - 消息队列
- (NSMutableArray *)messageQueue {
    if (!_messageQueue)
        _messageQueue = [[NSMutableArray alloc] init];
    return _messageQueue;
}

/* 只有子线程会调用 */
- (void)dealMessageInMessageQueue:(SLMessageInfo *)messageInfo {
    
    if (self.messageQueue.count > 1) {
        //遍历 插入
        @synchronized(self) {
           [self.messageQueue insertObject:messageInfo atIndex:0];
        }
    } else {
        @synchronized(self) {
            [self.messageQueue addObject:messageInfo];
        }
    }
    @weakify(self);
    //直接取0个元素
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SLMessageInfo * firstInfo = nil;
        @strongify(self);
        @synchronized(self) {
           firstInfo = self.messageQueue[0];
           [self.messageQueue removeObjectAtIndex:0];
        }
        [self dealMessage:firstInfo];
    });
}

//给消息分类 发送通知，把消息带出去
- (void)dealMessage:(SLMessageInfo *)firstInfo {
    
    if (!firstInfo) return;
     [[NSNotificationCenter defaultCenter] postNotificationName:KMRongCloudChatRoomNotification object:firstInfo];
    
}
-(SLMessageInfo *)chatRoomMessage:(RCMessage *)message
{

    SLMessageInfo *messageInfo = [[SLMessageInfo alloc] init];
    if([message.content isKindOfClass:[ChatRoomMessage class]])
    {
        ChatRoomMessage *messageIm = (ChatRoomMessage *)message.content;
        NSDictionary * jsonStr=(NSDictionary *)messageIm.content;
        messageInfo.userId = messageIm.senderUserInfo.userId;
        messageInfo.name = messageIm.senderUserInfo.name;
        messageInfo.portraitUri = messageIm.senderUserInfo.portraitUri;
        messageInfo.messageContent = messageIm.content;
        messageInfo.objectName = message.objectName;
        messageInfo.type=[[jsonStr valueForKey:@"type"] longValue];
        messageInfo.roomId=[jsonStr valueForKey:@"roomId"];
        messageInfo.isVip=[jsonStr valueForKey:@"isVip"];
        messageInfo.sentTime = messageInfo.sentTime;
        if (messageInfo.type==8) {
            messageInfo.data=@{@"userList":[jsonStr valueForKey:@"data"]};
        }
        else
        {
            messageInfo.data=[jsonStr valueForKey:@"data"] ;
        }

    }
 
    else
    {
        if (message.conversationType==ConversationType_CHATROOM)
        {
            RCTextMessage *messageIm = (RCTextMessage *)message.content;
            messageInfo.roomId=message.targetId;
            messageInfo.userId = messageIm.senderUserInfo.userId;
            messageInfo.name = messageIm.senderUserInfo.name;
            messageInfo.portraitUri = messageIm.senderUserInfo.portraitUri;
            messageInfo.messageContent = messageIm.content;
            messageInfo.messageExtra=messageIm.extra;
            messageInfo.objectName = message.objectName;
            messageInfo.sentTime = message.sentTime;
        }
    }
    return messageInfo ;

}



- (void)addMessageFromDataSourceWithChatArray:(NSMutableArray *)chatArray{
    [chatArray addObjectsFromArray:self.messageArray];
    [self.messageArray removeAllObjects];
    if(chatArray.count >150){
        NSRange range = NSMakeRange(0, 50);
        [chatArray removeObjectsInRange:range];
    }
}
- (void)addObjectForMessagePool:(SLMessageInfo *)messageInfo{
    if (!messageInfo)
    {
        return;
    }
    SLMessageInfo *info = [SLCharRoomContentHelp contentAttributedString:messageInfo];
    if(info){
    [self.messageArray addObject:info];
    }
}
#pragma mark - ******************************** NSNotification **********************************

//加入聊天室
- (void)joinChatRoom:(NSString *)chatroomId
{
    @weakify(self);
    [[ShowCIoundIMService sharedManager] joinChatRoom:self.chatRoomId messageCount:0 success:^{
        @strongify(self);
        [self loginSucessAction];
    } error:^(RCErrorCode status) {
        @strongify(self);
        if (status== KICKED_FROM_CHATROOM) {
            [[ShowCIoundIMService sharedManager] quitChatRoom:self.chatRoomId success:nil error:nil];
            [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"您已被踢出该房间！暂时无法加入"];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"joinChatRoomError" object:chatroomId];
    }];
}



- (SLMessageInfo *)messageInfoWithType:(NSInteger)type content:(NSString *)inputText{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[AccountModel shared].uid forKey:@"id"];
    [dic setValue:[AccountModel shared].nickname forKey:@"nickName"];
    [dic setValue:[AccountModel shared].avatar forKey:@"avatar"];
    [dic setValue:[AccountModel shared].fanLevel forKey:@"fanLevel"];
    [dic setValue:@(type) forKey:@"type"];
    [dic setValue:[AccountModel shared].isAdmin forKey:@"isAdmin"];
    [dic setValue:[AccountModel shared].is_vip forKey:@"isVip"];
    if(IsStrEmpty(inputText))
    {
        [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"禁止发送空白消息"];
        return nil ;
    }
    SLMessageInfo *messageInfo = [[SLMessageInfo alloc] init];
    messageInfo.userId =[AccountModel shared].uid;
    messageInfo.name = [AccountModel shared].nickname;
    messageInfo.portraitUri = [AccountModel shared].avatar;
    messageInfo.messageContent =inputText;
    messageInfo.messageExtra = [dic mj_JSONString];
//  messageInfo.messageTypeStr = @"";
    messageInfo.type = [[dic valueForKey:@"type"] longValue];
    messageInfo.data = dic ;
    return messageInfo;
    
}

-(void)sendMessage:(NSString *)inputText Type:(NSInteger)type{

    if(!self.chatRoomId){
        [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:inputText];
        return ;
    }
    SLMessageInfo *info = [self messageInfoWithType:type content:inputText];
    if(!info){
        return ;
    }
    @weakify(self);
    [[ShowCIoundIMService sharedManager] sendTextMessageContent:info type:ConversationType_CHATROOM UserId:self.chatRoomId Sucess:^(long Messageld) {
        @strongify(self);
        [self addObjectForMessagePool:info];
    } Error:^(MKErrorCode nErrorCode, long Messageld) {
        @strongify(self);
        if(nErrorCode == ERRORCODE_UNKNOWN || nErrorCode == ERRORCODE_TIMEOUT)
        {//FORBIDDEN_IN_CHATROOM
            // 将发送失败的消息装载到失败队列中
            if (info)
            {
                [self.sendErrorArray addObject:info];
            }
        }
        if (nErrorCode ==FORBIDDEN_IN_CHATROOM) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"您已被禁言‼️"];
            });
        }
        NSLog(@"消息发送失败");
    }];
}

- (void)loginSucessAction{
    
    SLLivePlayAction  *playAction = [SLLivePlayAction action];
    playAction.roomId = [self.paramters valueForKey:@"roomId"];
    playAction.vid = [self.paramters valueForKey:@"vid"];
    playAction.live = [self.paramters valueForKey:@"live"];
    [self sl_startRequestAction:playAction Sucess:^(id result) {

    } FaildBlock:^(NSError *error) {

    }];
}
- (void)dealloc{
    [[NSNotificationCenter   defaultCenter]removeObserver:self];
}
@end
