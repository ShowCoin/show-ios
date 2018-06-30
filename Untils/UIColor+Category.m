//
//  UIColor+Category.m
//  show gx
//
//  Created by showgx on 15/9/2.
//  Copyright (c) 2015年 show gx. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)customColorWithString:(NSString *)string
{
    //十六进制色值，过滤输入带不带#
    //#121212,121212
    NSString * tempS = nil;
    
    if (string.length == 7) {//#121212,
        tempS = [string substringFromIndex:1];
    }else if(string.length == 6){//121212
        tempS = string;
    }else{
        return nil;
    }
    NSRange rangR = NSMakeRange(0, 2);
    NSString *colorR = [tempS substringWithRange:rangR];
    
    NSRange rangG = NSMakeRange(2, 2);
    NSString *colorG = [tempS substringWithRange:rangG];
    
    NSRange rangB = NSMakeRange(4, 2);
    NSString *colorB = [tempS substringWithRange:rangB];
    
    
    NSScanner * Rscanner = [NSScanner scannerWithString:colorR];
    NSScanner * Gscanner = [NSScanner scannerWithString:colorG];
    NSScanner * Bscanner = [NSScanner scannerWithString:colorB];
    
    unsigned int R ,G, B;
    
    [Rscanner scanHexInt:&R];
    [Gscanner scanHexInt:&G];
    [Bscanner scanHexInt:&B];

    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0f];
}

@end
