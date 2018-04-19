//
//  SLPrivateChatViewController+MessageSend.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController+MessageSend.h"
#import "SLPrivateChatViewController+Business.h"
#import "SLPrivateChatViewController+TableView.h"
#import "SLPrivateChatViewController+InputView.h"
#import "SLChatMessageCellHeader.h"
#import "SLPrivateChatViewController+Common.h"

@implementation SLPrivateChatViewController (MessageSend)
#pragma mark - Send Messages business
- (void)sendInputStateMessageWithType:(SLRCInputMessageInputStateType)type
{
    if (![self isVipHiddenOpen]) {
        [self.business sendInputStateMessageWithType:type];
    }
}

- (void)sendVoiceMessageWithVoicePath:(NSString *)path duration:(long)duration
{
    NSData *voiceData = [NSData dataWithContentsOfFile:path];
    @weakify(self);
    [self.business sendVoiceMessageWithVoiceData:voiceData duration:duration success:^(long messageId) {
        @strongify(self);
        [self addNewMessageDataAtEndWithMessageId:messageId];
        [self comonHandleMessageSendSuccess];
    } error:^(RCErrorCode nErrorCode, long messageId) {
        @strongify(self);
        [self addNewMessageDataAtEndWithMessageId:messageId];
        [self comonHandleMessageSendFailed:nErrorCode];
    }];
}
- (void)sendMedioMessageWithMedio:(UIImage *)image
{
    @weakify(self);
    [self.business sendMedioMessageWithMedioData:image success:^(long messageId) {
        @strongify(self);
        [self addNewMessageDataAtEndWithMessageId:messageId];
        [self comonHandleMessageSendSuccess];
    } error:^(RCErrorCode nErrorCode, long messageId) {
        @strongify(self);
        [self addNewMessageDataAtEndWithMessageId:messageId];
        [self comonHandleMessageSendFailed:nErrorCode];
    }];
}

- (void)sendTextMessageWithText:(NSString *)text
{
    @weakify(self);
    [self.business sendTextMessageWithText:text success:^(long messageId) {
        @strongify(self);
        [self addNewMessageDataAtEndWithMessageId:messageId];
        [self clearInputText];
        [self comonHandleMessageSendSuccess];
    } error:^(RCErrorCode nErrorCode, long messageId) {
        @strongify(self);
        [self addNewMessageDataAtEndWithMessageId:messageId];
        [self clearInputText];
        [self comonHandleMessageSendFailed:nErrorCode];
    }];
}

- (void)sendReceivedMessageReadReceiptWithLastSentTimeInDataBase
{
    if (self.neverSendMessageSinceCome && [self isVipHiddenOpen]) {
        return;
    }
    [self sendReceivedMessageReadReceiptWithLastSentTimeInDataBaseForcible];
}

- (void)sendReceivedMessageReadReceiptWithLastSentTimeInDataBaseForcible
{
    long lastSentTime = [self findLastReceivedMessageSentTime];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (lastSentTime > 0) {
            [self.business sendReadReceiptMessageWithLastSentTime:lastSentTime];
        }
    });
}

- (void)sendReceivedMessageReadReceiptWithLastSentTime:(long)lastSentTime
{
    if (self.neverSendMessageSinceCome && [self isVipHiddenOpen]) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (lastSentTime > 0) {
            [self.business sendReadReceiptMessageWithLastSentTime:lastSentTime];
        }
    });
}

#pragma mark - Resend Message
- (void)resendRCMessage:(RCMessage *)rcMessage pushContent:(NSString *)pushContent cell:(SLChatMessageBaseCell *)cell
{
    @weakify(self);
    [self.business sendMessageWithMessageContent:rcMessage.content pushContent:pushContent success:^(long messageId) {
        @strongify(self);
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self deleteCellDataAndMessageAtRow:indexPath.row animation:YES];
        [self addNewMessageDataAtEndWithMessageId:messageId];
        [self comonHandleMessageSendSuccess];
    } error:^(RCErrorCode nErrorCode, long messageId) {
        @strongify(self);
        [self comonHandleMessageSendFailed:nErrorCode];
        [self updateCellDataWithMessageId:rcMessage.messageId];// 更新重发消息的状态
        [self.business deleteMessageWithId:messageId];
    }];
}

- (void)resendTextMessageWithViewModel:(id<SLChatTextMessageCellViewModel>)viewModel cell:(SLChatMessageBaseCell *)cell
{
    NSString *pushContent = viewModel.contentString;
    if (pushContent.length >= 30) {
        pushContent = [[pushContent substringToIndex:29] stringByAppendingString:@"…"];
    }
    pushContent = [NSString stringWithFormat:@"%@:%@", AccountUserInfoModel.nickname, pushContent];
    [self resendRCMessage:viewModel.rcMessage pushContent:pushContent cell:cell];
}
- (void)resendVoiceMessageWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel cell:(SLChatMessageBaseCell *)cell
{
    NSString *pushContent = [NSString stringWithFormat:@"%@:%@", AccountUserInfoModel.nickname, @"给你发送了一段语音"];
    [self resendRCMessage:viewModel.rcMessage pushContent:pushContent cell:cell];
}

- (void)resendRichMessageWithViewModel:(id<SLChatRichMessageCellViewModel>)viewModel cell:(SLChatMessageBaseCell *)cell
{
 
        NSString *pushContent = (viewModel.artworkType == SLChatRichMessageCellArtworkTypeVideo) ? @":给你发送了一段视频" : @":给你发送了一张照片";
        pushContent = [AccountUserInfoModel.nickname stringByAppendingString:pushContent];
        [self resendRCMessage:viewModel.rcMessage pushContent:pushContent cell:cell];
}
#pragma mark - Commonly handle
- (void)comonHandleMessageSendSuccess
{
    [self messageSuccessStatistics];
    // 由于vip开启隐身功能的用户，首次进来是不会发送消息回执的，在此判断首次发送消息，发送已读回执，避免进来没有发送已读回执的遗憾
    if (self.neverSendMessageSinceCome && [self isVipHiddenOpen]) {
        [self sendReceivedMessageReadReceiptWithLastSentTimeInDataBaseForcible];
    }
    self.neverSendMessageSinceCome = NO;
}

- (void)comonHandleMessageSendFailed:(RCErrorCode)nErrorCode
{
    [self showMessageErrorToast:nErrorCode];
    if (self.neverSendMessageSinceCome && [self isVipHiddenOpen]) {
        [self sendReceivedMessageReadReceiptWithLastSentTimeInDataBaseForcible];
    }
    self.neverSendMessageSinceCome = NO;
}

#pragma mark - Private
- (BOOL)isVipHiddenOpen
{
    return NO;
}

- (NSUInteger)getADiceNumber
{
    NSUInteger randomNumber = arc4random() % 6 + 1;
    return randomNumber;
}

- (void)messageSuccessStatistics
{
    [self.business startMessageSuccessStatisticsAction];
}

- (void)showMessageErrorToast:(RCErrorCode)nErrorCode
{
    if (REJECTED_BY_BLACKLIST == nErrorCode) {
        [ShowWaringView waringView:@"对方已将您拉黑，暂时无法对话" style:WaringStyleRed];
    }else{
        [ShowWaringView waringView:@"发送失败，请稍后重试" style:WaringStyleRed];
        [self.business checSLessageNetwork];
    }
}

#pragma mark - Recall
- (void)recallRCMessage:(RCMessage *)rcMessage atIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    [self.business recallRCMessage:rcMessage success:^(long messageId) {
        @strongify(self);
        [self updateCellDataAtRow:indexPath.row messageId:messageId];
    } error:^(RCErrorCode errorcode) {
        [ShowWaringView waringView:@"撤回失败，请检查一下网络" style:WaringStyleRed];
    }];
}

@end
