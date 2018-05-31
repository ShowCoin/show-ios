//
//  SLMoreCollectionReusableView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMoreCollectionReusableView.h"

@interface SLMoreCollectionReusableView ()

@property (nonatomic, strong) UILabel * headerLabel;
@property (nonatomic, strong) UIView * lineView;

@end

@implementation SLMoreCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=frame;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.headerLabel];
        [self addSubview:self.lineView];
    }
    return self;
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 41.5, KScreenWidth, 0.5)];
        _lineView.backgroundColor =  kthemeBlackColor;
    }
    return _lineView;
}

- (UILabel*)headerLabel
{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]init];
        _headerLabel.frame = CGRectMake(24, 0,
                                        KScreenWidth - 48, 41.5);
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.font = [UIFont systemFontOfSize:16];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.text = @"更多";
    }
    return _headerLabel;
}

@end
