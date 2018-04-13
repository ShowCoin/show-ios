//
//  ShowHomeLargeCell.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeLargeCell.h"



@implementation ShowHomeLargeCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        [self addSubview:self.coverImage];
        [self addSubview:self.headPortraitBtn];
        [self addSubview:self.addBtn];
        [self addSubview:self.thumbBtn];
        [self addSubview:self.commentBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.peopleText];
        [self addSubview:self.peopleNum];
        [self addSubview:self.nickName];
        [self addSubview:self.liveTitle];

        [_headPortraitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(270*Proportion375);
            make.right.equalTo(self).with.offset(-5*Proportion375);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
        }];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_headPortraitBtn.mas_bottom);
            make.centerX.equalTo(_headPortraitBtn);
            make.size.mas_equalTo(CGSizeMake(20*Proportion375, 20*Proportion375));
        }];
        [_thumbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headPortraitBtn.mas_bottom).with.offset(35*Proportion375);
            make.centerX.equalTo(_headPortraitBtn.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
        }];
        [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_thumbBtn.mas_bottom).with.offset(15*Proportion375);
            make.centerX.equalTo(_headPortraitBtn.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
        }];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_commentBtn.mas_bottom).with.offset(15*Proportion375);
            make.centerX.equalTo(_headPortraitBtn.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
        }];
        [_peopleText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-15*Proportion375 - KTabBarHeight);
            make.right.equalTo(self).with.offset(-10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 10*Proportion375));
        }];
        [_peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_peopleText.mas_top).with.offset(-5*Proportion375);
            make.right.equalTo(_peopleText.mas_right);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 15*Proportion375));
        }];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_peopleText);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(100*Proportion375, 15*Proportion375));
        }];
        [_liveTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_nickName.mas_top).with.offset(-10*Proportion375);
            make.left.equalTo(_nickName);
            make.size.mas_equalTo(CGSizeMake(280*Proportion375, 50*Proportion375));
        }];
        
    }
    return self;
}
-(YYAnimatedImageView *)coverImage
{
    if (!_coverImage) {
        _coverImage = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0,kMainScreenWidth ,kMainScreenHeight)];
        
        //        _coverImage.contentMode = UIViewContentModeScaleAspectFill;
        _coverImage.contentMode = UIViewContentModeScaleToFill;
        //        [_coverImage yy_setImageWithURL:[NSURL URLWithString:@"http://www.131mmw.com/uploads/allimg/180407/1-1P40G04248.jpg"] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
        [_coverImage setImage:[UIImage imageNamed:@"login_bg"]];
        _coverImage.backgroundColor = [UIColor clearColor];
        _coverImage.clipsToBounds = YES;
    }
    return _coverImage;
}

-(UIButton *)headPortraitBtn
{
    if (!_headPortraitBtn) {
        _headPortraitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headPortraitBtn setBackgroundImage:[UIImage imageNamed:@"userhome_admin_Img"] forState:UIControlStateNormal];
        [_headPortraitBtn setBackgroundImage:[UIImage imageNamed:@"userhome_admin_Img"] forState:UIControlStateHighlighted];
        _headPortraitBtn.clipsToBounds = YES;
        _headPortraitBtn.layer.cornerRadius = 50*Proportion375/2;
        _headPortraitBtn.layer.borderColor = kGrayBGColor.CGColor;
        _headPortraitBtn.layer.borderWidth = 1.0;
        [[_headPortraitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
        }];
        
    }
    return _headPortraitBtn;
}
-(UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"home_add_no"] forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:@"home_add_no"] forState:UIControlStateHighlighted];
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
        }];
    }
    return _addBtn;
}
-(UIButton *)thumbBtn
{
    if (!_thumbBtn) {
        _thumbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thumbBtn setImage:[UIImage imageNamed:@"home_thumb_img"] forState:UIControlStateNormal];
        [_thumbBtn setImage:[UIImage imageNamed:@"home_thumb_img"] forState:UIControlStateHighlighted];
        [_thumbBtn setTitle:@"1999.1w" forState:UIControlStateNormal];
        [_thumbBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _thumbBtn.titleLabel.font  = Font_Regular(9);
        _thumbBtn.titleEdgeInsets = UIEdgeInsetsMake(40*Proportion375, -38*Proportion375 ,0,0);
        _thumbBtn.imageEdgeInsets = UIEdgeInsetsMake(0,7*Proportion375, 11*Proportion375, 0);
        
        [[_thumbBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
        }];
    }
    return _thumbBtn;
}
-(UIButton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"home_comment_img"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"home_comment_img"] forState:UIControlStateHighlighted];
        [_commentBtn setTitle:@"19.1w" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _commentBtn.titleLabel.font  = Font_Regular(9);
        _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(40*Proportion375, -38*Proportion375 ,0,0);
        _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0,7*Proportion375, 11*Proportion375, 0);
        [[_commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
        }];

    }
    return _commentBtn;
}
-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"home_share_img"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"home_share_img"] forState:UIControlStateHighlighted];
        [_shareBtn setTitle:@"9.1w" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
        _shareBtn.titleLabel.font  = Font_Regular(9);
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(40*Proportion375, -38*Proportion375 ,0,0);
        _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0,7*Proportion375, 11*Proportion375, 0);
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
        }];

    }
    return _shareBtn;
}
-(UILabel *)peopleText
{
    if (!_peopleText) {
        _peopleText = [UILabel labelWithText:@"人观看" textColor:kThemeWhiteColor font:Font_Regular(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        
    }
    return _peopleText;
}
-(UILabel *)peopleNum
{
    if (!_peopleNum) {
        _peopleNum = [UILabel labelWithText:@"7777" textColor:kThemeWhiteColor font:Font_Regular(15*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        
    }
    return _peopleNum;
}
-(UILabel *)nickName
{
    if (!_nickName) {
        _nickName = [UILabel labelWithText:@"YiBaiWan" textColor:kThemeWhiteColor font:Font_Regular(15*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _nickName;
}
-(UILabel *)liveTitle
{
    if (!_liveTitle) {
        _liveTitle = [UILabel labelWithText:@"阿布扎比开播阿布扎比开播阿布扎比开播阿布扎比开播阿布扎比开播阿布扎比开播阿布扎比开播阿布扎比开播阿布扎比开播阿布扎比开播" textColor:kThemeWhiteColor font:Font_Regular(15*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _liveTitle.numberOfLines = 0;
        
    }
    return _liveTitle;
}
@end
