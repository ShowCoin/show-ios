//
//  ShowHomeMiddleCell.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeMiddleCell.h"

#define cellWith        ((KScreenWidth - 1) / 2)
#define cellHeight      (cellWith/10*16)

@implementation ShowHomeMiddleCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.coverImage];
        [self.contentView addSubview:self.headPortrait];
        [self.contentView addSubview:self.nickName];
        [self.contentView addSubview:self.liveTitle];
        [self.contentView addSubview:self.peopleText];
        [self.contentView addSubview:self.peopleNum];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(cellWith ,cellWith/10*16));
        }];
        [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headPortrait);
            make.left.equalTo(self.headPortrait.mas_right).with.offset(5*Proportion375);
            make.size.mas_equalTo(@(cellWith -  16*Proportion375));
        }];
        [self.liveTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headPortrait.mas_top).with.offset(-4*Proportion375);
            make.left.equalTo(self.headPortrait);
            make.width.equalTo(@(cellWith -  18*Proportion375));
        }];
        
        [self.peopleText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-5*Proportion375);
            make.centerY.equalTo(self.nickName);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 10*Proportion375));
        }];
        [self.peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.peopleText.mas_top).with.offset(-3*Proportion375);
            make.right.equalTo(self.peopleText.mas_right);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 15*Proportion375));
        }];
        
    }
    return self;
}
-(YYAnimatedImageView *)coverImage
{
    if (!_coverImage) {
        _coverImage = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0,cellWith ,cellWith/10*16)];
        _coverImage.contentMode = UIViewContentModeScaleAspectFill;
        [_coverImage setImage:[UIImage imageNamed:@"home_start_img"]];
        _coverImage.clipsToBounds = YES;
//        _coverImage.hidden = YES;
    }
    return _coverImage;
}


-(SLHeadPortrait *)headPortrait
{
    if (!_headPortrait) {
        _headPortrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(8*Proportion375, 20*Proportion375, 15*Proportion375, 15*Proportion375)];
        _headPortrait.bottom = cellHeight - 8*Proportion375;
        _headPortrait.delegate = self;
        
        
    }
    return _headPortrait;
}

-(UILabel *)nickName
{
    if (!_nickName) {
        _nickName = [UILabel labelWithText:@"YiBaiWan" textColor:kThemeWhiteColor font:Font_Regular(11*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _nickName;
}


@end
