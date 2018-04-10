/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/

#import <UIKit/UIKit.h>

extern const NSUInteger ColorHexNavigationBar;
extern const NSUInteger ColorHexNavigationBarTitle;
extern const NSUInteger ColorHexToolbarIcon;

extern const NSUInteger ColorHexDark;
extern const NSUInteger ColorHexNormal;
extern const NSUInteger ColorHexLight;

extern const NSUInteger ColorHexRed;
extern const NSUInteger ColorHexGreen;

extern const NSUInteger ColorHexLightRed;
extern const NSUInteger ColorHexLightGreen;

extern const NSUInteger ColorHexBlack;
extern const NSUInteger ColorHexGray;
extern const NSUInteger ColorHexWhite;


@interface UIColor (hex)

+ (instancetype)colorWithHex: (NSUInteger)hexCode;
+ (instancetype)colorWithHex: (NSUInteger)hexCode alpha: (float)alpha;
+ (instancetype)colorWithHex: (NSUInteger)hexCode overHex: (NSUInteger)overHexCode alpha: (float)alpha;

@end
