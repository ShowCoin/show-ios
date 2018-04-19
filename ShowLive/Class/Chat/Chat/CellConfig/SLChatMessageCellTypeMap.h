//
//  SLChatMessageCellTypeMap.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMLib/RongIMLib.h>
#import "SLChatMessageCellConstants.h"
NS_ASSUME_NONNULL_BEGIN
@interface SLChatMessageCellTypeMap : NSObject
+ (SLChatMessageCellType)cellTypeWithRCMessage:(RCMessage *)rcMessage;
+ (NSString *)cellNameWithCellType:(SLChatMessageCellType)cellType;
+ (NSString *)cellNameWithRCMessage:(RCMessage *)rcMessage;
+ (NSString *)cellViewModelImpClassNameWithRCMessage:(RCMessage *)rcMessage;

@end
NS_ASSUME_NONNULL_END
