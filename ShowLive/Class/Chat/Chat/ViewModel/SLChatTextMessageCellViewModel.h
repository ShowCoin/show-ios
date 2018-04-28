//
//  SLChatTextMessageCellViewModel.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatMessageBaseCellViewModel.h"

@protocol SLChatTextMessageCellViewModel <SLChatMessageBaseCellViewModel>
@property (readonly, copy, nonatomic) NSString *contentString;
@property (readonly, copy, nonatomic) NSAttributedString *contentAttributedString;
@end

@interface SLChatTextMessageCellViewModel_Imp : SLChatMessageBaseCellViewModel_Imp<SLChatTextMessageCellViewModel>

@end
