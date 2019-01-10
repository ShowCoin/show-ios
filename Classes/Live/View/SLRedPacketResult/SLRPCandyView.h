//
//  SLRPCandyView.h
//  Edu
//
//  Created by chenyh on 2018/8/9.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kRPOwnerUserWH;
UIKIT_EXTERN CGFloat const kRPLiveUserWH;

@class SLHeadPortrait;

@interface SLRPCandyView : UIView

@property (nonatomic, strong, readonly) UILabel *coinLabel;
@property (nonatomic, strong, readonly) UILabel *numLabel;
@property (nonatomic, strong, readonly) UILabel *rmbLabel;

@end

@interface SLRPOwnerView : UIView

@property (nonatomic, strong, readonly) SLHeadPortrait  *userView;
@property (nonatomic, strong, readonly) UILabel *nameLabel;
@property (nonatomic, strong, readonly) UILabel *invaLabel;

@end

@interface SLRPLiveView : UIView

@property (nonatomic, strong, readonly) SLHeadPortrait  *userView;
@property (nonatomic, strong, readonly) UILabel *nameLabel;
@property (nonatomic, strong, readonly) UILabel *titleLabel;

@end

typedef NS_ENUM(NSUInteger, SLRPMaskDirectionOption) {
    SLRPMaskDirectionOptionTopToBottom,
    SLRPMaskDirectionOptionBottomToTop,
};

@interface SLRPMaskView : UIView

@property (nonatomic, assign) SLRPMaskDirectionOption maskDirection;

@end


@interface SLRPMaskImageView : UIImageView

@end
