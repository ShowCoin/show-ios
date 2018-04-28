//
//  SLChatTextMessageCellViewModel.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatTextMessageCellViewModel.h"
#import "YYText.h"
#import "SLChatTextMessageCell.h"

@implementation SLChatTextMessageCellViewModel_Imp
@synthesize sizeCache = _sizeCache;

- (id<SLChatTextMessageCellViewModel>)initWithRcMessage:(RCMessage *)rcMessage
                                               hideTime:(BOOL)hideTime
                                     showNotDisturbTips:(BOOL)showNotDisturbTips {
    self = [super initWithRcMessage:rcMessage hideTime:hideTime showNotDisturbTips:showNotDisturbTips];
    if (self) {
        
    }
    return self;
}

- (void)updateWithRCMessage:(RCMessage *)rcMessage hideTime:(BOOL)hideTime showNotDisturbTips:(BOOL)showNotDisturbTips
{
    [super updateWithRCMessage:rcMessage hideTime:hideTime showNotDisturbTips:showNotDisturbTips];
}

#pragma mark - Protocols
- (NSString *)contentString
{
    return [self messageContent].content;
}

- (NSAttributedString *)contentAttributedString
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.contentString];
    if (self.messageDirection == SLChatMessageDirectionSend) {
        attri.yy_color = kthemeBlackColor;
    } else {
        attri.yy_color = RGBAllColor(0x1B1926);
    }
    attri.yy_lineSpacing = 3.f;
    attri.yy_font = [UIFont systemFontOfSize:15];
    return attri;
}

#pragma mark - RCMessage Analysis
- (RCTextMessage *)messageContent
{
    return (RCTextMessage *)self.rcMessage.content;
}

#pragma mark - Size Cache
- (SLChatMessageBaseCellSizeCache *)sizeCache
{
    if (!_sizeCache) {
        _sizeCache = [SLChatTextMessageCellSizeCache cacheWithViewModel:self];
    }
    return _sizeCache;
}

@end
