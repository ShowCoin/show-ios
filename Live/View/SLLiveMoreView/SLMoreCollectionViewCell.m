//
//  SLMoreCollectionViewCell.m
//  ShowLive
//
//  Created by gongxin on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMoreCollectionViewCell.h"

@interface SLMoreCollectionViewCell ()

@property(nonatomic,strong)UIImageView * imageView;

@property(nonatomic,strong)UILabel * label;


@end
@implementation SLMoreCollectionViewCell


-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.label];
        
    }
    return self;
    
}

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    [self.imageView setImage:[UIImage imageNamed:[dict valueForKey:@"image"]]];
    [self.label setText:[dict valueForKey:@"title"]];
}

-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(3, 3, 44, 44);
    }
    return _imageView;
}

-(UILabel*)label
{
    if (!_label) {
        _label =  [[UILabel alloc]init];
        _label.frame =CGRectMake(-10, 51, 70, 17);
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
    
}

@end
