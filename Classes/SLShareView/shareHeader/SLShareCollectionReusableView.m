//
//  SLShareCollectionReusableView.m
//  ShowLive
//
//  Created by showgx on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLShareCollectionReusableView.h"
@interface SLShareCollectionReusableView ()

@property(nonatomic,strong)UILabel * shareLabel;

@property(nonatomic,strong)UILabel * headerLabel;

@property(nonatomic,strong)UIView * lineView;


@end
@implementation SLShareCollectionReusableView
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=frame;
       
    
        [self addSubview:self.shareLabel];
        [self addSubview:self.headerLabel];
        [self addSubview:self.lineView];
        
    }
    return self;
    
}

-(UILabel*)shareLabel
{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc]init];
        _shareLabel.frame = CGRectMake(15, 0,40, 37.5);
        _shareLabel.textColor = [UIColor whiteColor];
        _shareLabel.font = [UIFont systemFontOfSize:13];
        _shareLabel.textAlignment = NSTextAlignmentCenter;
        _shareLabel.text = @"分享";
    }
    return _shareLabel;
}

-(UILabel*)headerLabel
{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]init];
        _headerLabel.frame = CGRectMake(24+40, 0,KScreenWidth-64-24, 37.5);
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.font = [UIFont systemFontOfSize:12];
        _headerLabel.textAlignment = NSTextAlignmentRight;
   
        NSString * str = (IsStrEmpty([SLSystemConfigModel shared].share_award_ratio))?@"10":[SLSystemConfigModel shared].share_award_ratio;
        NSString * string = [NSString stringWithFormat:@"分享直播获得主播礼物（%@%%）提成奖励!",str];
        NSMutableAttributedString * mutableAttriStr = [[NSMutableAttributedString alloc] initWithString:string];
        NSDictionary * attris = @{NSForegroundColorAttributeName:Color(@"ec4680"),NSBackgroundColorAttributeName:[UIColor clearColor],NSFontAttributeName: [UIFont boldSystemFontOfSize:16]};
        [mutableAttriStr setAttributes:attris range:NSMakeRange(11,[str length]+1)];
  
        _headerLabel.attributedText = mutableAttriStr;
    }
    return _headerLabel;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.frame = CGRectMake(0, 37.5,KScreenWidth, 0.5);
        _lineView.backgroundColor = kthemeBlackColor;
    }
    return _lineView;
}




@end
