//
//  UITextField+Blocks.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UITextField (JKBlocks)
//开始编辑的BLOCK
@property (copy, nonatomic) BOOL (^jk_shouldBegindEditingBlock)(UITextField *textField);
//是否开始编辑的BLOCK
@property (copy, nonatomic) BOOL (^jk_shouldEndEditingBlock)(UITextField *textField);
//是否已经开始编辑的BLOCK
@property (copy, nonatomic) void (^jk_didBeginEditingBlock)(UITextField *textField);
//已经结束编辑的BLOCK
@property (copy, nonatomic) void (^jk_didEndEditingBlock)(UITextField *textField);
//是否替换的问题
@property (copy, nonatomic) BOOL (^jk_shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
//是否回车的问题
@property (copy, nonatomic) BOOL (^jk_shouldReturnBlock)(UITextField *textField);
//是否消除的问题
@property (copy, nonatomic) BOOL (^jk_shouldClearBlock)(UITextField *textField);

//是否开始编辑的问题
- (void)setJk_shouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
//是否结束编辑的问题
- (void)setJk_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
//是否已经开始编辑的问题
- (void)setJk_didBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
//是否已经结束编辑的问题
- (void)setJk_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
//是否替换的问题
- (void)setJk_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
//清除的block
- (void)setJk_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
//回撤的问题
- (void)setJk_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;

@end
