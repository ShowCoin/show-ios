//
//  SLChatMessageBaseCellViewModel.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatMessageBaseCellViewModel.h"
#import "SLChatMessageCellTypeMap.h"
#import "SLChatMessageBaseCell.h"

@interface SLChatMessageBaseCellViewModel_Imp ()
@property (assign, nonatomic) SLChatMessageCellType cellType;
@property (assign, nonatomic) SLChatMessageDirection messageDirection;
@end

@implementation SLChatMessageBaseCellViewModel_Imp
@synthesize hideTime = _hideTime;
@synthesize showNotDisturbTips = _showNotDisturbTips;
@synthesize senderUid = _senderUid;
@synthesize rcMessage = _rcMessage;
@synthesize isSentMessageRead = _isSentMessageRead;
@synthesize showSentMessageReadAnimation = _showSentMessageReadAnimation;
@synthesize sizeCache = _sizeCache;

#pragma mark - Init
- (instancetype)init
{
    NSAssert(0, @"Use - initWithRcMessage:hideTime:showNotDisturbTips:");
    return nil;
}

- (id<SLChatMessageBaseCellViewModel>)initWithRcMessage:(RCMessage *)rcMessage
                                               hideTime:(BOOL)hideTime
                                     showNotDisturbTips:(BOOL)showNotDisturbTips
{
    self = [super init];
    if (self) {
        self.rcMessage = rcMessage;
        self.showNotDisturbTips = showNotDisturbTips;
        self.hideTime = hideTime;
        self.isSentMessageRead = ( rcMessage.sentStatus == SentStatus_READ );
        self.cellType = [SLChatMessageCellTypeMap cellTypeWithRCMessage:rcMessage];
        self.showSentMessageReadAnimation = YES;
        if (rcMessage.messageDirection == MessageDirection_SEND) {
            self.messageDirection = SLChatMessageDirectionSend;
            self.senderUid =@"12345678";
        } else {
            self.messageDirection = SLChatMessageDirectionReceived;
            self.senderUid = rcMessage.senderUserId;
        }
    }
    return self;
}

+ (id<SLChatMessageBaseCellViewModel>)viewModelWithRcMessage:(RCMessage *)rcMessage
{
    return [self viewModelWithRcMessage:rcMessage hideTime:NO showNotDisturbTips:NO];
}

+ (id<SLChatMessageBaseCellViewModel>)viewModelWithRcMessage:(RCMessage *)rcMessage
                                                    hideTime:(BOOL)hideTime
                                          showNotDisturbTips:(BOOL)showNotDisturbTips
{
    return [[self alloc] initWithRcMessage:rcMessage hideTime:hideTime showNotDisturbTips:showNotDisturbTips];
}

- (void)updateWithRCMessage:(RCMessage *)rcMessage hideTime:(BOOL)hideTime showNotDisturbTips:(BOOL)showNotDisturbTips
{
    self.rcMessage = rcMessage;
    [self updateCachedHeightIfNeed];
    self.showNotDisturbTips = showNotDisturbTips;
    self.hideTime = hideTime;
    self.sizeCache = nil;
    
    self.isSentMessageRead = ( rcMessage.sentStatus == SentStatus_READ );
    if (rcMessage.messageDirection == MessageDirection_SEND) {
        self.messageDirection = SLChatMessageDirectionSend;
        self.senderUid = @"12345678";
    } else {
        self.messageDirection = SLChatMessageDirectionReceived;
        self.senderUid = rcMessage.senderUserId;
    }
}

- (void)updateWithRCMessage:(RCMessage *)rcMessage
{
    [self updateWithRCMessage:rcMessage hideTime:_hideTime showNotDisturbTips:_showNotDisturbTips];
}


#pragma mark - Protocols

- (NSString *)time
{
    // 时间展示:sentTime发送时间，无论是接收的消息还是发送的消息,服务器返回的时间是毫秒，13位数，而ios的时间戳是10位，所以除以1000
    NSTimeInterval time = self.rcMessage.sentTime * 0.001;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [KMHelper DescriptionWithDate:date];
}

- (BOOL)isVip
{
    BOOL isVip = NO;
   
    return isVip;
}

- (BOOL)isIdentified
{
    BOOL isSinaIdentified = NO;
    
    return isSinaIdentified;
}

- (NSString *)avatarUrlString
{
    NSString *avatarUrlString = nil;
    
    return avatarUrlString;
}

- (BOOL)showSentMessageReadState
{
    return ( self.messageDirection == SLChatMessageDirectionSend );
}

- (BOOL)sentFailed
{
    return ( self.messageDirection ==  SLChatMessageDirectionSend) && ( self.rcMessage.sentStatus == SentStatus_FAILED );
}

- (NSTimeInterval)sentTimeIntervalSinceNow
{
    RCMessage *message = self.rcMessage;
    //服务器返回的时间是毫秒，13位数，而ios的时间戳是10位，所以除以1000
    NSTimeInterval sentTime = message.sentTime * 0.001;
    NSDate *sendDate = [NSDate dateWithTimeIntervalSince1970:sentTime];
    NSTimeInterval timeSpace = [[NSDate date] timeIntervalSinceDate:sendDate];
    return timeSpace;
}
#pragma mark - Size Cache: 子类重载实现自己的
/// 如果子类有自己的cache类，重载实现getter、setter方法
- (SLChatMessageBaseCellSizeCache *)sizeCache
{
    if (!_sizeCache) {
        _sizeCache = [SLChatMessageBaseCellSizeCache cacheWithViewModel:self];
    }
    return _sizeCache;
}

- (void)setSizeCache:(SLChatMessageBaseCellSizeCache *)sizeCache
{
    _sizeCache = sizeCache;
}

- (void)updateCachedHeightIfNeed
{
    [self.sizeCache updateAllCachedSizeIfNeedWithViewModel:self];
}

@end
