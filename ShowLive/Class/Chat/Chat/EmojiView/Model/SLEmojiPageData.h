//
//  SLEmojiPageData.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
// SLEmojiCategory -> SLEmojiPageData -> SLEmoji

#import <Foundation/Foundation.h>
#import "SLEmoji.h"

@interface SLEmojiPageData : NSObject
@property (strong, nonatomic) NSArray<SLEmoji *> *emojis;
@end
