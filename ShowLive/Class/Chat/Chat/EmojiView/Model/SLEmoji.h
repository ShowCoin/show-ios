//
//  SLEmojiModel.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
// SLEmojiCategory -> SLEmojiPageData -> SLEmoji

#import <Foundation/Foundation.h>

@interface SLEmoji : NSObject
@property (copy, nonatomic) NSString *emojiString;
/// 备用字段
@property (copy, nonatomic) NSString *emojiDescription;

+ (SLEmoji *)emojiWithString:(NSString *)emojiString;
+ (SLEmoji *)emojiWithString:(NSString *)emojiString emojiDescription:(NSString *)emojiDescription;

@end
