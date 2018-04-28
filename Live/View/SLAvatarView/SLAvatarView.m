//
//  SLAvatarView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLAvatarView.h"
@interface SLAvatarView ()

@property(nonatomic,strong)UIImageView * avatarView;

@end
@implementation SLAvatarView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {

        [self addSubview:self.avatarView];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(self.height/2, self.height/2)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        self.layer.masksToBounds = YES;
    }
    return self;
    
}

-(UIImageView*)avatarView
{
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc]initWithFrame:self.bounds];

    }
    return _avatarView;
}

-(void)setAvatar:(NSString*)url
{
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"tab_userCenter"]];
    
}

@end
