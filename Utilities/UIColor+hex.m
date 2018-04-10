/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/

#import "UIColor+hex.h"

const NSUInteger ColorHexNavigationBar            = 0x2878e8;
const NSUInteger ColorHexNavigationBarTitle       = 0xffffff;
const NSUInteger ColorHexToolbarIcon              = 0x4499ff; //0x64aaf1;

const NSUInteger ColorHexDark                     = 0x416485;
const NSUInteger ColorHexNormal                   = 0x758da5;
const NSUInteger ColorHexLight                    = 0xa9b7c5;

const NSUInteger ColorHexRed                      = 0xc05757;
const NSUInteger ColorHexLightRed                 = 0xe79c9c;
const NSUInteger ColorHexGreen                    = 0x5ba344;
const NSUInteger ColorHexLightGreen               = 0xa0d783;

const NSUInteger ColorHexBlack                    = 0x000000;
const NSUInteger ColorHexGray                     = 0x888888;
const NSUInteger ColorHexWhite                    = 0xffffff;

float byteRatio(NSUInteger hexCode) {
    return ((float)(hexCode & 0xff)) / 255.0f;
}

float blendedByteRatio(NSUInteger hexCode, NSUInteger overHexCode, float alpha) {
    float codeRatio = byteRatio(hexCode);
    float overCodeRatio = byteRatio(overHexCode);
    
    // code = alpha * input + (1 - alpha) * overCode;
    // input = (code - (1 - alpha) * overCode) / alpha
    float input = (codeRatio - (1.0f - alpha) * overCodeRatio) / alpha;
    if (input < 0.0f) {
        input = 0.0f;
    } else if (input > 1.0f) {
        input = 1.0f;
    }
    
    return input;
}

@implementation UIColor (hex)

+ (instancetype)colorWithHex: (NSUInteger)hexCode {
    return [self colorWithHex:hexCode alpha:1.0f];
}

+ (instancetype)colorWithHex: (NSUInteger)hexCode alpha: (float)alpha {
    return [UIColor colorWithRed:byteRatio(hexCode >> 16)
                           green:byteRatio(hexCode >> 8)
                            blue:byteRatio(hexCode)
                           alpha:alpha];
}

+ (instancetype)colorWithHex: (NSUInteger)hexCode overHex: (NSUInteger)overHexCode alpha: (float)alpha {
    return [UIColor colorWithRed:blendedByteRatio(hexCode >> 16, overHexCode >> 16, alpha)
                           green:blendedByteRatio(hexCode >> 8, overHexCode >> 8, alpha)
                            blue:blendedByteRatio(hexCode, overHexCode, alpha)
                           alpha:alpha];
}

@end
