//
//  SLTopListGivingCell.m
//  ShowLive
//
//  Created by vning on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//
#import "SLTopListGivingCell.h"

@implementation SLTopListGivingCell
{
    CGFloat cellheight;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        cellheight =  65*Proportion375;

        [self.contentView addSubview:self.numLab];
        [self.contentView addSubview:self.numImg];
        [self.contentView addSubview:self.avatar_normal];
        [self.contentView addSubview:self.avatar_topOne_bg];
        [self.contentView addSubview:self.avatar_topOne_top];
        [self.contentView addSubview:self.avatar_topTwo_bg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.textLab];
        [self.contentView addSubview:self.concernBtn];
        [self.contentView addSubview:self.lineview];

        [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_top).offset(cellheight/2);
            make.size.mas_equalTo(CGSizeMake(100, 50));
            make.left.equalTo(@(20*Proportion375));
        }];
        
        [self.numImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_numLab);
            make.size.mas_equalTo(CGSizeMake(35*Proportion375, 35*Proportion375));
        }];
        
        [self.avatar_normal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(35*Proportion375, 35*Proportion375));
            make.centerY.equalTo(_numLab);
            make.left.equalTo(@(70*Proportion375));
        }];
        [self.avatar_topTwo_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(67*Proportion375, 67*Proportion375));
            make.centerY.equalTo(_numLab);
            make.centerX.equalTo(_avatar_normal);
        }];
        [self.avatar_topTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
            make.centerY.equalTo(_avatar_topTwo_bg);
            make.centerX.equalTo(_avatar_topTwo_bg);
        }];
        [self.avatar_topOne_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(160*Proportion375, 160*Proportion375));
            make.top.equalTo(self.contentView).with.offset(5*Proportion375);
            make.centerX.equalTo(self.contentView);
        }];
        [self.avatar_topOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90*Proportion375, 90*Proportion375));
            make.centerY.equalTo(self.avatar_topOne_bg);
            make.centerX.equalTo(self.contentView);
        }];
        [self.avatar_topOne_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(160*Proportion375, 160*Proportion375));
            make.top.equalTo(self.contentView).with.offset(5*Proportion375);
            make.centerX.equalTo(self.contentView);
        }];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.lessThanOrEqualTo(@(140*Proportion375));
            make.left.equalTo(@(130*Proportion375));
            //            make.height.equalTo(@20);
            make.top.equalTo(_avatar_normal);
        }];
        [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.lessThanOrEqualTo(@(175*Proportion375));
            make.left.equalTo(_nameLab);
            //            make.height.equalTo(@15);
            make.bottom.equalTo(_avatar_normal);
        }];
        
        
        [self.concernBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_numLab);
            make.right.equalTo(self).offset(-15*Proportion375);
            make.size.mas_equalTo(CGSizeMake(45*Proportion375, 21*Proportion375));
        }];
        [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 1*Proportion375));
        }];

    }
    return self;
}
-(void)setCelltype:(cellType)celltype
{
    _celltype = celltype;
    self.backgroundColor = kThemeWhiteColor;

    switch (celltype) {
        case CellType_Normal:
        {
            cellheight = 65*Proportion375;
            _numImg.hidden = YES;
            _numLab.hidden = NO;
            _avatar_topOne_bg.hidden = YES;
            _avatar_topOne_top.hidden = YES;
            _avatar_topTwo_bg.hidden = YES;
            _avatar_normal.hidden = NO;

            [_numLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_top).offset(cellheight/2);
                make.size.mas_equalTo(CGSizeMake(100, 50));
                make.left.equalTo(@(20*Proportion375));
            }];
            
            [_numImg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_top).offset(cellheight/2);
                make.left.equalTo(@(20*Proportion375));
                make.size.mas_equalTo(CGSizeMake(35*Proportion375, 35*Proportion375));
            }];

            [_avatar_normal mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(35*Proportion375, 35*Proportion375));
                make.centerY.equalTo(_numLab);
                make.left.equalTo(@(70*Proportion375));
            }];
            
            [_nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.lessThanOrEqualTo(@(140*Proportion375));
                make.left.equalTo(@(130*Proportion375));
                //            make.height.equalTo(@20);
                make.top.equalTo(_avatar_normal);
            }];
            [_textLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.lessThanOrEqualTo(@(175*Proportion375));
                make.left.equalTo(_nameLab);
                //            make.height.equalTo(@15);
                make.bottom.equalTo(_avatar_normal);
            }];
            
            
            [_concernBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_numLab);
                make.right.equalTo(self).offset(-15*Proportion375);
                make.size.mas_equalTo(CGSizeMake(45*Proportion375, 21*Proportion375));
            }];
            [_lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.left.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 1*Proportion375));
            }];
        }
            break;
        case CellType_First:
        {
            cellheight = 230*Proportion375;
            _numLab.hidden = YES;
            _numImg.hidden = NO;
            _avatar_topOne_bg.hidden = NO;
            _avatar_topOne_top.hidden = NO;
            _avatar_topTwo_bg.hidden = YES;
            _avatar_normal.hidden = YES;
            self.backgroundColor = kGrayBGColor;

            [_numLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_top).offset(cellheight/2);
                make.size.mas_equalTo(CGSizeMake(100, 50));
                make.left.equalTo(@(20*Proportion375));
            }];
            [_numImg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_top).offset(cellheight/2);
                make.left.equalTo(@(20*Proportion375));
                make.size.mas_equalTo(CGSizeMake(35*Proportion375, 35*Proportion375));
            }];
            [_avatar_normal mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(35*Proportion375, 35*Proportion375));
                make.centerY.equalTo(_numLab);
                make.left.equalTo(@(70*Proportion375));
            }];

            [_nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.lessThanOrEqualTo(@(140*Proportion375));
                make.centerX.equalTo(self.contentView);
                //            make.height.equalTo(@20);
                make.top.equalTo(_avatar_topOne_bg.mas_bottom);
            }];
            [_textLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.lessThanOrEqualTo(@(175*Proportion375));
                make.centerX.equalTo(_nameLab);
                //            make.height.equalTo(@15);
                make.top.equalTo(_nameLab.mas_bottom);
            }];
            
            
            [_concernBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_numLab);
                make.right.equalTo(self).offset(-15*Proportion375);
                make.size.mas_equalTo(CGSizeMake(45*Proportion375, 21*Proportion375));
            }];
            [_lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.left.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 1*Proportion375));
            }];
        }
            break;
        case CellType_Second:
        {
            cellheight = 92*Proportion375;
            _numLab.hidden = YES;
            _numImg.hidden = NO;
            _avatar_topOne_bg.hidden = YES;
            _avatar_topOne_top.hidden = YES;
            _avatar_topTwo_bg.hidden = NO;
            _avatar_normal.hidden = YES;
            
            [_numLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_top).offset(cellheight/2);
                make.size.mas_equalTo(CGSizeMake(100, 50));
                make.left.equalTo(@(20*Proportion375));
            }];
            [_numImg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_top).offset(cellheight/2);
                make.left.equalTo(@(20*Proportion375));
                make.size.mas_equalTo(CGSizeMake(35*Proportion375, 35*Proportion375));
            }];
            [_avatar_normal mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(35*Proportion375, 35*Proportion375));
                make.centerY.equalTo(_numLab);
                make.left.equalTo(@(70*Proportion375));
            }];
            [self.avatar_topTwo_bg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(67*Proportion375, 67*Proportion375));
                make.centerY.equalTo(_numLab);
                make.centerX.equalTo(_avatar_normal);
            }];
            [self.avatar_topTwo mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
                make.centerY.equalTo(_avatar_topTwo_bg);
                make.centerX.equalTo(_avatar_topTwo_bg);
            }];

            [_nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.lessThanOrEqualTo(@(140*Proportion375));
                make.left.equalTo(@(130*Proportion375));
                //            make.height.equalTo(@20);
                make.top.equalTo(_avatar_normal);
            }];
            [_textLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.lessThanOrEqualTo(@(175*Proportion375));
                make.left.equalTo(_nameLab);
                //            make.height.equalTo(@15);
                make.bottom.equalTo(_avatar_normal);
            }];
            
            [_concernBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_numLab);
                make.right.equalTo(self).offset(-15*Proportion375);
                make.size.mas_equalTo(CGSizeMake(45*Proportion375, 21*Proportion375));
            }];
            [_lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.left.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 1*Proportion375));
            }];
        }
            break;
          default:
            break;
    }
  

}
-(UILabel *)numLab
{
    if (!_numLab ) {
        _numLab = [UILabel labelWithText:@"NO.4" textColor:kthemeBlackColor font:Font_Medium(12*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    }
    return _numLab;
}
-(UIImageView *)numImg
{
    if (!_numImg ) {
        _numImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_level_first_tag"]];
    }
    return _numImg;
}
-(UIImageView *)avatar_normal
{
    if (!_avatar_normal) {
        _avatar_normal = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_admin_Img"]];
        _avatar_normal.size = CGSizeMake(35*Proportion375, 35*Proportion375);
        _avatar_normal.right = 86*Proportion375;
        _avatar_normal.centerY = cellheight/2;
        _avatar_normal.layer.borderColor = kGrayBGColor.CGColor;
        _avatar_normal.layer.borderWidth = 1.0;
        [_avatar_normal roundStyle];
    }
    return _avatar_normal;
}
-(UIImageView *)avatar_topTwo_bg
{
    if (!_avatar_topTwo_bg) {
        _avatar_topTwo_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_level_second_bg"]];
        _avatar_topTwo_bg.clipsToBounds = YES;
        _avatar_topTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_admin_Img"]];
        _avatar_topTwo.clipsToBounds = YES;
        _avatar_topTwo.layer.borderColor = kGrayBGColor.CGColor;
        _avatar_topTwo.layer.borderWidth = 1.0;
        _avatar_topTwo.layer.cornerRadius = 25*Proportion375;
        [_avatar_topTwo_bg addSubview:_avatar_topTwo];
    }
    return _avatar_topTwo_bg;
}
-(UIImageView *)avatar_topOne_bg
{
    if (!_avatar_topOne_bg) {
        _avatar_topOne_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_level_first_bg"]];
        _avatar_topOne_bg.clipsToBounds = YES;

        _avatar_topOne = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_admin_Img"]];
        _avatar_topOne.clipsToBounds = YES;
        _avatar_topOne.layer.borderColor = kGrayBGColor.CGColor;
        _avatar_topOne.layer.borderWidth = 1.0;
        _avatar_topOne.layer.cornerRadius = 45*Proportion375;
        [_avatar_topOne_bg addSubview:_avatar_topOne];
        
        
    }
    return _avatar_topOne_bg;
}
-(UIImageView *)avatar_topOne_top
{
    if (!_avatar_topOne_top) {
        _avatar_topOne_top = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhome_level_first_top"]];
        _avatar_topOne_top.clipsToBounds = YES;
        
    }
    return _avatar_topOne_top;
}
-(UILabel * )nameLab{
    if (!_nameLab) {
        _nameLab= [UILabel labelWithText:@"楼上卡卡借" textColor:kGrayWith999999 font:Font_Regular(14) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    }
    return _nameLab;
}
-(UILabel *)textLab
{
    if (!_textLab) {
        _textLab = [UILabel labelWithText:@"获得了点奖励" textColor:kthemeBlackColor font:Font_Regular(13) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    }
    return _textLab;
}

-(UIButton *)concernBtn
{
    if (!_concernBtn) {
        _concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_concernBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_concernBtn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
        [_concernBtn.titleLabel setFont:Font_Regular(13*Proportion375)];
        _concernBtn.layer.borderColor = kthemeBlackColor.CGColor;
        _concernBtn.layer.borderWidth = 1;
        _concernBtn.layer.cornerRadius = 3;
    }
    return _concernBtn;
}

-(UIView *)lineview
{
    if (!_lineview) {
        _lineview = [[UIView alloc] init];
        _lineview.backgroundColor = kSeparationColor;
    }
    return _lineview;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
