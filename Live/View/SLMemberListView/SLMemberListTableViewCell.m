//
//  SLMemberListTableViewCell.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMemberListTableViewCell.h"
#import "SLHeadPortrait.h"
#import "SLLevelMarkView.h"
@interface SLMemberListTableViewCell ()

@property(nonatomic,strong)SLHeadPortrait * avatarView;

@property(nonatomic,strong)UILabel * nickNameLabel;

@property(nonatomic,strong)UIImageView * sexImageView;

@property(nonatomic,strong)SLLevelMarkView * levelView;

@property(nonatomic,strong)UILabel * cionLabel;

@end
@implementation SLMemberListTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.nickNameLabel];
        [self.contentView addSubview:self.sexImageView];
        [self.contentView addSubview:self.levelView];
    }
    
    return self;
}

-(void)setModel:(SLMemberListModel *)model
{
    _model = model;
    
    [self.avatarView setRoundStyle:YES imageUrl:model.avatar imageHeight:40 vip:NO attestation:NO];
    self.nickNameLabel.text = [NSString stringWithFormat:@"%@",model.nickName];

    if (model.gender == 1) {
        [self.sexImageView setImage:[UIImage imageNamed:@"userhome_sex_man"]];
    }else
    {
        [self.sexImageView setImage:[UIImage imageNamed:@"userhome_sex_women"]];
    }
    _levelView.level  =[NSString stringWithFormat:@"%ld",model.fanLevel];
}

-(SLHeadPortrait*)avatarView
{
    if (!_avatarView) {
        _avatarView = [[SLHeadPortrait alloc]initWithFrame:CGRectMake(24, 5, 40, 40)];
    
    }
    return _avatarView;
}


-(UILabel*)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.frame = CGRectMake(64+14,10,KScreenWidth-100, 18);
        _nickNameLabel.textColor = [UIColor blackColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:14];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nickNameLabel;
}

-(UIImageView*)sexImageView
{
    if (!_sexImageView) {
        _sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(64+14, 30, 15, 15)];
    }
    return _sexImageView;
}

-(SLLevelMarkView*)levelView
{
    if (!_levelView) {
        _levelView = [[SLLevelMarkView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sexImageView.frame)+5,30, 30, 15) withType:LevelType_ShowCoin];
    }
    return _levelView;
}


@end
