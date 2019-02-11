//
//  SLPrivateChatViewController+MessageSend.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController.h"
#import "SLChatBusiness.h"

@interface SLPrivateChatViewController (MessageSend)
// Send messages
- (void)sendInputStateMessageWithType:(SLRCInputMessageInputStateType)type;
- (void)sendVoiceMessageWithVoicePath:(NSString *)path duration:(long)duration;
- (void)sendTextMessageWithText:(NSString *)text;
- (void)sendMedioMessageWithMedio:(UIImage *)image;
- (void)sendReceivedMessageReadReceiptWithLastSentTime:(long)lastSentTime;
- (void)sendReceivedMessageReadReceiptWithLastSentTimeInDataBase;
- (void)sendReceivedMessageReadReceiptWithLastSentTimeInDataBaseForcible;

// Resend Message
- (void)resendRCMessage:(RCMessage *)rcMessage pushContent:(NSString *)pushContent cell:(id)cell;
- (void)resendTextMessageWithViewModel:(id)viewModel cell:(id)cell;
- (void)resendVoiceMessageWithViewModel:(id)viewModel cell:(id)cell;
- (void)resendRichMessageWithViewModel:(id)viewModel cell:(id)cell;

// Recall message
- (void)recallRCMessage:(RCMessage *)rcMessage atIndexPath:(NSIndexPath *)indexPath;

// Send message result handle
- (void)comonHandleMessageSendSuccess;
- (void)comonHandleMessageSendFailed:(RCErrorCode)nErrorCode;

@end
