//
//  SLMiniCardView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#define MiniCardHeight  338
#define MiniCardWidth KScreenWidth-20
#import "SLMiniCardView.h"
#import "SLAvatarView.h"
#import "SLLevelView.h"
#import "SLMiniCardItem.h"
#import "SLVisualEffectView.h"


@interface SLMiniCardView()

//UI类
//背景视图
@property (nonatomic,strong)SLVisualEffectView *bgView;

//主播视图
@property(nonatomic,strong)SLAvatarView *avatarView;

//昵称
@property(nonatomic,strong)UILabel *nickLabel;

//性别
@property(nonatomic,strong)UIImageView *genderView;

//登记
@property(nonatomic,strong)SLLevelView * levelView;

//用户ID
@property(nonatomic,strong)UILabel * userIdLabel;

//位置信息
@property(nonatomic,strong)UILabel *localLabel;

//个性签名
@property(nonatomic,strong)UILabel *signatureLabel;

//线条
@property(nonatomic,strong)UIView * lineView;

//关注
@property(nonatomic,strong)UIButton *followButton;

//@
@property(nonatomic,strong)UIButton *specifiedButton;

//举报
@property(nonatomic,strong)UIButton *reportButton;


//item数组
@property(nonatomic,strong)NSMutableArray * itemArray;


@end

@implementation SLMiniCardView

-(void)addTouchEvent
{
    UITapGestureRecognizer * tapMiniCard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tapMiniCard];
}


-(void)initChildView
{
    [self initBgView];
    
    [self initAvatarView];
    
    [self initTopButton];
    
    [self initItems];
    
    [self initBottomButton];
}

-(void)initBgView
{
    [self addSubview:self.bgView];
    
    [self.bgView addSubview:self.nickLabel];
    [self.bgView addSubview:self.genderView];
    [self.bgView addSubview:self.levelView];
    [self.bgView addSubview:self.userIdLabel];
    [self.bgView addSubview:self.localLabel];
    [self.bgView addSubview:self.signatureLabel];
   
}

-(void)initAvatarView
{
     [self addSubview:self.avatarView];
}
-(void)initTopButton
{
    if (_isMe) {
        return;
    }
    
    [self.bgView addSubview:self.reportButton];
    
}

-(void)initItems
{
    
    NSArray * titleArray = @[@"粉丝",@"关注",@"秀币"];
    NSArray * valueArray = @[@"4444",@"555",@"666"];
    
    CGFloat width = (KScreenWidth-20)/3, height = 60;
    CGFloat  y = CGRectGetMaxY(self.signatureLabel.frame) + 26;
    if (_isMe) {
        y = -40- height - 19;
    }
    
    //清空数组
    [self.itemArray removeAllObjects];
    
    //清空子视图
    for (UIView * view in [self.bgView subviews]) {
        
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
        [self.itemArray addObject:item];
        
    }
    
}

-(void)initBottomButton
{
    if (_isMe) {
        self.lineView.hidden =YES;
        return;
    }
    
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.followButton];
    [self.bgView addSubview:self.specifiedButton];
}

-(void)show
{
    [self initChildView];
    [self addTouchEvent];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.bgView.mj_y = self.height - self.bgView.height-KTabbarSafeBottomMargin-30;
        self.avatarView.mj_y=self.height -self.bgView.height-KTabbarSafeBottomMargin-74;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hide
{
    [UIView animateWithDuration:0.1 animations:^{
        
        self.bgView.mj_y     = self.height;
        self.avatarView.mj_y = self.height+44;
        
    } completion:^(BOOL finished) {
        
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
        CGFloat x = 10, y = self.height;
        
        _bgView = [SLVisualEffectView creatForstedClassViewFrame:CGRectMake(x, y,MiniCardWidth, MiniCardHeight)
                                                    effectStytle:UIBlurEffectStyleLight
                                                     effectColor:[[UIColor whiteColor]
                                                                  colorWithAlphaComponent:0.9]];
        
        _bgView.layer.cornerRadius = 11;
        _bgView.layer.masksToBounds = YES;
        [_bgView addSubview:self.nickLabel];
        [_bgView addSubview:self.genderView];
        [_bgView addSubview:self.levelView];
        [_bgView addSubview:self.userIdLabel];
        [_bgView addSubview:self.localLabel];
        [_bgView addSubview:self.signatureLabel];
     
    }
    return _bgView;
}

-(UILabel*)nickLabel
{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 56, MiniCardWidth, 30)];
        _nickLabel.font =  [UIFont boldSystemFontOfSize:22];
        _nickLabel.textColor = [UIColor blackColor];
        _nickLabel.textAlignment = NSTextAlignmentCenter;
        _nickLabel.text = @"昵称最多八个字";
        
    }
    return _nickLabel;
}

-(UIImageView*)genderView
{
    if (!_genderView) {
        _genderView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _genderView.frame = CGRectMake(KScreenWidth/2- 25,91, 15, 15);
    }
    return _genderView;
}

-(SLLevelView*)levelView
{
    if (!_levelView) {
        _levelView = [[SLLevelView alloc]initWithFrame:CGRectMake(KScreenWidth/2+10,91, 30, 15)];
    }
    return _levelView;
}

-(UILabel*)userIdLabel
{
    if (!_userIdLabel) {
        CGFloat x = KScreenWidth/2-100, y =111;
        _userIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 100, 15)];
        _userIdLabel.font = [UIFont systemFontOfSize:14];
        _userIdLabel.textColor = [UIColor grayColor];
        _userIdLabel.textAlignment = NSTextAlignmentRight;
        _userIdLabel.text = @"ID 123456578";
    }
    return _userIdLabel;
}

-(UILabel*)localLabel
{
    if (!_localLabel) {
        CGFloat width =100, height = 14;
        CGFloat x = KScreenWidth/2+20, y =111;
        _localLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _localLabel.font = [UIFont systemFontOfSize:14];
        _localLabel.textColor = [UIColor grayColor];
        _localLabel.textAlignment = NSTextAlignmentLeft;
        _localLabel.text = @"北京市";
    }
    return _localLabel;
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
        _signatureLabel.text = @"这个人太忙了，没时间写简介";
    }
    return _signatureLabel;
}

-(SLAvatarView*)avatarView
{
    if (!_avatarView) {
        CGFloat width = 88, height = 88;
        CGFloat x = kScreenWidth/ 2 - width / 2, y = self.bgView.mj_y-44;
        _avatarView = [[SLAvatarView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _avatarView.backgroundColor = randomColor;
    }
    return _avatarView;
}


-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.frame = CGRectMake(15, self.bgView.height-51.5,KScreenWidth-50, 0.5);
        _lineView.backgroundColor = [UIColor blackColor];
        _lineView.layer.opacity = 0.11;
    }
    return _lineView;
}

-(UIButton*)reportButton
{
    
    if (!_reportButton) {
        //举报
        _reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reportButton.backgroundColor = randomColor;
        _reportButton.frame = CGRectMake(10, 10, 40, 40);
      
    }
    return _reportButton;
}

-(UIButton*)specifiedButton
{
    if (!_specifiedButton) {
        CGFloat y = MiniCardHeight-51;
        CGFloat width =KScreenWidth/2-10;
        CGFloat height = 51;
        _specifiedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _specifiedButton.frame =CGRectMake(0,y,width, height);
        [_specifiedButton setTitle:@"@TA" forState:UIControlStateNormal];
        [_specifiedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _specifiedButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _specifiedButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_specifiedButton addTarget:self action:@selector(_specifiedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _specifiedButton;
}


-(UIButton*)followButton
{
    if (!_followButton) {
        CGFloat y = MiniCardHeight-51;
        CGFloat width =KScreenWidth/2-10;
        CGFloat height = 51;
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _followButton.frame =CGRectMake(KScreenWidth/2,y,width, height);
        [_followButton setTitle:@"+关注" forState:UIControlStateNormal];
        [_followButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _followButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_followButton addTarget:self action:@selector(_followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _followButton;
}


@end
