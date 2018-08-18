//
//  SLControlLabel.m
//  Edu
//
//  Created by chenyh on 2018/8/15.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLControlLabel.h"

@implementation SLControlLabel {
    UILabel *_textLabel;
}

/**
 initWithFrame

 @param frame frame
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
    }
    return self;
}

/**
 layoutSubviews
 */
- (void)layoutSubviews {
    _textLabel.frame = self.bounds;
}


/**
 @synthesize
 */
@synthesize attributedText = _attributedText;

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    _textLabel.attributedText = attributedText;
}

- (NSAttributedString *)attributedText {
    return _textLabel.attributedText;
}

@end
