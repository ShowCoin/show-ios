//
//  SLPlayerBottomCollectionViewCell.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPlayerBottomCollectionViewCell.h"

@interface SLPlayerBottomCollectionViewCell()

@property(nonatomic,strong)UIImageView * imageView;

@property(nonatomic,strong)UIView * redPointView;


@end
@implementation SLPlayerBottomCollectionViewCell


-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.imageView];
        [self addSubview:self.redPointView];
    }
    return self;
    
}

-(UIView*)redPointView
{
    if (!_redPointView) {
        _redPointView         = [[UIView alloc]initWithFrame:CGRectMake(31, 7, 8, 8)];
        _redPointView.backgroundColor = [UIColor redColor];
        _redPointView.layer.cornerRadius = 4;

    }
    return _redPointView;
}

-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 38, 38)];
        _imageView.layer.cornerRadius = 19;
        _imageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _imageView;
}

@end
