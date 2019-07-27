//
//  SLUserViewHeader.h
//  ShowLive
//
//  Created by vning on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLUserViewHeaderDelegate <NSObject>

-(void)SLUserViewHeaderConcernActionDelegateWithModel:(ShowUserModel *)model;
-(void)SLUserViewHeaderConcernActionDelegateWithShare;
-(void)dismissMasterView;

@optional

@end

@interface SLUserViewHeader : UICollectionReusableView<HeadPortraitDelegate>{
    NSShadow * _shadowColor;
}
//活跃
@property (nonatomic, strong) UILabel * navLab;
//左边的按钮
@property (nonatomic, strong) UIButton * leftBtn;
//列表按钮
@property (nonatomic, strong) UIButton * listBtn;
//设置按钮
@property (nonatomic, strong) UIButton * settingBtn;
//礼物按钮
@property (nonatomic, strong) UIButton * giftStoreBtn;
//头像
@property (nonatomic, strong) SLHeadPortrait * headPortrait;
//名称label
@property (nonatomic, strong) UILabel * nickLab;

//主播等级
@property (nonatomic, strong) SLLevelMarkView *  masterLevel;
//show等级
@property (nonatomic, strong) SLLevelMarkView *  showLevel;

//性别view
@property (nonatomic, strong) UIView * sexbg;
//性别image
@property (nonatomic, strong) UIImageView * sexImg;
//性别label
@property (nonatomic, strong) UILabel * sexlab;
//城市label
@property (nonatomic, strong) UILabel * cityLab;
//自我介绍按钮
@property (nonatomic, strong) UILabel * constellationLab;

//@property (nonatomic,strong)UILabel * idPreLab;
@property (nonatomic, strong) UILabel * idLab;
//词label
@property (nonatomic, strong) UILabel * wordsLab;
//底部视图
@property (nonatomic, strong) UIView * bottomWhiteView;
//粉丝按钮
@property (nonatomic, strong) UIButton * fansBtn;
//关注按钮
@property (nonatomic, strong) UIButton * concerBtn;
//钱包按钮
@property (nonatomic, strong) UIButton * walletBtn;
//分享按钮
@property (nonatomic, strong) UIButton * shareBtn;
//跳转关注按钮
@property (nonatomic, strong) UIButton * toConcerBtn;
//跳转发送按钮
@property (nonatomic, strong) UIButton * tosendMessageBtn;
//头部视图
@property (nonatomic, strong) UIImageView * headImgView;
//磨砂颜色
@property (nonatomic, strong) UIView * effColorView;
//磨砂视图
@property (nonatomic, strong) UIVisualEffectView * effectview;
//活跃
@property (nonatomic, strong) UIButton * worksBtn;
//喜欢
@property (nonatomic, strong) UIButton * likesBtn;
//底部的线
@property (nonatomic, strong) UIView * bottomAnimationLine;

//用户模型
@property (nonatomic, strong) ShowUserModel * userModel;
//本人的表识
@property (nonatomic, assign) BOOL isMe;
//迷你卡
@property (nonatomic, assign) BOOL isMiniCard;
//文字高度
@property( nonatomic, assign) CGFloat labelHeight;
//代理
@property (nonatomic, weak) id<SLUserViewHeaderDelegate> delegate;
//控制器
@property (nonatomic, strong) BaseViewController * Controller;
//滚动视图
@property (nonatomic, strong) UIScrollView *scrollerContentView;

@end
