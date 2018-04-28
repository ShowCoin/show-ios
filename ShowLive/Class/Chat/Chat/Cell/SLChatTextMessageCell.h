//
//  SLChatTextMessageCell.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatMessageBaseCell.h"

@interface SLChatTextMessageCell : SLChatMessageBaseCell

@end
@interface SLChatTextMessageCellSizeCache : SLChatMessageBaseCellSizeCache
@property (assign, nonatomic) CGSize contentMiddleSize;
@end
