//
//  SLChatVoiceMessageCellViewModel.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatMessageBaseCellViewModel.h"

@protocol SLChatVoiceMessageCellViewModel <SLChatMessageBaseCellViewModel>
@property (readonly, copy, nonatomic) NSString *durationDescription;
@property (readonly, assign, nonatomic) NSInteger duration;
@property (readonly, assign, nonatomic) BOOL listened;
@end

@interface SLChatVoiceMessageCellViewModel_Imp : SLChatMessageBaseCellViewModel_Imp <SLChatVoiceMessageCellViewModel>

@end
