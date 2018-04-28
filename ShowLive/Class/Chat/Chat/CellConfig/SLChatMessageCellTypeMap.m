//
//  SLChatMessageCellTypeMap.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatMessageCellTypeMap.h"

@implementation SLChatMessageCellTypeMap
#pragma mark - Public
+ (SLChatMessageCellType)cellTypeWithRCMessage:(RCMessage *)rcMessage
{
    return [[[self rcMessageToCellTypeMap] objectForKey:rcMessage.objectName] integerValue];
}

+ (NSString *)cellNameWithCellType:(SLChatMessageCellType)cellType
{
    return [self cellTypeToCellClassNameMap][@(cellType)];
}

+ (NSString *)cellNameWithRCMessage:(RCMessage *)rcMessage
{
    SLChatMessageCellType cellType = [self cellTypeWithRCMessage:rcMessage];
    return [self cellNameWithCellType:cellType];
}

+ (NSString *)cellViewModelImpClassNameWithRCMessage:(RCMessage *)rcMessage
{
    SLChatMessageCellType cellType = [self cellTypeWithRCMessage:rcMessage];
    return [self cellTypeToCellViewModelImpClassNameMap][@(cellType)];
}

#pragma mark - Inner
+ (NSDictionary *)cellTypeToCellViewModelImpClassNameMap
{
    static NSDictionary *dic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{
                @(SLChatMessageCellTypeBase)          : @"SLChatMessageBaseCellViewModel_Imp",
                @(SLChatMessageCellTypeText)          : @"SLChatTextMessageCellViewModel_Imp",
                @(SLChatMessageCellTypeRich)          : @"SLChatRichMessageCellViewModel_Imp",
                @(SLChatMessageCellTypeVoice)         : @"SLChatVoiceMessageCellViewModel_Imp",
                @(SLChatMessageCellTypeGift)          : @"SLChatGiftMessageCellViewModel_Imp",
                @(SLChatMessageCellTypeNotice)        : @"SLChatNoticeMessageCellViewModel_Imp",
                @(SLChatMessageCellTypeDice)          : @"SLChatDiceMessageCellViewModel_Imp",
                @(SLChatMessageCellTypeLocation)      : @"SLChatLocationMessageCellViewModel_Imp",
                
                };
    });
    return dic;
}

+ (NSDictionary *)cellTypeToCellClassNameMap
{
    static NSDictionary *dic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{
                @(SLChatMessageCellTypeBase)          : @"SLChatMessageBaseCell",
                @(SLChatMessageCellTypeText)          : @"SLChatTextMessageCell",
                @(SLChatMessageCellTypeRich)          : @"SLChatRichMessageCell",
                @(SLChatMessageCellTypeVoice)         : @"SLChatVoiceMessageCell",
                @(SLChatMessageCellTypeGift)          : @"SLChatGiftMessageCell",
                @(SLChatMessageCellTypeNotice)        : @"SLChatNoticeMessageCell",
                @(SLChatMessageCellTypeDice)          : @"SLChatDiceMessageCell",
                @(SLChatMessageCellTypeLocation)      : @"SLChatLocationMessageCell",
                };
    });
    return dic;
}

+ (NSDictionary *)rcMessageToCellTypeMap
{
    static NSDictionary *dic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{
                RCTextMessageTypeIdentifier           : @(SLChatMessageCellTypeText),
                RCImageMessageTypeIdentifier          : @(SLChatMessageCellTypeRich),
                RCVoiceMessageTypeIdentifier          : @(SLChatMessageCellTypeVoice),
                RCRecallNotificationMessageIdentifier : @(SLChatMessageCellTypeNotice),
                RCLocationMessageTypeIdentifier       : @(SLChatMessageCellTypeLocation),
                };
    });
    return dic;
}

@end
