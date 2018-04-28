//
//  SLEmojiHelper.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLEmojiCategory.h"

NS_ASSUME_NONNULL_BEGIN
@interface SLEmojiHelper : NSObject

+ (NSArray<SLEmojiCategory *> *)getAllEmojisCategories;
+ (SLEmojiCategory *)getRefreshedHistoryCategory;

@end
NS_ASSUME_NONNULL_END

