//
//  NotificationConstant.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#ifndef NotificationConstant_h
#define NotificationConstant_h

/// 收到聊天图片和视频发送的通知
UIKIT_EXTERN NSString *const kNotify_Conversation_VideoOrImage DEPRECATED_ATTRIBUTE;

/// 收到聊天消息通知
UIKIT_EXTERN NSString *const kNotify_Received_RongCloud_ConvMsg;

/// 收到聊天发送的作品上传的消息
UIKIT_EXTERN NSString *const KMChatDidReceivedArtworkStartUploadNotification;

UIKIT_EXTERN NSString *const kFollowList;
/// 收到本地消息通知
UIKIT_EXTERN NSString *const kKMApplicationDidReceivedLocalNotification;

/// 聊天发送作品通知：memoryId key=>KMChatDidReceivedArtworkStartUploadNotification
UIKIT_EXTERN NSString *const KMChatDidReceivedArtworkStartUploadNotificationMemoryIdKey;

/// 融云登录成功
UIKIT_EXTERN NSString *const kKMRongCloudLoginSuccessNotification;

#define kAccountAddess @"kAccountAddess"

#endif /* NotificationConstant_h */
