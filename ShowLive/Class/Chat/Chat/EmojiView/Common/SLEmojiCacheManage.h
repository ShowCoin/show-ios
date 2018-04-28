//
//  SLEmojiCacheManage.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface SLEmojiCacheManage : NSObject
+ (instancetype)sharedManage;
- (NSArray<NSString *> *)historyList;
- (void)setEmojiString:(NSString *)emojiString;
@end
NS_ASSUME_NONNULL_END
