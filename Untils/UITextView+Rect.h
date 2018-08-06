//
//  UIView+Extent.h
//  QinChat
//
//  Created by show on 2017/2/22.
//  Copyright © 2017年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Rect)
- (NSArray<NSValue *>*)getAllCharacterRects;

#pragma mark - 获取textView 每一个字符的frame
- (CGRect)rectInTextViewWithStringRange:(NSRange)stringRange;
@end
