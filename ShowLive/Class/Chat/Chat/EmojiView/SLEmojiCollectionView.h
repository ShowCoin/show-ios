//
//  SLEmojiCollectionView.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLEmoji.h"

@interface SLEmojiCollectionView : UICollectionView
@property (strong, nonatomic) NSArray<SLEmoji *> *emojis;

+ (instancetype)viewWithFrame:(CGRect)frame;
@property (copy, nonatomic) void (^emojiCollectionViewDidSelectItemWithEmoji)(SLEmoji *emoji);
@end
