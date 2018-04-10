//
//  DWTagList.m
//
//  Created by Dominic Wroblewski on 07/07/2012.
//  Copyright (c) 2012 Terracoding LTD. All rights reserved.
//

#import "DWTagList.h"
#import <QuartzCore/QuartzCore.h>

#define CORNER_RADIUS 20
#define LABEL_MARGIN 20  //横向间隔
#define BOTTOM_MARGIN 8  //纵向间隔
#define FONT_SIZE 13.0f     //字体大小
#define HORIZONTAL_PADDING 10//横向内边距
#define VERTICAL_PADDING 5       //纵向内边距
#define BACKGROUND_COLOR [UIColor colorWithRed:246/255 green:248/255 blue:247/255 alpha:1.00]
#define TEXT_SHADOW_COLOR [UIColor whiteColor]
#define TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
#define BORDER_WIDTH 1.0f

@implementation DWTagList
{
    float heng_margin;
    float zong_margin;
    float label_fontSize;
    float heng_padding;
    float zong_padding;
    float label_radius;
    
    NSInteger _type;
}

@synthesize view, textArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:view];
    }
    return self;
}

- (void)setTags:(NSArray *)array
{
    textArray = [[NSArray alloc] initWithArray:array];
    sizeFit = CGSizeZero;
    [self display];
}

- (void)setLabelBackgroundColor:(UIColor *)color withType:(NSInteger)type
{
    if (type == 1) {
        heng_margin = LABEL_MARGIN;
        zong_margin = BOTTOM_MARGIN;
        label_fontSize = FONT_SIZE;
        heng_padding = HORIZONTAL_PADDING;
        zong_padding = VERTICAL_PADDING;
        label_radius = 3;
    }else if (type == 2){
        heng_margin = 8*Proportion375;
        zong_margin = BOTTOM_MARGIN;
        label_fontSize = 11*Proportion375;
        heng_padding = 9*Proportion375;
        zong_padding = 6*Proportion375;
        label_radius = 11.5*Proportion375;
    }else{
        heng_margin = 8*Proportion375;
        zong_margin = 20*Proportion375;
        label_fontSize = 13*Proportion375;
        heng_padding = 9*Proportion375;
        zong_padding = 6*Proportion375;
        label_radius = 11.5*Proportion375;
    }
    lblBackgroundColor = color;
    _type = type;
    [self display];
}

- (void)display
{
    for (UILabel *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    for (NSString *text in textArray) {
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:label_fontSize] constrainedToSize:CGSizeMake(self.frame.size.width, 1500) lineBreakMode:UILineBreakModeWordWrap];
//        textSize.width += heng_padding*2;
//        textSize.height += zong_padding*2;
        textSize.width = (int)textSize.width + heng_padding * 2;
        textSize.height = (int)textSize.height + zong_padding * 2;
        UILabel *label = nil;
        if (!gotPreviousFrame) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
            totalHeight = textSize.height;
        } else {
            CGRect newRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + heng_margin > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + zong_margin);
                totalHeight += textSize.height + zong_margin;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + heng_margin, previousFrame.origin.y);
            }
            newRect.size = textSize;
            label = [[UILabel alloc] initWithFrame:newRect];
        }
        //这一版固定了高度
        if (_type == 2) {
            
            label.width = 58*Proportion375;
        }else if (_type == 3){
            label.width = 76*Proportion375;
            label.height = 30*Proportion375;
        }
        previousFrame = label.frame;
        gotPreviousFrame = YES;
        [label setFont:[UIFont systemFontOfSize:label_fontSize]];
        if (!lblBackgroundColor) {
            [label setBackgroundColor:RGBACOLOR(240, 240, 240, 1)];
        } else {
            [label setBackgroundColor:[UIColor whiteColor]];
        }

        [label setText:text];
        [label setTextAlignment:UITextAlignmentCenter];
//        [label setShadowColor:RGBACOLOR(240, 240, 240, 1)];
//        [label setShadowOffset:TEXT_SHADOW_OFFSET];
        [label.layer setMasksToBounds:YES];
        if (_type == 2) {
            [label setTextColor:kThemeYellowColor];
            [label.layer setBorderColor:kthemeBlackColor.CGColor];
            [label.layer setCornerRadius:4];

        }else{
            [label.layer setBorderColor:kTextGrayColor.CGColor];
            [label setTextColor:kTextGrayColor];
            [label.layer setCornerRadius:label.height/2];

        }
        [label.layer setBorderWidth: 1];
        [label setUserInteractionEnabled:YES];
        //修改
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagClick:)];
        [label addGestureRecognizer:tap];
        
//        UIImageView* imageview = [[UIImageView alloc]initWithImage:@"home_tag_back"];
//        [label addSubview:imageview];
        
        if (totalHeight > self.frame.size.height) {
            
        }else{
            
            [self addSubview:label];
        }
    }
    sizeFit = CGSizeMake(self.frame.size.width, totalHeight + 1);
}

- (CGSize)fittedSize
{
    return sizeFit;
}

-(void)tagClick:(UITapGestureRecognizer *)recognizer{
       UILabel *label=(UILabel*)recognizer.view;
    if (_delegate) {
        if (_type == 3) {
            
            [label.layer setBorderColor:kThemeYellowColor.CGColor];
            [label setTextColor:kThemeYellowColor];
            UIImageView* imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_tag_back"]];
            imageview.right = label.right;
            imageview.top = label.top;
            [self addSubview:imageview];
        }
        
        [_delegate clickWithStr:label.text];
    }
}


@end
