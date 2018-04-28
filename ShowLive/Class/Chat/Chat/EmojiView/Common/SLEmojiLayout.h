//
//  SLEmojiLayout.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLEmojiLayout : NSObject
/// item横间距
@property (assign, nonatomic) CGFloat itemSpacing;

/// line竖间距
@property (assign, nonatomic) CGFloat lineSpacing;

/// item大小
@property (assign, nonatomic) CGSize itemSize;

/// 一行item个数
@property (assign, nonatomic) NSInteger itemMaxCountOneLine;

/// 最大line行数
@property (assign, nonatomic) NSInteger maxLineCount;

/// 满足最小item横间距
@property (assign, nonatomic) CGFloat requriedItemSpacing;

/// 一页最多item个数，计算方式itemMaxCountOneLine*maxLineCount-1
@property (assign, nonatomic) CGFloat pageMaxItemCount;

+ (SLEmojiLayout *)getEmojiLayout;

@end
