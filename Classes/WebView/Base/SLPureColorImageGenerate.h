//
//  SLPureColorImageGenerate.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLPureColorImageGenerate : NSObject

/**
 return a custom radius UIImage

 @param color background color
 @param size image size
 @param radius image radius
 @return UIImage
 */
+ (UIImage *)getImageWithColor:(UIColor *)color andSize:(CGSize)size corner:(CGFloat)radius;

@end
