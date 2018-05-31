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


@end
