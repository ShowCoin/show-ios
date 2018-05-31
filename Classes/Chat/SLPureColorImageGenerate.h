//
//  SLPureColorImageGenerate.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLPureColorImageGenerate : NSObject
+ (UIImage *)getImageWithColor:(UIColor *)color andSize:(CGSize)size corner:(CGFloat)radius;

@end
