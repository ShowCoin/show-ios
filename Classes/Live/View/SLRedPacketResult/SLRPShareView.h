//
//  SLRPShareView.h
//  Edu
//
//  Created by chenyh on 2018/8/9.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdateImageBlock)(void);

typedef void(^shareUrlBlock)(NSString * url);
/// 弹出view的载体  类似cell
@interface SLRPAnimatorView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong, readonly) UIImage *snapshotImage;

@end

@class SLGetCandyInfoModel;

@interface SLRPShareView : SLRPAnimatorView

/// 糖果模型 包含糖果信息
@property (nonatomic, strong) SLGetCandyInfoModel *model;
@property (nonatomic, copy) UpdateImageBlock updateImage;
@property (nonatomic,copy) shareUrlBlock urlBlock;

+ (instancetype)shareView;
/// 更新主播数据
- (void)updateLive:(id)liveModel title:(NSString *)title;

- (void)hiddenView;

-(void)requestActionLink;

@property (nonatomic,copy)NSString *liveId;


@end

@interface SLShareImageView : SLRPShareView

@end
