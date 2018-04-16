//
//  SLChatVoiceMessageCellViewModel.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatVoiceMessageCellViewModel.h"
#import "SLChatVoiceMessageCell.h"

@implementation SLChatVoiceMessageCellViewModel_Imp
@synthesize sizeCache = _sizeCache;
- (id<SLChatVoiceMessageCellViewModel>)initWithRcMessage:(RCMessage *)rcMessage hideTime:(BOOL)hideTime showNotDisturbTips:(BOOL)showNotDisturbTips
{
    self = [super initWithRcMessage:rcMessage hideTime:hideTime showNotDisturbTips:showNotDisturbTips];
    if (self) {
        
    }
    return self;
}

#pragma mark - Protocols
- (NSString *)durationDescription
{
    return [NSString stringWithFormat:@"%.0ld\"", (long)self.duration];
}

- (NSInteger)duration
{
    RCVoiceMessage *voiceMsg = (RCVoiceMessage *)self.rcMessage.content;
    NSInteger duration = voiceMsg.duration * 0.001;
    return duration;
}

- (BOOL)listened
{
    return ( self.messageDirection == SLChatMessageDirectionReceived ) && ( self.rcMessage.receivedStatus == ReceivedStatus_LISTENED );
}

#pragma mark - Size Cache
- (SLChatMessageBaseCellSizeCache *)sizeCache
{
    if (!_sizeCache) {
        _sizeCache = [SLChatVoiceMessageCellSizeCache cacheWithViewModel:self];
    }
    return _sizeCache;
}
@end
