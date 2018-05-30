//
//  SLVerticalAlignLabel.m
//  ShowLive
//
//  Created by iori_chou on 2018/5/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLVerticalAlignLabel.h"

@implementation SLVerticalAlignLabel
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.verticalAlignment=VerticalAlignmentMiddle;
    }
    return self;
}
-(void)setVerticalAlignment:(VerticalAlignment)verticalAlignment
{
    _verticalAlignment=verticalAlignment;
    [self setNeedsDisplay];//重绘
}

-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect=[super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch(self.verticalAlignment)
    {
        case VerticalAlignmentTop:
            textRect.origin.y=bounds.origin.y;
            break;
        case VerticalAlignmentMiddle:
            textRect.origin.y=bounds.origin.y+(bounds.size.height-textRect.size.height)/2.0;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y=bounds.origin.y+bounds.size.height-textRect.size.height;
            break;
        default:
            textRect.origin.y=bounds.origin.y+(bounds.size.height-textRect.size.height)/2.0;
            break;
    }
    return textRect;
}
-(void)drawTextInRect:(CGRect)rect
{
    CGRect actualRect=[self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];//重新计算位置
    [super drawTextInRect:actualRect];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
