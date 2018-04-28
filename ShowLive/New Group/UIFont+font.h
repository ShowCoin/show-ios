//
//  UIFont+font.h
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>

// 常规
#define Font_Regular(x) [UIFont pingfangRegularWithSize:(x)]
// 中等
#define Font_Medium(x)   [UIFont pingfangMediumWithSize:(x)]
// 粗
#define Font_Semibold(x) [UIFont pingfangSemiboldWithSize:(x)]

#define Font_Light(x) [UIFont pingfangLightWithSize:x]

#define Font_FuturaBold(x) [UIFont futuraBoldWithSize:x]

#define Font_FuturaMedium(x) [UIFont futuraMediumWithSize:x]

@interface UIFont (font)
/**
 *  常规
 */
+(instancetype)pingfangRegularWithSize:(CGFloat)fontSize;
/**
 *  中粗
 */
+(instancetype)pingfangSemiboldWithSize:(CGFloat)fontSize;
/**
 *  纤细
 */
+(instancetype)pingfangThinWithSize:(CGFloat)fontSize;
/**
 *  细
 */
+(instancetype)pingfangLightWithSize:(CGFloat)fontSize;
/**
 *  中黑
 */
+(instancetype)pingfangMediumWithSize:(CGFloat)fontSize;

+(instancetype)futuraBoldWithSize:(CGFloat)fontSize;

+(instancetype)futuraMediumWithSize:(CGFloat)fontSize;

@end
