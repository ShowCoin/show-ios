//
//  SLEmojiPageCellEmojiView.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLEmoji;
@interface SLEmojiPageCellEmojiView : UIView
@property (copy, nonatomic) void (^emojiCollectionViewDidSelectItemWithEmoji)(SLEmoji *emoji);
@property (strong, nonatomic) NSArray<SLEmoji *> *emojis;

@end
