//
//  NSData+JKHash.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/6/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JKHash)
/**
 *  @brief  md5 NSData
 */
@property (readonly) NSData *jk_md5Data;
/**
 *  @brief  sha1Data NSData
 */
@property (readonly) NSData *jk_sha1Data;



@end
