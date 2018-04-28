//
//  SLShareCollectionReusableView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/12.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLShareCollectionReusableView.h"
@interface SLShareCollectionReusableView ()

@property(nonatomic,strong)UILabel * headerLabel;

@property(nonatomic,strong)UIView * lineView;


@end
@implementation SLShareCollectionReusableView
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=frame;
    
        [self addSubview:self.headerLabel];
        [self addSubview:self.lineView];
        
    }
    return self;
    
}

-(UILabel*)headerLabel
{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]init];
        _headerLabel.frame = CGRectMake(24, 0,KScreenWidth-48, 41.5);
        _headerLabel.textColor = [UIColor blackColor];
        _headerLabel.font = [UIFont systemFontOfSize:18];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.text = @"分享成功可领红包";
    }
    return _headerLabel;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.frame = CGRectMake(0, 41.5,KScreenWidth, 0.5);
        _lineView.backgroundColor = [UIColor blackColor];
        _lineView.layer.opacity = 0.11;
    }
    return _lineView;
}




@end
