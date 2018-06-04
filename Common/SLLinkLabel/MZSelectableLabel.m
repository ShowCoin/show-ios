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
@end
