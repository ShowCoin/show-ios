//
//  SLTopMemberViewCollectionViewCell.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLTopMemberViewCollectionViewCell.h"
#import "SLAvatarView.h"
@interface SLTopMemberViewCollectionViewCell ()

@property(nonatomic,strong)SLAvatarView * avatarView;

@end
@implementation SLTopMemberViewCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
    
        [self.contentView addSubview:self.avatarView];

        [self.avatarView setAvatar:@"http://static.tongyigg.com/images/41b47ccc1dfbcd68d23a0f4de924bca7.jpg"];
    }
    return self;
}
-(SLAvatarView*)avatarView
{
    if (!_avatarView) {
        _avatarView = [[SLAvatarView alloc]initWithFrame:CGRectMake(0,0, 30, 30)];
        _avatarView.userInteractionEnabled=YES;
    }
    return _avatarView;
}
@end
