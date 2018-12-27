//
//  LPConfigView.h
//  Edu
//
//  Created by chenyh on 2018/9/19.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPConfigHeader.h"
#import "LPCoverView.h"
#import "LPRatioView.h"
#import "LPMoreView.h"
#import "LPAwardModeView.h"
#import "LPShareView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LPConfigViewDelegate;

@interface LPConfigView : UIView <LPAnimationProtocol>

/// 封面view
@property (nonatomic, strong, readonly) LPCoverView  *coverView;
/// 经典模式
@property (nonatomic, strong, readonly) LPMoreView      *modeView;
/// 观众奖励
@property (nonatomic, strong, readonly) LPAwardModeView *awardView;
/// 永久分成
@property (nonatomic, strong, readonly) LPRatioView *foreverView;
/// 临时分成
@property (nonatomic, strong, readonly) LPRatioView *tempView;
/// 标题
@property (nonatomic, strong, readonly) NSString  *title;
/// 分享view, 四个分享按钮
@property (nonatomic, strong, readonly) LPShareView *shareView;

@property (nonatomic, weak) id <LPConfigViewDelegate> delegate;

@property (nonatomic, assign, readonly) CGFloat viewH;

@property(nonatomic,assign)float total;

- (void)cx_updateAlpha:(CGFloat)alpha;

-(void)updateAwardTotal;

//- (UIImage *)sl_createShareImage;

-(void)updateTitle:(NSString*)title;

-(void)reduction;

@end

@protocol LPConfigViewDelegate <NSObject>

@optional

- (void)sl_configView:(LPConfigView *)view cameraFront:(BOOL)isFront;
- (void)sl_fillterActionWithConfigView:(LPConfigView *)view;
- (void)sl_startLivingWithConfigView:(LPConfigView *)view;
- (void)sl_changeCoverWithConfigView:(LPConfigView *)view;

@end



NS_ASSUME_NONNULL_END
