//
//  SLLinkLabel.m
//  ShowLive
//
//  Created by vning on 2018/5/31.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLinkLabel.h"

@implementation SLLinkLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addCopyForLabel];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self addCopyForLabel];
}
#pragma mark -- 可复制

- (void)addCopyForLabel
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longTouch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouchAction:)];
    longTouch.minimumPressDuration = 1;
    [self addGestureRecognizer:longTouch];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return action == @selector(copyTextInThisLabel:);
}

- (void)copyTextInThisLabel:(id)sender {
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.text;
}

- (void)longTouchAction:(UIGestureRecognizer *)recognizer {
    [self becomeFirstResponder];
    UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyTextInThisLabel:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyItem, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

#pragma mark -- 超链接

- (void)urlAndIphoneValidation:(NSString *)string{
    [self urlValidation:string];
}

- (void)urlValidation:(NSString *)string {
    if (!string || string == nil) {
        return;
    }
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSError *error;
    //识别链接的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSString *iphoneStr = @"\\d{3,4}[- ]?\\d{7,8}";
    
    //与string做对比并获得超链接在string中的位置
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *iphoneRegex = [NSRegularExpression regularExpressionWithPattern:iphoneStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSMutableArray *arrayOfAllMatches = [NSMutableArray arrayWithArray:[regex matchesInString:string options:0 range:NSMakeRange(0, [string length])]];
    NSArray *iphoneArr = [NSMutableArray arrayWithArray:[iphoneRegex matchesInString:string options:0 range:NSMakeRange(0, [string length])]];
    [arrayOfAllMatches addObjectsFromArray:iphoneArr];
    
    NSMutableArray *urlStrs = [NSMutableArray array];
    
    NSMutableArray *urlRanges = [NSMutableArray array];
    
    // 行间距
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
//    [paragraphStyle setLineSpacing:8];
    
    NSDictionary *allPerferDic = @{
                                   
                                   NSForegroundColorAttributeName : kGrayWith999999,
                                   
                                   NSFontAttributeName            : [UIFont systemFontOfSize:12*Proportion375],
                                   
                                   NSParagraphStyleAttributeName  : paragraphStyle
                                   
                                   };
    
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:string];
    
    [mas setAttributes:allPerferDic range:NSMakeRange(0, string.length)];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        
        NSString* substringForMatch = [string substringWithRange:match.range];
        
        NSURL *url = [NSURL URLWithString:substringForMatch];
        
        if (!url) {continue;}
        
        [urlStrs addObject:[NSURL URLWithString:substringForMatch]];
        
        [urlRanges addObject:[NSValue valueWithRange:match.range]];
        
    }
    
    [urlRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        [mas addAttributes:@
         
         {
             
             NSForegroundColorAttributeName : HexRGBAlpha(0x40cfff, 1),
             
             NSFontAttributeName            : [UIFont systemFontOfSize:12*Proportion375]
             
         } range:[obj rangeValue]];
        
    }];
    
    self.attributedText = mas;
    
    self.userInteractionEnabled = YES;
    
    if (!urlStrs.count) { return;}
    for (int i = 0; i<urlStrs.count; i++) {
        NSRange range = [urlRanges[i] rangeValue];
        //设置超链接选中后的背景色
        [self setSelectableRange:range hightlightedBackgroundColor:[UIColor lightGrayColor]];
        //点击超链接将要实现的方法
        self.selectionHandler = ^(NSRange range, NSString *string){
            NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:string,@"url",nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"webLinks" object:nil userInfo:dic];
        };
    }
}

@end
