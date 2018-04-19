//
//  SLPrivateChatViewController+MessageReceived.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController+MessageReceived.h"
#import "SLPrivateChatViewController+Business.h"
#import "SLPrivateChatViewController+MessageSend.h"
#import "SLPrivateChatViewController+InputView.h"
@implementation SLPrivateChatViewController (MessageReceived)
- (void)addMessageReceivedObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRongCloudManagerChatInputStatusNotification:) name:kRongCloudManagerDidReceiveChatInputStatusNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRCLibDispatchReadReceiptNotification:) name:RCLibDispatchReadReceiptNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyReceivedConvMsg:) name:kNotify_Received_RongCloud_ConvMsg object:nil];
}

#pragma mark - Notifications

- (void)notifyReceivedConvMsg:(NSNotification *)notification
{
    id objcet = notification.object;
    if (!objcet || ![objcet isKindOfClass:[RCMessage class]]) {
        return;
    }
    
    RCMessage *msg = objcet;
    if (![msg.targetId isEqualToString:self.targetUid]) {
        return;
    }
    [self sendReceivedMessageReadReceiptWithLastSentTime:msg.sentTime];
    
    [self clearMsgSendTimeBuffer];
    [self addNewMessageDataAtEndWithMessageId:msg.messageId];
    if (MessageDirection_RECEIVE == msg.messageDirection) {

    } else if ([msg.content isKindOfClass:[RCRecallNotificationMessage class]]) {
        [self loadMessageData];// 收到测回消息，需要重新加载
    }
}

- (void)didReceiveRongCloudManagerChatInputStatusNotification:(NSNotification *)notification
{
    if (!notification.userInfo) {
        return;
    }
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *targetId = userInfo[@"targetId"];
    if (![self.targetUid isEqualToString:targetId]) {
        return;
    }
    NSArray *userTypeingStatusList = notification.userInfo[@"userTypingStatusList"];
    if (!userTypeingStatusList || !userTypeingStatusList.count) {
        // 停止输入
        self.titleViewChatInputStateString = nil;
        NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];

        
    } else {
        RCUserTypingStatus *status = userTypeingStatusList[0];
        if ([self.targetUid isEqualToString:status.userId]) {
            NSString *messageType = status.contentType;
            if ([messageType isEqualToString:RCTextMessageTypeIdentifier]) {
                self.titleViewChatInputStateString = @"对方正在输入...";
            } else if ([messageType isEqualToString:RCVoiceMessageTypeIdentifier]) {
                self.titleViewChatInputStateString = @"对方正在说话...";
            }
            NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];

        }
    }
}

- (void)didReceiveRCLibDispatchReadReceiptNotification:(NSNotification *)notification
{
    NSString *targetId = [notification.userInfo objectForKey:@"tId"];
    if ([targetId isEqualToString:self.targetUid]) {
        NSNumber *time = [notification.userInfo objectForKey:@"messageTime"];
        [self updateMessageReadStateBeforeLastSentTime:[time longValue]];
    }
}
@end
