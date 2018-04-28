//
//  SLChatRichMessageCellViewModel.h
//  ShowLive
//
//  Created by Mac on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatMessageBaseCellViewModel.h"
typedef NS_ENUM(NSInteger, SLChatRichMessageCellArtworkType) {
    SLChatRichMessageCellArtworkTypePicture,
    SLChatRichMessageCellArtworkTypeVideo
};

@protocol SLChatRichMessageCellViewModel <SLChatMessageBaseCellViewModel>
@property (readonly, copy, nonatomic) NSString *cover;
@property (readonly, copy, nonatomic) NSString *localCover;
@property (readonly, assign, nonatomic) SLChatRichMessageCellArtworkType artworkType;
/**
 判定消息是否在发送中，和发送失败一起判断
 */
@property (readwrite, assign, nonatomic) BOOL isUploading;

@end
@interface SLChatRichMessageCellViewModel_Imp  : SLChatMessageBaseCellViewModel_Imp<SLChatRichMessageCellViewModel>

@end
