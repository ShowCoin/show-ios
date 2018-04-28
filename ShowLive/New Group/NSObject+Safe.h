//
//  NSObject+Safe.h
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

static inline NSString* NSStringFormCMTime (CMTime time)
{
    return [@{@"value": @(time.value).stringValue,
             @"timescale": @(time.timescale).stringValue
             } mj_JSONString];
}

static inline CMTime CMTimeFromString (NSString* string)
{
    NSDictionary *dict = [string mj_JSONObject];
    int value = [dict[@"value"] floatValue];
    int timescale = [dict[@"timescale"] floatValue];
    return CMTimeMake(value, timescale);
}

static inline NSDictionary* DictionaryFormCGPoint(CGPoint point)
{
    return @{@"x": @(point.x).stringValue,
             @"y": @(point.y).stringValue
             };
}

static inline CGPoint CGPointFromDictionary(NSDictionary* dict)
{
    CGFloat x = [dict[@"x"] floatValue];
    CGFloat y = [dict[@"y"] floatValue];
    return (CGPoint){x,y};
}

static inline NSDictionary* DictionaryFormCGSize(CGSize size)
{
    return @{@"w": @(size.width).stringValue,
             @"h": @(size.height).stringValue
             };
}

static inline CGSize CGSizeFromDictionary(NSDictionary* dict)
{
    CGFloat w = [dict[@"w"] floatValue];
    CGFloat h = [dict[@"h"] floatValue];
    return (CGSize){w,h};
}


static inline NSDictionary* DictionaryFormCGRect(CGRect rect)
{
    return @{@"x": @(rect.origin.x).stringValue,
             @"y": @(rect.origin.y).stringValue,
             @"w": @(rect.size.width).stringValue,
             @"h": @(rect.size.height).stringValue
             };
}

static inline CGRect CGRectFromDictionary(NSDictionary* dict)
{
    CGFloat x = [dict[@"x"] floatValue];
    CGFloat y = [dict[@"y"] floatValue];
    CGFloat w = [dict[@"w"] floatValue];
    CGFloat h = [dict[@"h"] floatValue];
    return (CGRect){x,y,w,h};
}

// rect -> 像素
static inline NSDictionary* DictionaryPixelFormCGRect(CGRect rect)
{
    return @{@"x": @(rect.origin.x *kScreenScale).stringValue,
             @"y": @(rect.origin.y *kScreenScale).stringValue,
             @"w": @(rect.size.width *kScreenScale).stringValue,
             @"h": @(rect.size.height *kScreenScale).stringValue
             };
}

// 像素 -> rect
static inline CGRect CGRectFromDictionaryPixel(NSDictionary* dict)
{
    CGFloat x = [dict[@"x"] floatValue] / kScreenScale;
    CGFloat y = [dict[@"y"] floatValue] / kScreenScale;
    CGFloat w = [dict[@"w"] floatValue] / kScreenScale;
    CGFloat h = [dict[@"h"] floatValue] / kScreenScale;
    return (CGRect){x,y,w,h};
}

// size -> 像素
static inline NSDictionary* DictionaryPixelFormCGSize(CGSize size)
{
    return @{@"w": @(size.width *kScreenScale).stringValue,
             @"h": @(size.height *kScreenScale).stringValue
             };
}

// 像素 -> size
static inline CGSize CGSizeFromDictionaryPixel(NSDictionary* dict)
{
    CGFloat w = [dict[@"w"] floatValue] / kScreenScale;
    CGFloat h = [dict[@"h"] floatValue] / kScreenScale;
    return (CGSize){w,h};
}

@interface NSObject (Safe)

- (NSDictionary *)safeDictionary;
- (NSArray *)safeArray;
- (NSString *)safeString;
- (NSNumber *)safeNumber;

@end
