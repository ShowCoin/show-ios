//
//  SLEmojiCacheManage.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLEmojiCacheManage.h"
static NSString * const kHistoryUserDefaultKey = @"kHistoryUserDefaultKey";
@interface SLEmojiCacheManage()
@property (strong, nonatomic) NSMutableArray *historyList;
@end

@implementation SLEmojiCacheManage
#pragma mark - LifeCycle
+ (instancetype)sharedManage
{
    static SLEmojiCacheManage *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance loadHistory];
    });
    return instance;
}

- (void)loadHistory
{
    _historyList = [NSMutableArray array];
    NSArray *list = [[NSUserDefaults standardUserDefaults] arrayForKey:kHistoryUserDefaultKey];
    [_historyList addObjectsFromArray:list];
    
    [self addNotifications];
}

- (void)saveToUserDefaults
{
    [[NSUserDefaults standardUserDefaults] setObject:_historyList forKey:kHistoryUserDefaultKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setEmojiString:(NSString *)emojiString
{
    [_historyList removeObject:emojiString];
    [_historyList insertObject:emojiString atIndex:0];
}

- (NSArray<NSString *> *)historyList
{
    return _historyList;
}

#pragma mark - NSNotification
- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminateNotification:) name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationWillTerminateNotification:(NSNotification *)notification
{
    [self saveToUserDefaults];
}

- (void)didEnterBackgroundNotification:(NSNotification *)notification
{
    [self saveToUserDefaults];
    
}

@end
