/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/

#import <Foundation/Foundation.h>

/**
 *  CachedDataStore
 *
 *  Store and retreive values associated to keys, persistened on disk.
 *  All values are cached in memory and flushed to disk (on write) after
 *  100ms.
 *
 *  This class is thread-safe

@interface CachedDataStore : NSObject

+ (instancetype)sharedCachedDataStoreWithKey: (NSString*)key;

@property (nonatomic, readonly) NSString *key;

- (void)purgeData;
- (void)filterData: (BOOL (^)(CachedDataStore *dataStore, NSString *key))filterCallback;

- (NSArray<NSString*>*)allKeys;

- (NSTimeInterval)timeIntervalForKey: (NSString*)key;
- (BOOL)setTimeInterval: (NSTimeInterval)value forKey: (NSString*)key;

- (BOOL)boolForKey: (NSString*)key;
- (BOOL)setBool: (BOOL)value forKey: (NSString*)key;

- (NSInteger)integerForKey: (NSString*)key;
- (BOOL)setInteger: (NSInteger)value forKey: (NSString*)key;

- (float)floatForKey: (NSString*)key;
- (BOOL)setFloat: (float)value forKey: (NSString*)key;

- (NSString*)stringForKey: (NSString*)key;
- (BOOL)setString: (NSString*)value forKey: (NSString*)key;

- (BOOL)setArray: (NSArray*)value forKey:(NSString *)key;
- (NSArray*)arrayForKey: (NSString*)key;

- (BOOL)setObject: (NSObject*)value forKey: (NSString*)key;
- (NSObject*)objectForKey: (NSString*)key;

@end
