//
//  SLMessageListHeader.m
//  ShowLive
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLMessageListHeader.h"
@interface SLMessageListHeader ()
@property (nonatomic,strong)UIButton * fans;
@property (nonatomic,strong)UIButton * like;
@property (nonatomic,strong)UIButton * atMe;
@property (nonatomic,strong)UIButton * comment;
@end
@implementation SLMessageListHeader
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.fans];
        [self addSubview:self.like];
        [self addSubview:self.atMe];
        [self addSubview:self.comment];
    }
    return self;
}
-(UIButton *)fans
{
    if (!_fans) {
        _fans=[UIButton buttonWithType:UIButtonTypeCustom];
        _fans.frame=CGRectMake((kMainScreenWidth - 320*Proportion375)/2, 15*Proportion375, 80*Proportion375, 70*Proportion375);
        [_fans setImage:[UIImage imageNamed:@"userhome_avatar_image"] forState:UIControlStateNormal];
        [_fans setTitle:@"粉丝" forState:UIControlStateNormal];
        [_fans setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_fans layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        [[_fans rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        }];
    }
    return _fans;
}
-(UIButton *)like
{
    if (!_like) {
        _like=[UIButton buttonWithType:UIButtonTypeCustom];
        _like.frame=CGRectMake(_fans.right, 15*Proportion375, 80*Proportion375, 70*Proportion375);
        [_like setImage:[UIImage imageNamed:@"userhome_avatar_image"] forState:UIControlStateNormal];
        [_like setTitle:@"赞" forState:UIControlStateNormal];
        [_like setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_like layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        [[_like rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
        }];
    }
    return _like;
}
-(UIButton *)atMe
{
    if (!_atMe) {
        _atMe=[UIButton buttonWithType:UIButtonTypeCustom];
        _atMe.frame=CGRectMake(_like.right, 15*Proportion375, 80*Proportion375, 70*Proportion375);
        [_atMe setImage:[UIImage imageNamed:@"userhome_avatar_image"] forState:UIControlStateNormal];
        [_atMe setTitle:@"@我的" forState:UIControlStateNormal];
        [_atMe setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_atMe layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        [[_atMe rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
        }];
    }
    return _atMe;
}
-(UIButton *)comment
{
    if (!_comment) {
        _comment=[UIButton buttonWithType:UIButtonTypeCustom];
        _comment.frame=CGRectMake(_atMe.right, 15*Proportion375, 80*Proportion375, 70*Proportion375);
        [_comment setImage:[UIImage imageNamed:@"userhome_avatar_image"] forState:UIControlStateNormal];
        [_comment setTitle:@"评论" forState:UIControlStateNormal];
        [_comment setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        [_comment layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        [[_comment rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
        }];
    }
    return _comment;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
