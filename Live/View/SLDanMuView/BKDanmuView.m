//
//  BKDanmuView.m
//  Show
//
//  Created by Mac on 16/6/13.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import "SLDanmuView.h"

#import "UILabel+Extend.h"
#import "UIImage+Additions.h"
#import "BKMessageInfo.h"
@interface SLDanmuView()
{
    BOOL _total;
}

@end
@implementation SLDanmuView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSubViews];
    }
    return self;
}

- (void)dealloc
{
    /// 移除消息
    [[NSNotificationCenter defaultCenter] removeObserver:self];;
    
}

- (void)initSubViews
{
    _headerView = [[HeadPortrait alloc] initWithFrame:CGRectMake(0 , 0, Proportion375 *30, Proportion375 *30)];
    _headerView.userInteractionEnabled = YES;
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.frame = CGRectMake(Proportion375 *27,0, kMainScreenWidth, Proportion375 *12);
    self.nameLabel.font=[UIFont boldSystemFontOfSize:12];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor=RGBACOLOR(181,162,85,1);
    [self addSubview:self.nameLabel];
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.backgroundColor=RGBACOLOR(33, 33, 33, .3);
    self.numberLabel.frame = CGRectMake(Proportion375 *27, Proportion375 *13, kMainScreenWidth, Proportion375 *17);
    self.numberLabel.font=[UIFont systemFontOfSize:13];
    self.numberLabel.textAlignment = NSTextAlignmentLeft;
    _numberLabel.textColor=[UIColor whiteColor];
    [self addSubview:self.numberLabel];
    [self addSubview:_headerView];
    
}

-(void)reloadMessageInfoData:(BKMessageInfo *)MessageInfo
{
    if (!_total)
    {
        NSDictionary * dic=[MessageInfo valueForKey:@"data"];
        _nameLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]];
        _numberLabel.text=[NSString stringWithFormat:@"   %@",[dic objectForKey:@"content"]];
        [_nameLabel sizeToFit];
        [_numberLabel sizeToFit];
        _numberLabel.left=_headerView.right-8;
        _numberLabel.width=_numberLabel.width+5;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.numberLabel.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(self.numberLabel.height/2, self.numberLabel.height/2)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.numberLabel.bounds;
        maskLayer.path = maskPath.CGPath;
        self.numberLabel.layer.mask = maskLayer;
        [_headerView setRoundStyle:YES imageUrl:[dic objectForKey:@"profileImg"] imageHeight:0];
        if ([[dic objectForKey:@"isVip"]integerValue]==0)
        {
            _headerView.imageV.hidden=YES;
        }
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
