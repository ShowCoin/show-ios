//
//  SLEmojiCell.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLEmoji;
@interface SLEmojiCollectionCell : UICollectionViewCell
@property (strong, nonatomic) SLEmoji *emoji;
@property (copy, nonatomic) void (^emojiButtonClick)(SLEmoji *emoji);
@end
