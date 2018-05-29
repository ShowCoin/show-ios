//
//  SLToolView.h
//  ShowLive
//
//  Created by 陈英豪 on 2018/5/28.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kSLToolViewH;

@protocol SLToolViewDelegate

@end

typedef NS_ENUM(NSUInteger, SLLiveToolType) {
    SLLiveToolTypePause = 0,
    SLLiveToolTypeClear,
        
};

typedef void(^SLToolClickBlock)(SLLiveToolType);

@interface SLToolView : UIView

@property (nonatomic, assign) BOOL clearSelect;
@property (nonatomic, copy) SLToolClickBlock clickBlock;

- (void)resetView;

@end

@interface SLTitleView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@end
