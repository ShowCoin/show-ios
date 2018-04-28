//
//  SLMiniCardView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#define MiniCardHeight  450
#define MiniCardWidth KScreenWidth-20
#import "SLMiniCardView.h"
#import "SLHeadPortrait.h"
#import "SLLevelMarkView.h"
#import "SLMiniCardItem.h"
#import "SLVisualEffectView.h"
#import "SLLevelMarkView.h"
#import "YYText.h"

@interface SLMiniCardView()


//举报
@property(nonatomic,strong)UIButton *reportButton;

//关闭
@property(nonatomic,strong)UIButton *closeBtn;
//UI类
//背景视图
@property (nonatomic,strong)SLVisualEffectView *bgView;

//主播视图
@property(nonatomic,strong)SLHeadPortrait *avatarView;

//昵称
@property(nonatomic,strong)UILabel *nickLabel;

//性别
@property(nonatomic,strong)UIView *genderView;

//位置信息
@property(nonatomic,strong)UILabel *localLabel;
//星座
@property(nonatomic,strong)UILabel *constellationLabel;
//自我说明
@property(nonatomic,strong)UILabel *welcomeLabel;

//账户等级
@property(nonatomic,strong)SLLevelMarkView * coinLevelView;

//主播等级
@property(nonatomic,strong)SLLevelMarkView * masterLevelView;
//登记
@property(nonatomic,strong)SLLevelMarkView * levelView;

//用户ID
@property(nonatomic,strong)UILabel * userIdLabel;


//个性签名
@property(nonatomic,strong)UILabel *signatureLabel;

//关注
@property(nonatomic,strong)UIButton *followButton;

//@
@property(nonatomic,strong)UIButton *specifiedButton;
//item数组
@property(nonatomic,strong)NSMutableArray * itemArray;


//用户ID
@property (nonatomic,copy)NSString * userid;

//是否是自己
@property (nonatomic,assign)BOOL isMe;

//是否是主播
@property (nonatomic,assign)BOOL isManager;

@property(nonatomic,assign)BOOL follow;

@property(nonatomic,strong)UIView *whiteBackGroundView;

@property(nonatomic,weak)UIView *lineView;

@property(nonatomic,weak)UIView *lineViewTwo;

@property(nonatomic,weak)UILabel *ageLabel;

@property(nonatomic,weak)UIImageView *gender;

@end

@implementation SLMiniCardView

-(void)addTouchEvent
{
    UITapGestureRecognizer * tapMiniCard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    self.userInteractionEnabled  = YES ;
    [self addGestureRecognizer:tapMiniCard];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initBgView];
        [self addTouchEvent];
    }
    return self ;
}


-(void)creatChildViewWithUid:(NSString*)uid
                   isManager:(BOOL)isManager
{
    _userid = [NSString stringWithFormat:@"%@",uid];
    _isManager = isManager;
    _isMe = ([_userid isEqualToString:[NSString stringWithFormat:@"%@",[AccountModel shared].uid]])?YES:NO;
}
- (void)clearData{
    self.nickLabel.text = nil ;
    self.avatarView.imageView.image = nil ;
    self.localLabel.text = nil ;
    self.welcomeLabel.text = nil ;
    self.constellationLabel.text  = nil ;
    self.masterLevelView.level = 0;
    self.coinLevelView.level = 0;
    self.ageLabel.text =  nil ;
    self.userIdLabel.text = nil ;
    self.whiteBackGroundView.hidden = YES ;
    self.specifiedButton.hidden = YES ;
    for (SLMiniCardItem *item in self.itemArray) {
          [item setValue:@""];
    }
}


-(void)updateInfo:(ShowUserModel*)userModel
{
        [self.avatarView setRoundStyle:YES imageUrl:userModel.avatar imageHeight:88 vip:NO attestation:NO];
        self.nickLabel.text = [NSString stringWithFormat:@"%@",userModel.nickname];
    
        self.userIdLabel.text = [NSString stringWithFormat:@"ID:%@",userModel.popularNo];
    
        self.localLabel.text = (!IsStrEmpty(userModel.city))?[NSString stringWithFormat:@"%@",userModel.city]:@"火星";
        //
        self.welcomeLabel.text = IsStrEmpty(userModel.descriptions)?@"欢迎大家加入line跟我聊天互动哦\nline群除了有我每天工作动态外，也会分享生活的点滴哦!":userModel.descriptions;
        self.constellationLabel.text = IsStrEmpty(userModel.descriptions)?@"未知": [NSString stringWithFormat:@"%@",userModel.constellation];
        self.coinLevelView.level = [NSString stringWithFormat:@"%ld",(long)userModel.fanLevel];
        self.masterLevelView.level = [NSString stringWithFormat:@"%ld",(long)userModel.level];
        self.ageLabel.text =IsStrEmpty(userModel.age)?@"未知":[NSString stringWithFormat:@"%@岁",userModel.age];
         [self.gender setImage:userModel.gender.integerValue == 1?[UIImage imageNamed:@"userhome_sex_man"]:[UIImage imageNamed:@"userhome_sex_women"]];
    
        SLMiniCardItem *item0 = self.itemArray[0];//粉丝
        [item0 setValue:[NSString stringWithFormat:@"%@",userModel.fansCount]];
        
        SLMiniCardItem *item1 = self.itemArray[1];//关注
        [item1 setValue:[NSString stringWithFormat:@"%@",userModel.followCount]];
        
        SLMiniCardItem *item2 = self.itemArray[2];//收礼
        [item2 setValue:[NSString stringWithFormat:@"%@",userModel.receive]];
        
        self.follow = ([userModel.isFollowed isEqualToString:@"1"])?YES:NO;
        [self setFollowState:self.follow];

    if(_isMe){
        self.whiteBackGroundView.hidden = YES ;
        self.specifiedButton.hidden = YES ;
    }else{
        self.whiteBackGroundView.hidden = NO ;
        self.specifiedButton.hidden = NO ;
    }
}

-(void)setFollowState:(BOOL)follow
{
    if (follow) {
        _follow = YES;
        [self.followButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateNormal];
    } else {
        _follow = NO;
        [self.followButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.followButton setTitle:@"+关注" forState:UIControlStateNormal];
    }
}

-(void)initBgView
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.reportButton];
    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).with.offset(20.0f);
        make.top.equalTo(self.bgView).with.offset(20.0f);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    
    [self.bgView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.reportButton);
        make.right.equalTo(self.bgView).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    [self.bgView addSubview:self.avatarView];
    [self.bgView addSubview:self.nickLabel];
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_bottom).with.offset(18);
        make.centerX.equalTo(self.avatarView);
        make.height.greaterThanOrEqualTo(@18);
    }];
    
    [self.bgView addSubview:self.coinLevelView];
    [self.bgView addSubview:self.masterLevelView];

    [self.bgView addSubview:self.userIdLabel];
    [self.userIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(self.masterLevelView.mas_bottom).with.offset(6);
    }];

    [self.bgView addSubview:self.localLabel];
    [self.localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(self.userIdLabel.mas_bottom).with.offset(13);
        make.width.greaterThanOrEqualTo(@45);
        make.height.equalTo(@20);
    }];
//
    [self.bgView addSubview:self.genderView];
    [self.genderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.localLabel.mas_left).with.offset(-9);
        make.top.equalTo(self.userIdLabel.mas_bottom).with.offset(13);
        make.width.greaterThanOrEqualTo(@55);
        make.height.equalTo(self.localLabel);
    }];

    [self.bgView addSubview:self.constellationLabel];
    [self.constellationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.localLabel.mas_right).with.offset(9);
        make.top.equalTo(self.userIdLabel.mas_bottom).with.offset(13);
        make.height.equalTo(self.localLabel);
        make.width.greaterThanOrEqualTo(@45);
    }];

    [self.bgView addSubview:self.welcomeLabel];
    [self.welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIdLabel.mas_bottom).with.offset(47);
        make.centerX.equalTo(self.avatarView);
        make.width.lessThanOrEqualTo(self.bgView).with.offset(-10);
    }];

    
    [self.bgView addSubview:self.whiteBackGroundView];
    [self.whiteBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView);
        make.left.width.equalTo(self.bgView);
        make.height.equalTo(@42);
    }];
    
    [self initItems];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
    [self.whiteBackGroundView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.top.equalTo(self.whiteBackGroundView);
        make.left.width.equalTo(self.whiteBackGroundView);
    }];
    self.lineView = lineView;
    
    UIView *verticalView = [[UIView alloc]init];
    verticalView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    [self.whiteBackGroundView addSubview:verticalView];
    [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_top);
        make.bottom.equalTo(self.whiteBackGroundView);
        make.centerX.equalTo(self.whiteBackGroundView);
        make.width.equalTo(@1);
    }];
    self.lineViewTwo = verticalView;
//
    
    [self.whiteBackGroundView addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.whiteBackGroundView).with.multipliedBy(0.5);
        make.top.right.equalTo(lineView);
        make.bottom.equalTo(self.whiteBackGroundView);
    }];
    [self.bgView addSubview:self.specifiedButton];
    [self.specifiedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.whiteBackGroundView).with.multipliedBy(0.5);
        make.top.left.equalTo(lineView);
        make.bottom.equalTo(self.whiteBackGroundView);
    }];
}


-(void)initItems
{
    
    NSArray * titleArray = @[@"粉丝",@"关注",@"秀币"];
    NSArray * valueArray = @[@"0",@"0",@"0"];
    
    CGFloat width = (KScreenWidth-20)/3, height = 60;
    CGFloat y = CGRectGetMaxY(self.signatureLabel.frame) + 26;
    if (_isMe) {
        y = 338-40- height - 19;
    }
    
    
    //清空数组
    [self.itemArray removeAllObjects];
    
    //清空子视图
    for (UIView * view in [self.whiteBackGroundView subviews]) {
        
        if ([view isKindOfClass:[SLMiniCardItem class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    for (int i= 0; i<3; i++) {
        CGFloat itemX = (width)*i;
        CGFloat itemY = y;
        CGRect rect = CGRectMake(itemX, itemY, width, height);
        SLMiniCardItem *item = [[SLMiniCardItem  alloc] initWithFrame:rect];
        [item setTitle:titleArray[i]];
        [item setValue:valueArray[i]];
        [self.bgView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgView).with.offset(-55);
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
            make.centerX.equalTo(self.bgView).with.offset((i-1)*width);
        }];
        [self.itemArray addObject:item];
    }
}

-(void)show
{
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
      self.transform  = CGAffineTransformMakeTranslation(0, -self.height);
    } completion:nil];
}

-(void)hide
{
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.transform  =CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        @strongify(self);
        self.delegate = nil ;
        [self clearData];
        [self removeFromSuperview];
    }];
}

-(NSMutableArray*)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}



-(SLVisualEffectView*)bgView
{
    if (!_bgView) {
        CGFloat height = MiniCardHeight;
        
        if (_isMe) {
            height -= 51;
        }
        CGFloat x = 0, y = self.height;
        
        _bgView = [SLVisualEffectView creatForstedClassViewFrame:CGRectMake(x, self.height-MiniCardHeight,KScreenWidth, MiniCardHeight)
                                                    effectStytle:UIBlurEffectStyleExtraLight
                                                     effectColor:[HexRGBAlpha(0x1c0072, 1) colorWithAlphaComponent:0.4]];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = _bgView.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                           HexRGBAlpha(0x1c0072, 0.7).CGColor,
                           HexRGBAlpha(0x1c0072, 0.1).CGColor,nil];
        [_bgView.layer addSublayer:gradient];
        _bgView.userInteractionEnabled = YES ;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            NSLog(@"hahaha");
        }];
    }
    return _bgView;
}

-(UILabel*)nickLabel
{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] init];
        _nickLabel.font =  [UIFont boldSystemFontOfSize:18];
        _nickLabel.textColor = [UIColor whiteColor];
        _nickLabel.textAlignment = NSTextAlignmentCenter;
        _nickLabel.text = @"";
        
    }
    return _nickLabel;
}

-(UIView*)genderView
{
    if (!_genderView) {
        _genderView = [[UIView alloc] init];
        _genderView.backgroundColor = HexRGBAlpha(0x9D88BF, 1);
        _genderView.layer.masksToBounds = YES;
        _genderView.layer.cornerRadius = 10;
        UIImageView *genderVimage = [[UIImageView alloc]init];
        genderVimage.image = [UIImage imageNamed:@"userhome_user_woman_no"];
        [_genderView addSubview:genderVimage];
        self.gender = genderVimage;
        [genderVimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.left.equalTo(self.genderView).with.offset(5);
            make.centerY.equalTo(self.genderView);
        }];
        UILabel *ageLabel = [[UILabel alloc]init];
        ageLabel.font =  [UIFont boldSystemFontOfSize:10];
        ageLabel.textColor = [UIColor whiteColor];
        ageLabel.text  = @"18岁";
        ageLabel.textAlignment = NSTextAlignmentLeft;
        [_genderView addSubview:ageLabel];
        [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(genderVimage.mas_right).with.offset(3);
            make.centerY.equalTo(self.genderView);
        }];
        self.ageLabel = ageLabel;
    }
    return _genderView;
}

-(SLLevelMarkView  *)coinLevelView
{
    if (!_coinLevelView) {
        _coinLevelView = [[SLLevelMarkView  alloc]initWithFrame:CGRectMake(KScreenWidth/2+10,178, 30, 15) withType:LevelType_ShowCoin];
    }
    return _coinLevelView;
}

-(SLLevelMarkView  *)masterLevelView
{
    if (!_masterLevelView) {
        _masterLevelView = [[SLLevelMarkView  alloc]initWithFrame:CGRectMake(KScreenWidth/2-25,178, 30, 15) withType:LevelType_Host];
    }
    return _masterLevelView;
}
-(UILabel*)userIdLabel
{
    if (!_userIdLabel) {
        _userIdLabel = [[UILabel alloc] init];
        _userIdLabel.font = Font_Trebuchet(18);
        _userIdLabel.textColor = [UIColor whiteColor];
        _userIdLabel.textAlignment = NSTextAlignmentCenter;;
    }
    return _userIdLabel;
}


-(UILabel*)signatureLabel
{
    if (!_signatureLabel) {
        CGFloat width = MiniCardWidth-30, height = 30;
        CGFloat x = 10, y = CGRectGetMaxY(self.localLabel.frame) + 34;
        _signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _signatureLabel.font = [UIFont systemFontOfSize:14];
        _signatureLabel.textColor = [UIColor grayColor];
        _signatureLabel.textAlignment = NSTextAlignmentCenter;
        _signatureLabel.numberOfLines = 0;
        _signatureLabel.text = @"";
    }
    return _signatureLabel;
}

-(SLHeadPortrait*)avatarView
{
    if (!_avatarView) {
        CGFloat width = 80, height = 80;
        CGFloat x = kScreenWidth/ 2 - width / 2, y = 55;
        _avatarView = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(x, y, width, height)];
    }
    return _avatarView;
}

-(UIButton*)reportButton
{
    
    if (!_reportButton) {
        //举报
        _reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reportButton setBackgroundImage:[UIImage imageNamed:@"live_card_report"] forState:UIControlStateNormal];
        [_reportButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_reportButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedButton:)]){
                [self.delegate didSelectedButton:SLMiniCardButtonType_Report];
            }
        }];
    }
    return _reportButton;
}

-(UIButton*)specifiedButton
{
    if (!_specifiedButton) {
        _specifiedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_specifiedButton setTitle:@"@TA" forState:UIControlStateNormal];
        [_specifiedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _specifiedButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _specifiedButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_specifiedButton addTarget:self action:@selector(specifiedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _specifiedButton;
}


-(UIButton*)followButton
{
    if (!_followButton) {
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followButton setTitle:@"+关注" forState:UIControlStateNormal];
        [_followButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _followButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}

-(void)specifiedButton:(UIButton*)sender
{
    if (self.delegate) {
        [self.delegate didSelectedButton:SLMiniCardButtonType_AtUser];
    }
}

-(void)followButtonClick:(UIButton*)sender;
{
    if (_follow==YES) {
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedButton:)]) {
        [_delegate didSelectedButton:SLMiniCardButtonType_Follow];
    }
}

- (UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn =    [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"live_close_button"] forState:UIControlStateNormal];
        @weakify(self);
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self hide];
        }];
    }
    return _closeBtn ;
}

- (UILabel *)constellationLabel{
    if(!_constellationLabel){
        _constellationLabel = [[UILabel alloc]init];
        _constellationLabel.text = @"巨蝎座";
        _constellationLabel.textColor = [UIColor whiteColor];
        _constellationLabel.layer.masksToBounds = YES;
        _constellationLabel.layer.cornerRadius = 10;
        _constellationLabel.textAlignment = NSTextAlignmentCenter;
        _constellationLabel.backgroundColor = HexRGBAlpha(0xEF4597, 1);
        if (@available(iOS 8.2, *)) {
            _constellationLabel.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightHeavy];
        } else {
            _constellationLabel.font = [UIFont systemFontOfSize:10.f];
        }
    }
    return _constellationLabel;
}

-(UILabel*)localLabel
{
    if (!_localLabel) {
        _localLabel = [[UILabel  alloc] init];
        _localLabel.text = @"   ";
        _localLabel.textColor = [UIColor whiteColor];
        _localLabel.layer.masksToBounds = YES;
        _localLabel.layer.cornerRadius = 10;
        _localLabel.textAlignment = NSTextAlignmentCenter;
        _localLabel.backgroundColor = HexRGBAlpha(0x1AC2F3, 1);
        if (@available(iOS 8.2, *)) {
            _localLabel.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightHeavy];
        } else {
            _localLabel.font = [UIFont systemFontOfSize:10.f];
        }
    }
    return _localLabel;
}

- (UILabel *)welcomeLabel{
    if(!_welcomeLabel){
        _welcomeLabel = [[UILabel alloc]init];
        _welcomeLabel.textColor = HexRGBAlpha(0xFFFFFF, 1);
        _welcomeLabel.textAlignment = NSTextAlignmentCenter;
        _welcomeLabel.font = [UIFont systemFontOfSize:13.0f];
        _welcomeLabel.text = @"欢迎大家加入line跟我聊天互动哦\nline群除了有我每天工作动态外，也会分享生活的点滴哦!";
        _welcomeLabel.numberOfLines=2;
    }
    return _welcomeLabel;
}

- (UIView *)whiteBackGroundView{
    if(!_whiteBackGroundView){
        _whiteBackGroundView = [[UIView alloc]init];
        _whiteBackGroundView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBackGroundView;
}
@end
