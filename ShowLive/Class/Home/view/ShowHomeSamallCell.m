//
//  ShowHomeSamallCell.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeSamallCell.h"

#define cellWith          (KScreenWidth - 2)/3
#define cellHeight        cellWith/3*4

@implementation ShowHomeSamallCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.coverImage];
        [self.contentView addSubview:self.headPortrait];
        [self.contentView addSubview:self.nickName];
        
        [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headPortrait);
            make.left.equalTo(self.headPortrait.mas_right).with.offset(5*Proportion375);
            make.height.equalTo(@(10*Proportion375));
            make.width.lessThanOrEqualTo(@(cellWith - 25*Proportion375));
        }];
    }
    return self;
}
-(YYAnimatedImageView *)coverImage
{
    if (!_coverImage) {
        _coverImage = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0,cellWith ,cellWith/3*4)];
        _coverImage.contentMode = UIViewContentModeScaleAspectFill;
        _coverImage.backgroundColor = [UIColor clearColor];
        [_coverImage setImage:[UIImage imageNamed:@"login_bg"]];
        _coverImage.clipsToBounds = YES;
    }
    return _coverImage;
}

-(SLHeadPortrait *)headPortrait
{
    if (!_headPortrait) {
        _headPortrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(5*Proportion375, 20*Proportion375, 15*Proportion375, 15*Proportion375)];
        _headPortrait.delegate = self;
        
    }
    return _headPortrait;
}

-(UILabel *)nickName
{
    if (!_nickName) {
        _nickName = [UILabel labelWithText:@"YiBaiWan" textColor:kThemeWhiteColor font:Font_Regular(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _nickName;
}

-(void)setDataModel:(SLLiveListModel *)dataModel
{
    if (!dataModel) {
        return;
    }
    _dataModel = dataModel;
    
    _headPortrait.bottom = cellHeight - 5*Proportion375;
    [self.nickName setText:_dataModel.master.nickname];
    [self.headPortrait setRoundStyle:YES imageUrl:_dataModel.master.avatar imageHeight:15*Proportion375 vip:NO attestation:NO];
    [self.coverImage yy_setImageWithURL:[NSURL URLWithString:_dataModel.cover] placeholder:[UIImage imageNamed:@"login_bg"]];
}
@end
