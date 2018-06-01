//
//  SLLiveShareCollectionViewCell.m
//  ShowLive
//
//  Created by showgx on 2018/5/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveShareCollectionViewCell.h"
@interface SLLiveShareCollectionViewCell ()

@property(nonatomic,strong)UIImageView * platformImageView;


@end


@implementation SLLiveShareCollectionViewCell


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
        _platformImageView.frame = CGRectMake(0,0,45, 45);
    }
    return _platformImageView;
}

-(UILabel*)platformLabel
{
    if (!_platformLabel) {
        _platformLabel =  [[UILabel alloc]init];
        _platformLabel.frame =CGRectMake(-10, 45, 65, 17);
        _platformLabel.textColor = [UIColor grayColor];
        _platformLabel.font = [UIFont systemFontOfSize:10];
        _platformLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _platformLabel;
    
}
@end
