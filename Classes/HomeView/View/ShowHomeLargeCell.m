//
//  ShowHomeLargeCell.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeLargeCell.h"
#import "SLFollowUserAction.h"
#import "SLPlayerViewController+HomePageReuse.h"
#import "HomeHeader.h"
#import "ShowHomeBaseController.h"
#import "SLBottomAimationView.h"

static SLPlayerViewController *lastPlayerVC = nil ;
static SLLiveListModel *lastDataModel = nil ;
static BOOL showPlayerMessage = YES ;

@interface ShowHomeLargeCell ()

@end

@implementation ShowHomeLargeCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self.contentView addSubview:self.coverImage];
        self.otherContentView.userInteractionEnabled = NO;
        [self.contentView addSubview:self.otherContentView];
        [self.headPortrait addSubview:self.addBtn];
        [self.otherContentView addSubview:self.headPortrait];
        [self.otherContentView addSubview:self.coinView];
        [self.otherContentView addSubview:self.thumbBtn];
        [self.otherContentView addSubview:self.commentBtn];
        [self.otherContentView addSubview:self.shareBtn];
        [self.otherContentView addSubview:self.peopleText];
        [self.otherContentView addSubview:self.peopleNum];
        [self.otherContentView addSubview:self.nickName];
        [self.otherContentView addSubview:self.liveTitle];
        [self.otherContentView addSubview:self.testLab];
        self.otherContentView.hidden = YES;
        
        [self.otherContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);        }];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.equalTo(@(5));
            make.top.equalTo(@(30));
        }];
        [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 40));
            make.centerX.equalTo(self.headPortrait).with.offset(3);
            make.top.equalTo(self.headPortrait.mas_bottom).with.offset(16);
        }];
        [self.thumbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coinView.mas_bottom).with.offset(20);
            make.centerX.equalTo(self.headPortrait.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.thumbBtn.mas_bottom).with.offset(30);
            make.centerX.equalTo(self.headPortrait.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentBtn.mas_bottom).with.offset(30);
            make.centerX.equalTo(self.headPortrait.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        
        [self.peopleText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-80*Proportion375 - KTabBarHeight);
            make.right.equalTo(self).with.offset(-10*Proportion375);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 10*Proportion375));
        }];
        [self.peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.peopleText.mas_top).with.offset(-1*Proportion375);
            make.right.equalTo(self.peopleText.mas_right);
            make.size.mas_equalTo(CGSizeMake(80*Proportion375, 22*Proportion375));
        }];
        [self.testLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-9 - KTabBarHeight);
            make.left.equalTo(self).with.offset(12);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth/2-20, 20.f));
        }];
        [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-28.f - KTabBarHeight);
            make.left.equalTo(self.testLab);
            make.size.mas_equalTo(CGSizeMake(93, 20.f));
        }];
        [self.liveTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.nickName.mas_top).with.offset(-10);
            make.left.equalTo(self.nickName);
            make.width.equalTo(@(280*Proportion375));
        }];
        
        [self.contentView insertSubview:self.plyerContentView aboveSubview:self.coverImage];
        [self.plyerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.parentVC = (UIViewController*)self.nextResponder.nextResponder.nextResponder;
        [self.parentVC addChildViewController:self.playerVC];
        [self.plyerContentView addSubview:self.playerVC.view];
        [self.playerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.plyerContentView);
        }];
        
        self.headPortrait.hidden = YES ;
        self.coinView.hidden = YES;
        self.thumbBtn.hidden = YES;
        self.shareBtn.hidden = YES;
        self.commentBtn.hidden = YES ;
        self.shareBtn.hidden = YES ;
        self.nickName.hidden = YES ;
        self.liveTitle.hidden = YES ;
        self.nickLabel.hidden = YES;
        self.liveNameLabel.hidden = YES;
        self.lineView.hidden = YES;

        
        [self.otherContentView addSubview:self.nickLabel];
        [self.otherContentView addSubview:self.lineView];
        [self.otherContentView addSubview:self.liveNameLabel];
        [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-23.f- KTabBarHeight);
            make.left.equalTo(self.testLab);
            make.height.equalTo(@20.0f);
            make.width.lessThanOrEqualTo(@93);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nickLabel.mas_right).with.offset(5);
            make.width.equalTo(@1);
            make.height.equalTo(@12);
            make.centerY.equalTo(self.nickLabel);
        }];
        [self.liveNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).with.offset(5);
            make.centerY.equalTo(self.nickLabel);
        }];
        
        [self.otherContentView addSubview:self.showLabel];
        [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-60.f- KTabBarHeight);
            make.right.equalTo(self.otherContentView).with.offset(-11);
        }];
        
        [self.otherContentView addSubview:self.showNumberLabel];
        [self.showNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.showLabel.mas_left).with.offset(-4);
            make.centerY.equalTo(self.showLabel);
            make.height.equalTo(@15);
        }];
        
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

-(YYAnimatedImageView *)coverImage
{
    if (!_coverImage) {
        _coverImage = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0,kMainScreenWidth ,kMainScreenHeight)];
        _coverImage.contentMode = UIViewContentModeScaleAspectFill;
        [_coverImage setImage:[UIImage imageNamed:@"home_start_img"]];
        _coverImage.backgroundColor = [UIColor clearColor];
        _coverImage.clipsToBounds = YES;
    }
    return _coverImage;
}

-(SLHeadPortrait *)headPortrait
{
    if (!_headPortrait) {
        _headPortrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(kMainScreenWidth - 60*Proportion375 + 4, KScreenHeight-KTabbarSafeBottomMargin-443, 50, 50)];
        _headPortrait.delegate = self;
    }
    return _headPortrait;
}
-(UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"sl_live_foucus"] forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:@"sl_live_foucus"] forState:UIControlStateHighlighted];
//        _addBtn.userInteractionEnabled = NO;
        _addBtn.hidden = YES;
        @weakify(self);
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            [self concerAction];
        }];
    }
    return _addBtn;
}
-(void)followAnimation
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15,40,20, 20)];
    imageView.image = [UIImage imageNamed:@"sl_live_follow"];
    imageView.transform = CGAffineTransformMakeRotation(M_PI);
    [self.headPortrait addSubview:imageView];
    [self sendSubviewToBack:imageView];
    @weakify(self)

    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self)

        self.addBtn.transform = CGAffineTransformMakeRotation(M_PI);
        self.addBtn.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        @strongify(self)

        self.addBtn.hidden = YES;
        
    }];
    
    imageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    [UIView animateWithDuration:1.0 animations:^{
        imageView.transform = CGAffineTransformMakeRotation(M_PI*2);
        imageView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
        
    } completion:^(BOOL finished) {
        @strongify(self)
        @weakify(self)
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            @strongify(self)
            [self hideImage:imageView];
        });
        
    }];
}
-(void)hideImage:(UIImageView*)imageView
{
    imageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    [UIView animateWithDuration:0.4 animations:^{
        imageView.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);
    } completion:^(BOOL finished) {
        
        [imageView removeFromSuperview];
    }];
}

-(SLCoinView*)coinView
{
    if (!_coinView) {
        
        _coinView = [[SLCoinView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headPortrait.frame)+7,60, 40)];
        UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoWallet)];
        [_coinView addGestureRecognizer:tapGesture];
    }
    return _coinView;
}

-(UIButton *)thumbBtn
{
    if (!_thumbBtn) {
        _thumbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thumbBtn setBackgroundImage:[UIImage imageNamed:@"home_thumb_img"] forState:UIControlStateNormal];
        [_thumbBtn setBackgroundImage:[UIImage imageNamed:@"home_thumb_img"] forState:UIControlStateHighlighted];
//        [_thumbBtn setTitle:@"1999.1w" forState:UIControlStateNormal];
//        [_thumbBtn setTitleColor:kThemeWhiteColor forState:UIControlStateNormal];
//        _thumbBtn.titleLabel.font  = Font_Trebuchet(12*Proportion375);
//        _thumbBtn.titleEdgeInsets = UIEdgeInsetsMake(40*Proportion375, -38*Proportion375 ,0,0);
//        _thumbBtn.imageEdgeInsets = UIEdgeInsetsMake(0,7*Proportion375, 11*Proportion375, 0);
        _thumbLab = [UILabel labelWithText:@"777" textColor:kThemeWhiteColor font:Font_Regular(12*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _thumbLab.frame = CGRectMake(0, 40 + 4, 40, 13*Proportion375);
        [_thumbBtn addSubview:_thumbLab];
        _thumbLab.layer.shadowRadius = 0.0f;
        _thumbLab.layer.shadowOpacity = 0.3;
        _thumbLab.layer.shadowColor = [UIColor blackColor].CGColor;
        _thumbLab.layer.shadowOffset = CGSizeMake(1,1);
        _thumbLab.layer.masksToBounds = NO;
        @weakify(self);
        [[_thumbBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            [HDHud showMessageInView:self.viewController.view title:@"敬请期待"];

        }];
    }
    return _thumbBtn;
}
-(UIButton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"home_comment_img"] forState:UIControlStateNormal];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"home_comment_img"] forState:UIControlStateHighlighted];
        _commentLab = [UILabel labelWithText:@"88k" textColor:kThemeWhiteColor font:Font_Regular(12*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _commentLab.frame = CGRectMake(0, 40 + 4, 40, 13*Proportion375);
        [_commentBtn addSubview:_commentLab];
        _commentLab.layer.shadowRadius = 0.0f;
        _commentLab.layer.shadowOpacity = 0.3;
        _commentLab.layer.shadowColor = [UIColor blackColor].CGColor;
        _commentLab.layer.shadowOffset = CGSizeMake(1,1);
        _commentLab.layer.masksToBounds = NO;

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
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"home_share_img"] forState:UIControlStateNormal];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"home_share_img"] forState:UIControlStateHighlighted];
        _shareLab = [UILabel labelWithText:@"999" textColor:kThemeWhiteColor font:Font_Regular(12*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _shareLab.frame = CGRectMake(0, 40 + 4, 40, 13*Proportion375);
        [_shareBtn addSubview:_shareLab];
        _shareLab.layer.shadowRadius = 0.0f;
        _shareLab.layer.shadowOpacity = 0.3;
        _shareLab.layer.shadowColor = [UIColor blackColor].CGColor;
        _shareLab.layer.shadowOffset = CGSizeMake(1,1);
        _shareLab.layer.masksToBounds = NO;
        @weakify(self);
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            [HDHud showMessageInView:self.viewController.view title:@"敬请期待"];
        }];
    }
    return _shareBtn;
}
-(UILabel *)peopleText
{
    if (!_peopleText) {
        _peopleText = [UILabel labelWithText:@"人" textColor:kThemeWhiteColor font:Font_Regular(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _peopleText.layer.shadowRadius = 0.0f;
        _peopleText.layer.shadowOpacity = 0.3;
        _peopleText.layer.shadowColor = [UIColor blackColor].CGColor;
        _peopleText.layer.shadowOffset = CGSizeMake(1,1);
        _peopleText.layer.masksToBounds = NO;

    }
    return _peopleText;
}
-(UILabel *)peopleNum
{
    if (!_peopleNum) {
        _peopleNum = [UILabel labelWithText:@"666" textColor:kThemeWhiteColor font:Font_Regular(22*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _peopleNum.layer.shadowRadius = 0.0f;
        _peopleNum.layer.shadowOpacity = 0.3;
        _peopleNum.layer.shadowColor = [UIColor blackColor].CGColor;
        _peopleNum.layer.shadowOffset = CGSizeMake(1,1);
        _peopleNum.layer.masksToBounds = NO;

    }
    return _peopleNum;
}
-(SLShadowLabel *)nickName
{
    if (!_nickName) {
        _nickName = [SLShadowLabel labelWithText:@"YiBaiWan" textColor:kThemeWhiteColor font:Font_Medium(14) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _nickName.layer.shadowRadius = 0.0f;
        _nickName.layer.shadowOpacity = 0.3;
        _nickName.layer.shadowColor = [UIColor blackColor].CGColor;
        _nickName.layer.shadowOffset = CGSizeMake(1,1);
        _nickName.layer.masksToBounds = NO;
    }
    return _nickName;
}
-(UILabel *)liveTitle
{
    if (!_liveTitle) {
        _liveTitle = [UILabel labelWithText:@"大佬开播！大佬开播！大佬开播！大佬开播！大佬开播！大佬开播！大佬开播！" textColor:kThemeWhiteColor font:Font_Medium(16*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _liveTitle.numberOfLines = 0;
        _liveTitle.layer.shadowRadius = 0.0f;
        _liveTitle.layer.shadowOpacity = 0.3;
        _liveTitle.layer.shadowColor = [UIColor blackColor].CGColor;
        _liveTitle.layer.shadowOffset = CGSizeMake(1,1);
        _liveTitle.layer.masksToBounds = NO;
        
    }
    return _liveTitle;
}
-(SLShadowLabel *)testLab
{
    if (!_testLab) {
        _testLab = [SLShadowLabel labelWithText:@"配音预留" textColor:kThemeWhiteColor font:Font_Regular(12) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _testLab.layer.shadowRadius = 0.0f;
        _testLab.layer.shadowOpacity = 0.3;
        _testLab.layer.shadowColor = [UIColor blackColor].CGColor;
        _testLab.layer.shadowOffset = CGSizeMake(1,1);
        _testLab.layer.masksToBounds = NO;
        _testLab.hidden = YES;

    }
    return _testLab;
}
-(void)headPortraitClickAuthor{
    [PageMgr pushToUserCenterControllerWithUserModel:_dataModel.master viewcontroller:(BaseViewController *)self.viewController];
}
-(void)gotoWallet
{
    [PageMgr pushtoTopListVCwithUid:_dataModel.master.uid viewcontroller:(BaseViewController *)self.viewController];
}

@end

