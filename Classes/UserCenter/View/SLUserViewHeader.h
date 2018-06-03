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

@property (nonatomic,strong)UILabel * navLab;
@property (nonatomic,strong)UIButton * leftBtn;
@property (nonatomic,strong)UIButton * listBtn;
@property (nonatomic,strong)UIButton * settingBtn;
@property (nonatomic,strong)UIButton * giftStoreBtn;
@property (nonatomic,strong)SLHeadPortrait * headPortrait;
@property (nonatomic,strong)UILabel * nickLab;

@property (nonatomic,strong)SLLevelMarkView *  masterLevel;
@property (nonatomic,strong)SLLevelMarkView *  showLevel;

@property (nonatomic,strong)UIView * sexbg;
@property (nonatomic,strong)UIImageView * sexImg;
@property (nonatomic,strong)UILabel * sexlab;
@property (nonatomic,strong)UILabel * cityLab;
@property (nonatomic,strong)UILabel * constellationLab;

//@property (nonatomic,strong)UILabel * idPreLab;
@property (nonatomic,strong)UILabel * idLab;
@property (nonatomic,strong)UILabel * wordsLab;
@property (nonatomic,strong)UIView * bottomWhiteView;
@property (nonatomic,strong)UIButton * fansBtn;
@property (nonatomic,strong)UIButton * concerBtn;
@property (nonatomic,strong)UIButton * walletBtn;
@property (nonatomic,strong)UIButton * shareBtn;
@property (nonatomic,strong)UIButton * toConcerBtn;
@property (nonatomic,strong)UIButton * tosendMessageBtn;
//头部视图
@property (nonatomic,strong)UIImageView * headImgView;
//磨砂颜色
@property (nonatomic,strong)UIView * effColorView;
//磨砂视图
@property (nonatomic,strong)UIVisualEffectView * effectview;
//活跃
@property (nonatomic,strong)UIButton * worksBtn;
//喜欢
@property (nonatomic,strong)UIButton * likesBtn;
//底部的线
@property (nonatomic,strong)UIView * bottomAnimationLine;

//用户模型
@property (nonatomic,strong)ShowUserModel * userModel;
//本人的表识
@property(nonatomic,assign)BOOL isMe;
//迷你卡
@property(nonatomic,assign)BOOL isMiniCard;
//文字高度
@property(nonatomic,assign)CGFloat labelHeight;
//代理
@property (nonatomic, weak) id<SLUserViewHeaderDelegate> delegate;
//控制器
@property(nonatomic,strong)BaseViewController * Controller;
//滚动视图
@property(nonatomic, strong)UIScrollView *scrollerContentView;
@end
