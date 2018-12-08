//
//  LPAwardPopView.h
//  Edu
//
//  Created by chenyh on 2018/9/20.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPopView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LPAwordPopBlock)(LPAwardType);

@interface LPAwardPopView : LPPopView

@property (nonatomic, copy) LPAwordPopBlock popBlock;

/// 首次d更新数据
- (void)sl_selectType:(LPAwardType)type;

@end


@interface LPAwardButton : UIButton

@property (nonatomic, assign) LPAwardType type;

@end

NS_ASSUME_NONNULL_END
