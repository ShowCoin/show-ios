//
//  SLChatMessageBaseCellViewModel.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLChatMessageCellConstants.h"

@class SLChatMessageBaseCellSizeCache;
@protocol SLChatMessageBaseCellViewModel <NSObject>

@property (readonly, assign, nonatomic) SLChatMessageCellType cellType;
@property (readonly, assign, nonatomic) SLChatMessageDirection messageDirection;

/// RCMessage，更新viewModel请使用updateWithRCMessage:方法，某些解析为了性能做了缓存，直接赋值导致不会更新
@property (readwrite, strong, nonatomic) RCMessage *rcMessage;
@property (readwrite, strong, nonatomic) NSString *senderUid;

/// 有关头像、时间的设置
@property (readonly, copy, nonatomic) NSString *time;
@property (readonly, copy, nonatomic) NSString *avatarUrlString;
@property (readonly, assign, nonatomic) BOOL isVip;
@property (readonly, assign, nonatomic) BOOL isIdentified;

/// 发送的消息:是否发送失败
@property (readonly, assign, nonatomic) BOOL sentFailed;

/// 发送的消息:是否已经读取，外部可以修改
@property (readwrite, assign, nonatomic) BOOL isSentMessageRead;

/// 消息已读状态，默认发送的消息显示
@property (readonly, assign, nonatomic) BOOL showSentMessageReadState;

/// 是否显示已读状态改变的动画,外部可以设置
@property (readwrite, assign, nonatomic) BOOL showSentMessageReadAnimation;

/// 是否隐藏时间标签，由外部计算传入
@property (readwrite, assign, nonatomic) BOOL hideTime;

/// 是否显示免打扰或拉黑的提示，由外部计算传入
@property (readwrite, assign, nonatomic) BOOL showNotDisturbTips;

/// 高度和其它需要耗时的计算缓存,如果不使用SLChatMessageBaseCellSizeCache而使用其子类，需重载实现Getter方法特殊cache
@property (readwrite, strong, nonatomic) SLChatMessageBaseCellSizeCache *sizeCache;


/// 设置需要计算高度，缓存，另外有一些特殊的高度缓存，子类需要处理
- (void)updateCachedHeightIfNeed;

/// 调用updateWithRCMessage:hideTime:showNotDistrubTips:, hideTime：NO， showNotDistrubTips:NO
- (void)updateWithRCMessage:(RCMessage *)rcMessage;

/// 提供给外界的更新操作，子类要覆写所需,如果有一些需要重新计算的高度，子类可在：updateCachedHeightIfNeed这个方法里设置
- (void)updateWithRCMessage:(RCMessage *)rcMessage hideTime:(BOOL)hideTime showNotDisturbTips:(BOOL)showNotDisturbTips;

- (NSTimeInterval)sentTimeIntervalSinceNow;

@end

@interface SLChatMessageBaseCellViewModel_Imp : NSObject <SLChatMessageBaseCellViewModel>

- (instancetype)init NS_UNAVAILABLE;
- (id<SLChatMessageBaseCellViewModel>)initWithRcMessage:(RCMessage *)rcMessage hideTime:(BOOL)hideTime showNotDisturbTips:(BOOL)showNotDisturbTips NS_DESIGNATED_INITIALIZER;

///  转换，默认hideTime:NO;showNotDisturbTips:NO;
+ (id<SLChatMessageBaseCellViewModel>)viewModelWithRcMessage:(RCMessage *)rcMessage;
+ (id<SLChatMessageBaseCellViewModel>)viewModelWithRcMessage:(RCMessage *)rcMessage hideTime:(BOOL)hideTime showNotDisturbTips:(BOOL)showNotDisturbTips;

@end
