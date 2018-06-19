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
        [_coverImage setImage:[UIImage imageNamed:@"home_start_img"]];
        _coverImage.clipsToBounds = YES;
    }
    return _coverImage;
}


@end
