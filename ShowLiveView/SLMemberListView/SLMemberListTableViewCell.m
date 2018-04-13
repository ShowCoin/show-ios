//
//  SLMemberListTableViewCell.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMemberListTableViewCell.h"
#import "SLAvatarView.h"
#import "SLLevelView.h"

@interface SLMemberListTableViewCell ()

@property(nonatomic,strong)SLAvatarView * avatarView;

@property(nonatomic,strong)UILabel * nickNameLabel;

@property(nonatomic,strong)SLLevelView * levelView;

@property(nonatomic,strong)UILabel * cionLabel;

@end
@implementation SLMemberListTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        [self.contentView addSubview:self.avatarView];
        
        [self.contentView addSubview:self.nickNameLabel];
        
        [self.contentView addSubview:self.levelView];
        
        
    }
    
    return self;
}


-(SLAvatarView*)avatarView
{
    if (!_avatarView) {
        _avatarView = [[SLAvatarView alloc]initWithFrame:CGRectMake(24, 17, 40, 40)];
    }
    return _avatarView;
}


-(UILabel*)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.frame = CGRectMake(64+14, 22, 82, 22);
        _nickNameLabel.textColor = [UIColor blackColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:16];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nickNameLabel;
}

-(SLLevelView*)levelView
{
    if (!_levelView) {
        _levelView = [[SLLevelView alloc]initWithFrame:CGRectMake(82+78+5,91, 30, 15)];
    }
    return _levelView;
}


@end
