//
//  NSString+Replace.h
//  Show gx
//
//  Created by gx on 2017/6/15.
//  Copyright © 2017年 Show gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Replace)


+(NSString *)replaceString:(NSString *)descString
                  keyArray:(NSArray <NSString *> *)keyArray
                valueArray:(NSArray <NSString *> *)valueArray;

@end
