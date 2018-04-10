//
//  UIFont+font.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UIFont+font.h"

@implementation UIFont (font)

/**
 familyName = PingFang SC
 fontName = PingFangSC-Ultralight   极细
 fontName = PingFangSC-Regular      常规
 fontName = PingFangSC-Semibold     中粗
 fontName = PingFangSC-Thin         纤细
 fontName = PingFangSC-Light        细
 fontName = PingFangSC-Medium       中黑
 */


+(instancetype)pingfangRegularWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    return font ? font : [UIFont systemFontOfSize:fontSize];
}

+(instancetype)pingfangSemiboldWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
    return font ? font : [UIFont systemFontOfSize:fontSize];
}

+(instancetype)pingfangThinWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Thin" size:fontSize];
    return font ? font : [UIFont systemFontOfSize:fontSize];
}

+(instancetype)pingfangLightWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
    return font ? font : [UIFont systemFontOfSize:fontSize];
}

+(instancetype)pingfangMediumWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    return font ? font : [UIFont boldSystemFontOfSize:fontSize];
}

+(instancetype)futuraBoldWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"Futura-Bold" size:fontSize];
    return font ? font : [UIFont boldSystemFontOfSize:fontSize];
}

+(instancetype)futuraMediumWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:fontSize];
    return font ? font : [UIFont boldSystemFontOfSize:fontSize];
}

@end
