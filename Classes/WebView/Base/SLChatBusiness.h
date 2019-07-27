//
//  SLChatBusiness.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SLRCInputMessageInputStateType) {
    SLRCInputMessageInputStateTypeNone,//没有，即刻 停止
    SLRCInputMessageInputStateTypeVoice,
    SLRCInputMessageInputStateTypeText,
};

typedef void (^RequestCompleteHandle)(BOOL success, id result);
typedef void (^MessageSendSuccessBlock)(long messageId);
typedef void (^MessageSendErrorBlock)(RCErrorCode nErrorCode, long messageId);

@interface SLChatBusiness : NSObject

@property (copy, nonatomic) NSString *targetUid;

/**
 每一页最大的个数
 */
@property (assign, nonatomic) NSInteger eachPageMaxCount;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTargetUid:(NSString *)targetUid eachPageMaxCount:(NSInteger)eachPageMaxCount NS_DESIGNATED_INITIALIZER;
//获取最新的message
- (NSArray<RCMessage*> *)fetchLatestMessages;
//根据oldID获取信息
- (NSArray<RCMessage*> *)fetchMessagesWithOldestMessageId:(long)oldestMessageId;
//根据ID获取信息
- (RCMessage *)getMessageWithMessageId:(long)messageId;
//获取relation信息
- (void)fetchRelationInfo:(RequestCompleteHandle)completeHandle;
//获取用户信息
- (void)fetchUserInfo:(RequestCompleteHandle)completeHandle;

// 消息发送成功的统计
- (void)startMessageSuccessStatisticsAction;

/*******  发送消息 *******/
// 输入状态
- (void)sendInputStateMessageWithType:(SLRCInputMessageInputStateType)type;
// 通用
- (RCMessage *)sendMessageWithMessageContent:(RCMessageContent *)content pushContent:(NSString *)pushContent success:(MessageSendSuccessBlock)successBlock error:(MessageSendErrorBlock)errorBlock;
// 语音
- (RCMessage *)sendVoiceMessageWithVoiceData:(NSData *)voiceData duration:(long)duration success:(MessageSendSuccessBlock)successBlock error:(MessageSendErrorBlock)errorBlock;
// 图片
- (RCMessage *)sendMedioMessageWithMedioData:(UIImage *)MedioData  success:(MessageSendSuccessBlock)successBlock error:(MessageSendErrorBlock)errorBlock;
// 文本
- (RCMessage *)sendTextMessageWithText:(NSString *)text success:(MessageSendSuccessBlock)successBlock error:(MessageSendErrorBlock)errorBlock;
// 已读回执
- (void)sendReadReceiptMessageWithLastSentTime:(long)lastSentTime;
/*******  更新消息 *******/
- (RCMessage *)insertOutgoingMessage:(RCMessageContent *)message;
//设置请求状态根据ID，融云接收的状态
- (BOOL)setMessageReceivedStatusWithMessageId:(long)messageId rcReceivedStatus:(NSUInteger)status;
//根据ID设置消息状态
- (BOOL)setMessageSentStatusWithMessageId:(long)messageId sentStatus:(RCSentStatus)sentStatus;
- (void)checSLessageNetwork;
//更具ID删除消息
- (BOOL)deleteMessageWithId:(long)messageId;
- (void)recallRCMessage:(RCMessage *)rcMessage success:(void (^)(long messageId))successBlock error:(void(^)(RCErrorCode errorcode))errorBlock;

// 草稿箱
- (NSString *)getTextDraft;
- (void)saveTextToDraft:(NSString *)text;

// 未读状态
- (BOOL)clearConversationMessageUnreadState;
- (NSInteger)getUnreadMessageCount;

@end
