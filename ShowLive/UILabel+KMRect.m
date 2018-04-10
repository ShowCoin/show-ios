//
//  UILabel+KMRect.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "UILabel+KMRect.h"

@implementation UILabel (KMRect)

- (CGRect)stringRect:(NSString *)string{
    if (self.attributedText == nil) {
        return CGRectZero;
    }

    NSTextStorage *textStorage = [NSTextStorage new];
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    NSTextContainer *textContainer = [NSTextContainer new];
    [textStorage addLayoutManager:layoutManager];
    [layoutManager addTextContainer:textContainer];
    
    textContainer.size = self.bounds.size;
    textContainer.lineFragmentPadding = 0;
    textContainer.maximumNumberOfLines = self.numberOfLines;
    textContainer.lineBreakMode = self.lineBreakMode;
    [textStorage setAttributedString:self.attributedText];
    
    NSRange characterRange = [self.attributedText.string rangeOfString:string];
    NSRange glyphRange = [layoutManager glyphRangeForCharacterRange:characterRange actualCharacterRange:nil];
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}

@end
