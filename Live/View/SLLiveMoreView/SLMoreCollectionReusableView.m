//
//  SLMoreCollectionReusableView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMoreCollectionReusableView.h"
@interface SLMoreCollectionReusableView ()
@property(nonatomic,strong)UILabel * headerLabel;

@property(nonatomic,strong)UIView * lineView;

@end
@implementation SLMoreCollectionReusableView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=frame;
        
        [self addSubview:self.headerLabel];
     
        
    }
    return self;
    
}

-(UILabel*)headerLabel
{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]init];
        _headerLabel.frame = CGRectMake(24, 0,KScreenWidth-48, 41.5);
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.font = [UIFont systemFontOfSize:18];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.text = @"更多";
    }
    return _headerLabel;
}




@end
