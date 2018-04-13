//
//  SLPlayerTopView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPlayerTopView.h"
#import "SLAvatarView.h"
#import "SLTopMemberView.h"
#import "SLCoinView.h"
#import "NSString+Number.h"

@interface SLPlayerTopView()

@property(nonatomic,strong)UIView * leftBackView;

@property(nonatomic,strong)SLAvatarView * avatarView;

@property(nonatomic,strong)UILabel * nickNameLabel;

@property(nonatomic,strong)UIImageView * fansIcon;

@property(nonatomic,strong)UILabel * watchesLabel;

@property(nonatomic,strong)UIButton * focusButton;

@property(nonatomic,strong)SLTopMemberView * memberView;

@property(nonatomic,strong)SLCoinView * coinView;

@property (nonatomic,assign)NSInteger  watches;

@end
@implementation SLPlayerTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
 
        [self addSubview:self.leftBackView];
        
        [self addSubview:self.avatarView];;

        [self addSubview:self.memberView];
        
        [self addSubview:self.coinView];
        
        [self addNotification];
        
        [self initData];
    }
    return self;
}

-(void)dealloc
{
    [self removeNotification];
    NSLog(@"[gx] member topview dealloc");
}

-(void)addNotification
{
    
}

-(void)initData
{
    [self.avatarView setAvatar:@"http://static.tongyigg.com/images/41b47ccc1dfbcd68d23a0f4de924bca7.jpg"];
    self.nickNameLabel.text = @"巴扎黑";
    self.watchesLabel.text = @"9999";
    [self.watchesLabel sizeToFit];
    [self.coinView updateTicketWithCount:1034652];
    
}

-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)refreshWatches:(NSInteger)watches
{
    _watches = watches;
    [self memberCount];
}

-(void)memberCount
{
    self.watchesLabel.text = [NSString stringWithFormat:@"%ld",(long)_watches];
    [self autoNickNameBack];
    
}
//适应昵称的背景
-(void)autoNickNameBack
{
    
    [self.nickNameLabel sizeToFit];
    
    self.watchesLabel.width = [self.watchesLabel.text length]*7.2;
    
    
    if (self.fansIcon.hidden == NO) {
        
        CGFloat nameWidth = CGRectGetWidth(self.nickNameLabel.frame);
        CGFloat maxWidth  = 181-self.avatarView.width-4-43;
        
        if (nameWidth > maxWidth) {
            
            nameWidth = maxWidth;
            
            self.leftBackView.width = 181;
            
            self.nickNameLabel.width = maxWidth;
            
        }else
        {
            
            if (self.watchesLabel.width +self.fansIcon.width+2>nameWidth) {
                
                self.leftBackView.width = self.avatarView.width+5+self.watchesLabel.width+self.fansIcon.width+43;
                
                
            }else
            {
                //背景的宽度  = 主播头像宽度 + 间距1 + 昵称标签宽度 + 间距2 + 关注按钮宽度+间距3
                self.leftBackView.width = self.avatarView.width + 4 + nameWidth + 43;
            }
            
        }
        
        
        CGFloat focusImageViewOriginX = self.leftBackView.width - 6 - self.fansIcon.width;
        
        self.focusButton.origin=CGPointMake(focusImageViewOriginX, self.leftBackView.height/2-self.fansIcon.height/2);
        
        
        
    }
    else
    {
        
        CGFloat nameWidth = CGRectGetWidth(self.nickNameLabel.frame);
        
        if (self.watchesLabel.width +self.fansIcon.width+2>nameWidth) {
            
            self.leftBackView.width=self.avatarView.width+6+self.watchesLabel.width+15+self.fansIcon.width+2;
            
        }else
        {
            
            
            self.leftBackView.width=self.avatarView.width+6+nameWidth+15;
            
        }
    }
    

}
#pragma -mark- buttn action

- (void)focusTapAction
{
    NSLog(@"[gx] 调取关注借口");
    
}
#pragma mark getter setter

-(UIView*)leftBackView
{
    if (!_leftBackView) {
        _leftBackView = [[UIView alloc] initWithFrame:CGRectMake(10, 27,180,30)];
        
        _leftBackView.backgroundColor = [Color(@"332E35") colorWithAlphaComponent:0.4];
        _leftBackView.layer.masksToBounds = YES;
        _leftBackView.layer.cornerRadius = 15;
        [_leftBackView addSubview:self.nickNameLabel];
        [_leftBackView addSubview:self.fansIcon];
        [_leftBackView addSubview:self.watchesLabel];

        CGFloat focusImageViewOriginX =_leftBackView.width - 9 - _focusButton.width;
        _focusButton.origin=CGPointMake(focusImageViewOriginX, _leftBackView.height/2-_focusButton.height/2);
        _focusButton.hidden=YES;
        [_leftBackView addSubview:self.focusButton];
        
    }
    return _leftBackView;
}

-(UILabel*)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 1, 30.f + 7, 14.f)];
        _nickNameLabel.font = [UIFont systemFontOfSize:12];
        _nickNameLabel.textColor = [UIColor whiteColor];
        
    }
    return _nickNameLabel;
}

-(UIImageView*)fansIcon
{
    if (!_fansIcon) {
        _fansIcon=[[UIImageView alloc]initWithFrame:CGRectMake(35, 18, 11, 8)];
        _fansIcon.image=[UIImage imageNamed:@"sl_live_eyes"];
    }
    return _fansIcon;
}

-(UILabel*)watchesLabel
{
    if (!_watchesLabel) {
        _watchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fansIcon.frame)+2, self.nickNameLabel.mj_y + self.nickNameLabel.height, 30.f, 14.f)];
        _watchesLabel.font = [UIFont systemFontOfSize:12];
        _watchesLabel.textColor = [UIColor whiteColor];
        
    }
    return _watchesLabel;
}

-(SLAvatarView*)avatarView
{
    if (!_avatarView) {
        _avatarView = [[SLAvatarView alloc]initWithFrame:CGRectMake(10, 27, 30,30)];
        _avatarView.backgroundColor = [UIColor redColor];
    }
    return _avatarView;
}

-(UIButton*)focusButton
{
    if (!_focusButton) {
        _focusButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_focusButton setImage:[UIImage imageNamed:@"sl_live_foucus"] forState:UIControlStateNormal];
        CGRect rect = CGRectMake(100, 5, 32, 20);
        _focusButton.frame = rect;
        [_focusButton addTarget:self action:@selector(focusTapAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _focusButton;
}



-(SLTopMemberView*)memberView
{
    if (!_memberView) {

        CGFloat memberViewX = CGRectGetMaxX(self.leftBackView.frame) + 42.f;
        CGFloat memberViewY = 17;
        CGFloat memberViewWidth = kMainScreenWidth-50 - CGRectGetMaxX(self.leftBackView.frame) -42;
        CGFloat memberViewwHeight = 52;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(32, 32);
        [layout setSectionInset:UIEdgeInsetsMake(0,1,0,1)];
        layout.minimumLineSpacing =5.f;
        layout.minimumInteritemSpacing =5;
        
        _memberView = [[SLTopMemberView alloc] initWithFrame:CGRectMake(memberViewX,memberViewY, memberViewWidth, memberViewwHeight) collectionViewLayout:layout];
        _memberView.backgroundColor=[UIColor clearColor];
        
    }
    return _memberView;
}



-(SLCoinView*)coinView
{
    if (!_coinView) {
        //金币  OK
        CGFloat goldViewHeight = 37.f;
        CGFloat goldViewWidth = 120.f/2.f; //190
        _coinView = [[SLCoinView alloc] initWithFrame:CGRectMake(11.f, 49 + 8.f, goldViewWidth, goldViewHeight)];
        
    }
    return _coinView;
}




@end
