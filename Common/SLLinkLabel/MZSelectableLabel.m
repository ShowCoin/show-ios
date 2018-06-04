/**********************************************************************************
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2014 Michał Zaborowski
 *
 * This project is an rewritten version of the KILabel
 *
 * https://x/Krelborn/KILabel
 ***********************************************************************************
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2013 Matthew Styles
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 ***********************************************************************************/

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "MZSelectableLabel.h"
#import "UIColor+Equalable.h"

@interface MZSelectableLabel () <NSLayoutManagerDelegate>

// Used to control layout of glyphs and rendering
@property (nonatomic, retain) NSLayoutManager *layoutManager;

// Specifies the space in which to render text
@property (nonatomic, retain) NSTextContainer *textContainer;

// Backing storage for text that is rendered by the layout manager
@property (nonatomic, retain) NSTextStorage *textStorage;

// State used to trag if the user has dragged during a touch
@property (nonatomic, assign) BOOL isTouchMoved;

// During a touch, range of text that is displayed as selected
@property (nonatomic, assign) NSRange selectedRange;

@end

@implementation MZSelectableLabel

#pragma mark - Construction

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupTextSystem];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupTextSystem];
    }
    return self;
}

// Common initialisation. Must be done once during construction.
- (void)setupTextSystem
{
    _selectableRanges = [NSMutableArray array];
    // Create a text container and set it up to match our label properties
    self.textContainer = [[NSTextContainer alloc] init];
    self.textContainer.lineFragmentPadding = 0;
    self.textContainer.maximumNumberOfLines = self.numberOfLines;
    self.textContainer.lineBreakMode = self.lineBreakMode;
    self.textContainer.size = self.frame.size;
    
    // Create a layout manager for rendering
    self.layoutManager = [[NSLayoutManager alloc] init];
    self.layoutManager.delegate = self;
    [self.layoutManager addTextContainer:self.textContainer];
    
    // Attach the layou manager to the container and storage
    [self.textContainer setLayoutManager:self.layoutManager];
    
    // Make sure user interaction is enabled so we can accept touches
    self.userInteractionEnabled = YES;
    
    // Establish the text store with our current text
    [self updateTextStoreWithText];
    
}

#pragma mark - Text Storage Management

- (void)setSkipColorForAutomaticDetection:(UIColor *)skipColorForAutomaticDetection
{
    _skipColorForAutomaticDetection = skipColorForAutomaticDetection;
    self.automaticForegroundColorDetectionEnabled = _automaticForegroundColorDetectionEnabled;
}

- (void)setAutomaticDetectionBackgroundHighlightColor:(UIColor *)automaticDetectionBackgroundHighlightColor
{
    _automaticDetectionBackgroundHighlightColor = automaticDetectionBackgroundHighlightColor;
    self.automaticForegroundColorDetectionEnabled = _automaticForegroundColorDetectionEnabled;
}

- (void)setAutomaticForegroundColorDetectionEnabled:(BOOL)automaticForegroundColorDetectionEnabled
{
    _automaticForegroundColorDetectionEnabled = automaticForegroundColorDetectionEnabled;
    
    if (automaticForegroundColorDetectionEnabled) {
        __weak typeof(self) weakSelf = self;
        
        NSMutableArray *ranges = [NSMutableArray array];
        [self.attributedText enumerateAttribute:NSForegroundColorAttributeName
                            inRange:NSMakeRange(0,self.attributedText.length)
                            options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                         usingBlock:^(id value, NSRange range, BOOL *stop)
        {
            if (!weakSelf.skipColorForAutomaticDetection || (weakSelf.skipColorForAutomaticDetection && ![weakSelf.skipColorForAutomaticDetection isEqualToColor:value])) {
                [ranges addObject:[MZSelectableLabelRange selectableRangeWithRange:range color:self.automaticDetectionBackgroundHighlightColor]];
            }

        }];
        self.detectedSelectableRanges = [ranges copy];

    } else {
        self.detectedSelectableRanges = nil;
    }
    [self updateTextStoreWithText];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self updateTextStoreWithText];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self updateTextStoreWithText];
}

- (void)setSelectableRange:(NSRange)range hightlightedBackgroundColor:(UIColor *)color
{
    [self.selectableRanges addObject:[MZSelectableLabelRange selectableRangeWithRange:range color:color]];
}

- (void)setSelectableRange:(NSRange)range
{
    [self setSelectableRange:range hightlightedBackgroundColor:nil];
}

// Applies background colour to selected range. Used to hilight touched links
- (void)setSelectedRange:(NSRange)range
{
    // Remove the current selection if the selection is changing
    if (self.selectedRange.length && !NSEqualRanges(self.selectedRange, range))
    {
        [self.textStorage removeAttribute:NSBackgroundColorAttributeName
                                    range:self.selectedRange];
    }
    
    MZSelectableLabelRange *selectedRange = [self rangeValueAtRange:range];
    
    // Apply the new selection to the text
    if (range.length && selectedRange && selectedRange.color)
    {
        [self.textStorage addAttribute:NSBackgroundColorAttributeName
                                 value:selectedRange.color
                                 range:range];
    }
    
    // Save the new range
    _selectedRange = range;
    
    [self setNeedsDisplay];
}

- (void)updateTextStoreWithText
{
    // Now update our storage from either the attributedString or the plain text
    if (self.attributedText)
    {
        [self updateTextStoreWithAttributedString:self.attributedText];
    }
    else if (self.text)
    {
        [self updateTextStoreWithAttributedString:[[NSAttributedString alloc] initWithString:self.text attributes:[self attributesFromProperties]]];
    }
    else
    {
        [self updateTextStoreWithAttributedString:[[NSAttributedString alloc] initWithString:@"" attributes:[self attributesFromProperties]]];
    }
    
    [self setNeedsDisplay];
}

- (void)updateTextStoreWithAttributedString:(NSAttributedString *)attributedString
{
    if (attributedString.length != 0)
    {
        attributedString = [MZSelectableLabel sanitizeAttributedString:attributedString];
    }
    
    if (self.textStorage)
    {
        // Set the string on the storage
        [self.textStorage setAttributedString:attributedString];
    }
    else
    {
        // Create a new text storage and attach it correctly to the layout manager
        self.textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
        [self.textStorage addLayoutManager:self.layoutManager];
        [self.layoutManager setTextStorage:self.textStorage];
    }
}

- (MZSelectableLabelRange *)rangeValueAtRange:(NSRange)range
{
    for (MZSelectableLabelRange *selectableRange in self.selectableRanges) {
        if (NSEqualRanges(selectableRange.range, range)) {
            return selectableRange;
        }
    }
    
    for (MZSelectableLabelRange *selectableRange in self.detectedSelectableRanges) {
        if (NSEqualRanges(selectableRange.range, range)) {
            return selectableRange;
        }
    }
    
    return nil;
}


- (MZSelectableLabelRange *)rangeValueAtLocation:(CGPoint)location
{
    // Do nothing if we have no text
    if (self.textStorage.string.length == 0)
    {
        return nil;
    }
    
    // Work out the offset of the text in the view
    CGPoint textOffset;
    NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    textOffset = [self calcTextOffsetForGlyphRange:glyphRange];
    
    // Get the touch location and use text offset to convert to text cotainer coords
    location.x -= textOffset.x;
    location.y -= textOffset.y;
    
    NSUInteger touchedChar = [self.layoutManager glyphIndexForPoint:location inTextContainer:self.textContainer];
    
    // If the touch is in white space after the last glyph on the line we don't
    // count it as a hit on the text
    NSRange lineRange;
    CGRect lineRect = [self.layoutManager lineFragmentUsedRectForGlyphAtIndex:touchedChar effectiveRange:&lineRange];
    if (CGRectContainsPoint(lineRect, location) == NO)
    {
        return nil;
    }
    
    // Find the word that was touched and call the detection block
    for (MZSelectableLabelRange *rangeValue in self.selectableRanges)
    {
        NSRange range = rangeValue.range;
        
        if ((touchedChar >= range.location) && touchedChar < (range.location + range.length))
        {
            return rangeValue;
        }
    }
    
    for (MZSelectableLabelRange *rangeValue in self.detectedSelectableRanges)
    {
        NSRange range = rangeValue.range;
        
        if ((touchedChar >= range.location) && touchedChar < (range.location + range.length))
        {
            return rangeValue;
        }
    }
    
    return nil;
}

// Returns the XY offset of the range of glyphs from the view's origin
@end
