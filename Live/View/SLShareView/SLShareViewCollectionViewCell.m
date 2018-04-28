//
//  SLShareViewCollectionViewCell.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLShareViewCollectionViewCell.h"

@interface SLShareViewCollectionViewCell ()

@property(nonatomic,strong)UIImageView * platformImageView;

@property(nonatomic,strong)UILabel * platformLabel;


@end
@implementation SLShareViewCollectionViewCell


-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.platformImageView];
        [self.contentView addSubview:self.platformLabel];

    }
    return self;
    
}

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    [self.platformImageView setImage:[UIImage imageNamed:[dict valueForKey:@"image"]]];
    [self.platformLabel setText:[dict valueForKey:@"title"]];
}

-(UIImageView*)platformImageView
{
    if (!_platformImageView) {
        _platformImageView = [[UIImageView alloc]init];
        _platformImageView.frame = CGRectMake(3, 3, 44, 44);
    }
    return _platformImageView;
}

-(UILabel*)platformLabel
{
    if (!_platformLabel) {
        _platformLabel =  [[UILabel alloc]init];
        _platformLabel.frame =CGRectMake(-10, 51, 70, 17);
        _platformLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
        _platformLabel.font = [UIFont systemFontOfSize:14];
        _platformLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _platformLabel;
    
}
@end
