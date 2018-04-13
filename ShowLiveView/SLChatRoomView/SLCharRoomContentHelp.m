//
//  SLCharRoomContentHelp.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLCharRoomContentHelp.h"
#import "YYText.h"

@implementation SLCharRoomContentHelp

+(NSAttributedString *)contentAttributedString:(NSString *)content{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]init];
    
    UIView *diamoundCountView = [self diamondCountView];
    NSMutableAttributedString * attachment1 = [NSMutableAttributedString yy_attachmentStringWithContent:diamoundCountView contentMode:UIViewContentModeCenter attachmentSize:diamoundCountView.frame.size alignToFont:[UIFont systemFontOfSize:15.0f] alignment:YYTextVerticalAlignmentCenter];
    
    [text appendAttributedString:attachment1];
    // 嵌入 UIImage
    UIImage *image = [UIImage imageNamed:@"tab_userCenter"];
    NSMutableAttributedString *attachment = nil;
    attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(15.0f, 15.0f) alignToFont:[UIFont systemFontOfSize:15.0f] alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString: attachment];
 
//
    NSMutableAttributedString *textContent = [[NSMutableAttributedString alloc] initWithString:content];
    // 2. Set attributes to text, you can use almost all CoreText attributes.
    textContent.yy_font = [UIFont boldSystemFontOfSize:15];
    textContent.yy_color = [UIColor whiteColor];
    text.yy_lineSpacing = 2;
    text.yy_firstLineHeadIndent  = 8 ;
    [text appendAttributedString:textContent];
    
    return text;
}


+(UIView *)diamondCountView{
    UIView *diamondCountView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 28, 15)];
    diamondCountView.backgroundColor = [UIColor whiteColor];
//    UILabel *countlabel = [[UILabel alloc]init];
//    countlabel.text = @"22";
//    countlabel.textColor= [UIColor whiteColor];
//    countlabel.font = [UIFont systemFontOfSize:6.0f];
//    [diamondCountView addSubview:countlabel];
    return diamondCountView;
    
}

@end
