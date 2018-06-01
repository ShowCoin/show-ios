//
//  SLShareViewCollectionViewCell.m
//  ShowLive
//
//  Created by showgx on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLShareViewCollectionViewCell.h"
#import "SLShadowLabel.h"
@interface SLShareViewCollectionViewCell ()

@property(nonatomic,strong)UIImageView * platformImageView;

@property(nonatomic,strong)SLShadowLabel * platformLabel;


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
        _platformImageView.frame = CGRectMake(0,0, 45,45);
    }
    return _platformImageView;
}

-(SLShadowLabel*)platformLabel
{
    if (!_platformLabel) {
        _platformLabel =  [[SLShadowLabel alloc]init];
        _platformLabel.frame =CGRectMake(-10, 45, 70, 17);
        _platformLabel.textColor = [UIColor whiteColor];
        _platformLabel.font = [UIFont systemFontOfSize:10];
        _platformLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _platformLabel;
    
}
@end
