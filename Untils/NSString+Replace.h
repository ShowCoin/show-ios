//
//  NSString+Replace.h
//  Dreamer-ios-client
//
//  Created by 巩鑫 on 2017/6/15.
//  Copyright © 2017年 Beijing Dreamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Replace)

+(NSString *)replaceString:(NSString *)descString
                   keyArray:(NSArray <NSString *> *)keyArray
                 valueArray:(NSArray <NSString *> *)valueArray;
@end
