//
//  SLEmojiModel.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLEmoji.h"

@implementation SLEmoji
+ (SLEmoji *)emojiWithString:(NSString *)emojiString
{
    return [self emojiWithString:emojiString emojiDescription:nil];
}

+ (SLEmoji *)emojiWithString:(NSString *)emojiString emojiDescription:(NSString *)emojiDescription
{
    SLEmoji *emoji = [[self alloc] init];
    emoji.emojiString = emojiString;
    emoji.emojiDescription = emojiDescription;
    return emoji;
}
@end
