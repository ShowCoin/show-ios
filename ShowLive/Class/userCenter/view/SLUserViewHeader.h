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

@optional

@end
@interface SLUserViewHeader : UICollectionReusableView<HeadPortraitDelegate>
@property (nonatomic,strong)UILabel * navLab;
@property (nonatomic,strong)UIButton * listBtn;
@property (nonatomic,strong)UIButton * settingBtn;
@property (nonatomic,strong)SLHeadPortrait * headPortrait;
@property (nonatomic,strong)UILabel * nickLab;

@property (nonatomic,strong)SLLevelMarkView *  masterLevel;
@property (nonatomic,strong)SLLevelMarkView *  showLevel;

@property (nonatomic,strong)UIView * sexbg;
@property (nonatomic,strong)UIImageView * sexImg;
@property (nonatomic,strong)UILabel * sexlab;
@property (nonatomic,strong)UILabel * cityLab;
@property (nonatomic,strong)UILabel * constellationLab;

@property (nonatomic,strong)UILabel * idLab;
@property (nonatomic,strong)UILabel * wordsLab;
@property (nonatomic,strong)UIView * bottomWhiteView;
@property (nonatomic,strong)UIButton * fansBtn;
@property (nonatomic,strong)UIButton * concerBtn;
@property (nonatomic,strong)UIButton * walletBtn;
@property (nonatomic,strong)UIButton * shareBtn;
@property (nonatomic,strong)UIButton * toConcerBtn;

@property (nonatomic,strong)UIImageView * headImgView;
@property (nonatomic,strong)UIView * effColorView;
@property (nonatomic,strong)UIVisualEffectView * effectview;

@property (nonatomic,strong)UIButton * worksBtn;
@property (nonatomic,strong)UIButton * likesBtn;

@property (nonatomic,strong)ShowUserModel * userModel;
@property(nonatomic,assign)BOOL isMe;
@property(nonatomic,assign)CGFloat labelHeight;
@property (nonatomic, weak) id<SLUserViewHeaderDelegate> delegate;


@end
