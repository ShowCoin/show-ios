//
//  SLRightMemberTableViewCell.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/25.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLRightMemberTableViewCell.h"

@implementation SLRightMemberTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [self addSubview:self.avatarView];
       
    }
    
    return self;
}

-(void)setModel:(SLMemberListModel *)model
{
    _model = model;
    [self.avatarView setRoundStyle:YES imageUrl:model.avatar imageHeight:30 vip:NO attestation:NO];
}

-(SLHeadPortrait*)avatarView
{
    if (!_avatarView) {
        _avatarView = [[SLHeadPortrait alloc]initWithFrame:CGRectMake(15,0, 30, 30)];
        _avatarView.userInteractionEnabled=YES;
        [_avatarView removeTap];
    }
    return _avatarView;
}

@end
