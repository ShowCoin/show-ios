//
//  NSSet+Block.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (JKBlock)

//each 操作
- (void)jk_each:(void (^)(id))block;
//each index操作
- (void)jk_eachWithIndex:(void (^)(id, int))block;
//each map操作
- (NSArray *)jk_map:(id (^)(id object))block;
//each select操作
- (NSArray *)jk_select:(BOOL (^)(id object))block;
//each jk_reject操作
- (NSArray *)jk_reject:(BOOL (^)(id object))block;
//each 排序算法
- (NSArray *)jk_sort;
// 聚合操作
- (id)jk_reduce:(id(^)(id accumulator, id object))block;
// block聚合
- (id)jk_reduce:(id)initial withBlock:(id(^)(id accumulator, id object))block;
@end
