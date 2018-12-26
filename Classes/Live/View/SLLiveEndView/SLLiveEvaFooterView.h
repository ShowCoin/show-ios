//
//  SLLiveEvaFooterView.h
//  ShowLive
//
//  Created by gongxin on 2018/9/28.
//  Copyright © 2018 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLLiveEvaFooterView : UIView

@property(nonatomic,strong)UIImageView * show;
@property(nonatomic,strong)UIButton * shareBtn;
@property(nonatomic,strong)UIButton * liveBtn;

@property (nonatomic, assign) CGFloat progress;

@end

// 40按钮高度 8顶部距离 8底部距离
static CGFloat const kEvaFooterH = 40 + 8 + 8;

NS_ASSUME_NONNULL_END
