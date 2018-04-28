//
//  SLPrivateChatViewController+Emoji.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLPrivateChatViewController.h"
#import "SLEmojiView.h"
@interface SLPrivateChatViewController()
@property (strong, nonatomic) SLEmojiView *emojiView;
@end

@interface SLPrivateChatViewController (Emoji)
@property (assign, nonatomic) BOOL isEmojiViewShow;

@end
