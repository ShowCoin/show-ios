//
//  SLChatRichMessageCellViewModel.m
//  ShowLive
//
//  Created by Mac on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatRichMessageCellViewModel.h"
@interface SLChatRichMessageCellViewModel_Imp()
@end
@implementation SLChatRichMessageCellViewModel_Imp
@synthesize rcMessage = _rcMessage;
@synthesize isUploading =_isUploading;

- (id<SLChatRichMessageCellViewModel>)initWithRcMessage:(RCMessage *)rcMessage
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
    // 重新构建
}
#pragma mark - Protocols

- (NSString *)cover
{
    NSString *cover = [self getOriginalCover];
    return cover;
}
#pragma mark - Private
- (NSString *)getOriginalCover
{
    RCImageMessage *msg = (RCImageMessage *)_rcMessage.content;
    //注：发送方图片消息的原图地址为一个本地路径，接收方图片消息的原图地址为一个网络url
    NSString *imageUrl = msg.imageUrl;
    NSLog(@"原图地址为：%@",imageUrl);

    return imageUrl; // 封面
}
-(NSString *)localCover
{
    RCImageMessage *msg = (RCImageMessage *)_rcMessage.content;
    //注：发送方图片消息的原图地址为一个本地路径，接收方图片消息的原图地址为一个网络url
    NSString *imageUrl = msg.localPath;
    NSLog(@"原图地址为：%@",imageUrl);
    
    return imageUrl; // 封面
}
@end
