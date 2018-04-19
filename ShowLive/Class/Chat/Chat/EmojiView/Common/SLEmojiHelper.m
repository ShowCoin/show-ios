//
//  SLEmojiHelper.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLEmojiHelper.h"
#import "SLEmojiCacheManage.h"
#import "SLEmojiLayoutConst.h"
#import "SLEmojiLayout.h"

@implementation SLEmojiHelper
+ (NSInteger)pageMaxItemCount
{
    SLEmojiLayout *layout = [SLEmojiLayout getEmojiLayout];
    return layout.pageMaxItemCount;
}

+ (NSArray<SLEmojiCategory *> *)getAllEmojisCategories
{
    // SLEmojiCategory -> SLEmojiPageData -> SLEmoji
    NSInteger pageMaxItemCount = [self pageMaxItemCount];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
    NSDictionary *emojisDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray *categories = [NSMutableArray array];
    @autoreleasepool {
        for (NSString *key in emojisDic.allKeys) {
            NSMutableArray<SLEmojiPageData *> *pageDataList = [NSMutableArray array];
            NSArray *emojisInDic = emojisDic[key];
            for (NSInteger i = 0; i < emojisInDic.count; i++) {
                NSMutableArray<SLEmoji *> *emojisOnPage = [NSMutableArray array];
                NSInteger j = i;
                for (; j < i + pageMaxItemCount && j < emojisInDic.count; j++) {
                    NSString *emojiString = emojisInDic[j];
                    SLEmoji *emoji = [[SLEmoji alloc] init];
                    emoji.emojiString = emojiString;
                    [emojisOnPage addObject:emoji];
                }
                
                SLEmojiPageData *pageData = [[SLEmojiPageData alloc] init];
                pageData.emojis = emojisOnPage;
                [pageDataList addObject:pageData];
                i = j-1;
            }
            
            SLEmojiCategory *category = [[SLEmojiCategory alloc] init];
            category.name = key;
            category.pageDataList = pageDataList;
            [categories addObject:category];
        }
    }
    
    // add history category
    SLEmojiCategory *historyCategory = [self historyCategoryWithPageMaxItemCount:pageMaxItemCount];
    [categories insertObject:historyCategory atIndex:0];
    
    return categories;
}

#pragma mark - History Emoji
+ (SLEmojiCategory *)getRefreshedHistoryCategory
{
    NSInteger pageMaxItemCount = [self pageMaxItemCount];
    return [self historyCategoryWithPageMaxItemCount:pageMaxItemCount];
}

+ (SLEmojiCategory *)historyCategoryWithPageMaxItemCount:(NSInteger)pageMaxItemCount
{
    NSArray<NSString *> *historyList = [[SLEmojiCacheManage sharedManage] historyList];
    NSMutableArray<SLEmoji *> *emojis = [NSMutableArray array];
    [historyList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= pageMaxItemCount) {
            *stop = YES;
        } else {
            SLEmoji *emoji = [SLEmoji emojiWithString:obj];
            [emojis addObject:emoji];
        }
    }];
    
    SLEmojiPageData *pageData = [[SLEmojiPageData alloc] init];
    pageData.emojis = emojis;
    
    SLEmojiCategory *category = [[SLEmojiCategory alloc] init];
    category.name = @"History";
    category.pageDataList = @[pageData];
    return category;
}

@end
