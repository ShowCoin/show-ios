//
//  ShowHomeLargeCell.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeLargeCell.h"
#import "SLFollowUserAction.h"


@implementation ShowHomeLargeCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.coverImage];
        [self.contentView addSubview:self.headPortrait];
        [self.contentView addSubview:self.addBtn];
        [self.contentView addSubview:self.thumbBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.shareBtn];
        [self.contentView addSubview:self.peopleText];
        [self.contentView addSubview:self.peopleNum];
        [self.contentView addSubview:self.nickName];
        [self.contentView addSubview:self.liveTitle];

//        [self.headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).with.offset(270*Proportion375);
//            make.right.equalTo(self).with.offset(-5*Proportion375);
//            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
//        }];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headPortrait.mas_bottom);
            make.centerX.equalTo(self.headPortrait);
            make.size.mas_equalTo(CGSizeMake(20*Proportion375, 20*Proportion375));
        }];
        [self.thumbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headPortrait.mas_bottom).with.offset(35*Proportion375);
            make.centerX.equalTo(self.headPortrait.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
        }];
        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.thumbBtn.mas_bottom).with.offset(15*Proportion375);
            make.centerX.equalTo(self.headPortrait.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
        }];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentBtn.mas_bottom).with.offset(15*Proportion375);
            make.centerX.equalTo(self.headPortrait.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(50*Proportion375, 50*Proportion375));
        }];
        [self.peopleText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-15*Proportion375 - KTabBarHeight);
            make.right.equalTo(self).with.offset(-10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 10*Proportion375));
        }];
        [self.peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.peopleText.mas_top).with.offset(-5*Proportion375);
            make.right.equalTo(self.peopleText.mas_right);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 15*Proportion375));
        }];
        [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.peopleText);
            make.left.equalTo(self).with.offset(10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(200*Proportion375, 15*Proportion375));
        }];
        [self.liveTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.nickName.mas_top).with.offset(-10*Proportion375);
            make.left.equalTo(self.nickName);
            make.width.equalTo(@(280*Proportion375));
//            make.size.mas_equalTo(CGSizeMake(280*Proportion375, 50*Proportion375));
        }];
        
    }
    return self;
}
-(YYAnimatedImageView *)coverImage
{
    if (!_coverImage) {
        _coverImage = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0,kMainScreenWidth ,kMainScreenHeight)];
        
        _coverImage.contentMode = UIViewContentModeScaleAspectFill;
        [_coverImage setImage:[UIImage imageNamed:@"login_bg"]];
        _coverImage.backgroundColor = [UIColor clearColor];
        _coverImage.clipsToBounds = YES;
    }
    return _coverImage;
}

-(SLHeadPortrait *)headPortrait
{
    if (!_headPortrait) {
        _headPortrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(kMainScreenWidth - 55*Proportion375, 270*Proportion375, 50*Proportion375, 50*Proportion375)];
//        _headPortrait.clipsToBounds = YES;
//        _headPortrait.userInteractionEnabled = YES;
//        _headPortrait.layer.cornerRadius = 50*Proportion375/2;
//        _headPortrait.layer.borderColor = kGrayBGColor.CGColor;
//        _headPortrait.layer.borderWidth = 1.0;
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headportraitAction)];
//        [_headPortrait addGestureRecognizer:tap];
//        [[_headPortrait rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//
//        }];
        _headPortrait.delegate = self;
        
    }
    return _headPortrait;
}
-(UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"home_add_no"] forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:@"home_add_no"] forState:UIControlStateHighlighted];
        @weakify(self);
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            [self concerAction];
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
        @weakify(self)
        [[_commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            [PageMgr pushToChatViewControllerWithTargetUserId:self.dataModel.master.uid];
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
        _peopleNum = [UILabel labelWithText:@"666" textColor:kThemeWhiteColor font:Font_Regular(15*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        
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
        _liveTitle = [UILabel labelWithText:@"大佬开播！大佬开播！大佬开播！大佬开播！大佬开播！大佬开播！大佬开播！" textColor:kThemeWhiteColor font:Font_Regular(15*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _liveTitle.numberOfLines = 0;
        
    }
    return _liveTitle;
}

-(void)headPortraitClickAuthor{
    [PageMgr pushToUserCenterControllerWithUserModel:_dataModel.master];
}

-(void)concerAction{
    SLFollowUserAction *action  = [SLFollowUserAction action];
    
    action.to_uid = self.dataModel.master.uid;
    if (self.dataModel.master.isFollowed.integerValue == 1) {
        action.type = 1;
    }else{
        action.type = 0;
    }
    @weakify(self);
    [self sl_startRequestAction:action Sucess:^(id result) {
        @strongify(self);
        if (self.dataModel.master.isFollowed.integerValue == 1) {
            self.dataModel.master.isFollowed = @"0";
        }else{
            self.dataModel.master.isFollowed = @"1";
        }
        [self.delegate LargeCellConcernActionDelegateWithModel:self.dataModel];
        
    } FaildBlock:^(NSError *error) {
        
    }];
}
-(void)setDataModel:(SLLiveListModel *)dataModel
{
    if (!dataModel) {
        return;
    }
    _dataModel = dataModel;
    self.addBtn.hidden = dataModel.master.isFollowed.integerValue == 1?YES:NO;
    [self.coverImage yy_setImageWithURL:[NSURL URLWithString:_dataModel.cover] placeholder:[UIImage imageNamed:@"login_bg"]];
    [self.nickName setText:_dataModel.master.nickname];
    [self.liveTitle setText:_dataModel.title];
//    [self.headPortrait yy_setImageWithURL:[NSURL URLWithString:_dataModel.master.avatar] placeholder:[UIImage imageNamed:@"userhome_admin_Img"]];
    [self.headPortrait setRoundStyle:YES imageUrl:_dataModel.master.avatar imageHeight:50*Proportion375 vip:NO attestation:NO];

    [self.peopleNum setText:_dataModel.online_users];
//    [self.thumbBtn setTitle:_dataModel forState:<#(UIControlState)#>]
}
@end
