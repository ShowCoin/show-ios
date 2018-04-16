//
//  SLChatVoiceMessageCell.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatMessageBaseCell.h"

@interface SLChatVoiceMessageCell : SLChatMessageBaseCell<SLChatVoiceMessageCellProtocol>

@end
@interface SLChatVoiceMessageCellSizeCache : SLChatMessageBaseCellSizeCache
@property (assign, nonatomic) CGSize contentMiddleSize;
@end


