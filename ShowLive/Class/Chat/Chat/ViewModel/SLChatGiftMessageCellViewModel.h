//
//  SLChatGiftMessageCellViewModel.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatMessageBaseCellViewModel.h"

@interface SLChatGiftMessageCellViewModel : SLChatMessageBaseCellViewModel_Imp
@property (readonly, strong, nonatomic) NSAttributedString *charmAttributedString;
@property (readonly, strong, nonatomic) NSAttributedString *giftNameAttributedString;
@property (readonly, strong, nonatomic) NSAttributedString *giftTipsAttributedString;
@property (readonly, assign, nonatomic) BOOL hideBottomGiftTips;
@property (readonly, copy, nonatomic) NSString *giftImageUrlString;
/**
 标识是否是最后一条发送来的礼物消息
 */
@property (readwrite, assign, nonatomic) BOOL isLastSentGiftMessage;

/**
 外部传入relation接口传来的deadTime:当前礼品有效截止时间 ，-1代表永久有效
 */
@property (readwrite, assign, nonatomic) NSTimeInterval deadTime;
@end
