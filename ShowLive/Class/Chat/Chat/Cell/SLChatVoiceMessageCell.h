//
//  SLChatVoiceMessageCell.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatMessageBaseCell.h"

@interface SLChatVoiceMessageCell : SLChatMessageBaseCell<SLChatVoiceMessageCellProtocol>

@end
@interface SLChatVoiceMessageCellSizeCache : SLChatMessageBaseCellSizeCache
@property (assign, nonatomic) CGSize contentMiddleSize;
@end


