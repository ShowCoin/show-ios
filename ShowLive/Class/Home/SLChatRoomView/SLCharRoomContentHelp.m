//
//  SLCharRoomContentHelp.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLCharRoomContentHelp.h"
#import "YYText.h"

typedef NS_ENUM(NSInteger,Chat_User_level){
    Chat_User_level_low = 1,
    Chat_User_level_heigh = 2
} ;

@implementation SLCharRoomContentHelp

+(NSAttributedString *)contentAttributedString:(NSString *)content{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]init];
    
    UIView *diamoundCountView = [self userLevelView];
    NSMutableAttributedString * attachment1 = [NSMutableAttributedString yy_attachmentStringWithContent:diamoundCountView contentMode:UIViewContentModeCenter attachmentSize:diamoundCountView.frame.size alignToFont:[UIFont systemFontOfSize:15.0f] alignment:YYTextVerticalAlignmentCenter];
    
    [text appendAttributedString:attachment1];
//    // 嵌入 UIImage
//    UIImage *image = [UIImage imageNamed:@"tab_userCenter"];
//    NSMutableAttributedString *attachment = nil;
//    attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(15.0f, 15.0f) alignToFont:[UIFont systemFontOfSize:15.0f] alignment:YYTextVerticalAlignmentCenter];
//    [text appendAttributedString: attachment];
 
//
    NSMutableAttributedString *edageContent = [[NSMutableAttributedString alloc] initWithString:@"  "];
    [text appendAttributedString:edageContent];

    NSMutableAttributedString *textContent = [[NSMutableAttributedString alloc] initWithString:content];
    // 2. Set attributes to text, you can use almost all CoreText attributes.
    textContent.yy_font = [UIFont boldSystemFontOfSize:15];
    textContent.yy_color = [UIColor whiteColor];
    text.yy_lineSpacing = 2;
    [text appendAttributedString:textContent];
    
    return text;
}


+(UIView *)diamondCountView{
    UIView *diamondCountView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 28, 15)];
    diamondCountView.backgroundColor = [UIColor greenColor];
    UILabel *countLabel = [[UILabel alloc]init];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.textAlignment = NSTextAlignmentCenter    ;
    countLabel.text = @"12";
    countLabel.font = [UIFont systemFontOfSize:10];
    [diamondCountView addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(diamondCountView);
    }];
    return diamondCountView;
}
//chat_user_levelheigh chat_user_levellow
+ (UIView *)userLevelView {
    
    NSInteger a  = arc4random()%5;
    
    UIImageView *levelView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30.5, 16.5)];
    if(a % 2 ==0){
        levelView.image = [UIImage imageNamed:@"chat_user_levelheigh"];
        a += 10 ;
    }else{
        levelView.image = [UIImage imageNamed:@"chat_user_levellow"];
    }
    UILabel *countlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25.5, 16.5)];
    countlabel.textColor = [UIColor whiteColor];
    countlabel.font = [UIFont systemFontOfSize:10];
    countlabel.text = [NSString stringWithFormat:@"%d",a];
    countlabel.textAlignment = NSTextAlignmentRight;
    [levelView addSubview:countlabel];
    return levelView ;
}


@end
