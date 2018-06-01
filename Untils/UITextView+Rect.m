//
//  UIView+Extent.m
//  QinChat
//
//  Created by show gx on 2017/2/22.
//  Copyright © 2017年 zero. All rights reserved.
//

#import "UITextView+Rect.h"
#import "NSObject+Safe.h"
@implementation UITextView (Rect)

#pragma mark - 获取 所有文字frame
- (NSArray<NSValue *>*)getAllCharacterRects{
    NSMutableArray *arrM = [NSMutableArray array];
    for (int charIndex = 0; charIndex< self.text.length; charIndex++) {
        NSRange range = NSMakeRange(charIndex, 1);
        NSString *temp = [self.text substringWithRange:range];
        if ([temp isEqualToString:@" "] || [temp isEqualToString:@"\n"]) {
            continue;
        }
        CGRect rect = [self rectInTextViewWithStringRange:NSMakeRange(charIndex, 1)];
        
        [arrM addObject:DictionaryPixelFormCGRect(rect)];
    }
    return arrM;
}


@end
