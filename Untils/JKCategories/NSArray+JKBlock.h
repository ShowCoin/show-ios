//
//  NSArray+Block.h
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JKBlock)
//循环遍历
- (void)jk_each:(void (^)(id object))block;
//根据下标遍历
- (void)jk_eachWithIndex:(void (^)(id object, NSUInteger index))block;
//map
- (NSArray *)jk_map:(id (^)(id object))block;
//过滤
- (NSArray *)jk_filter:(BOOL (^)(id object))block;
//拒绝
- (NSArray *)jk_reject:(BOOL (^)(id object))block;
//删除
- (id)jk_detect:(BOOL (^)(id object))block;
//转化
- (id)jk_reduce:(id (^)(id accumulator, id object))block;
//带block的转化
- (id)jk_reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;


@end
