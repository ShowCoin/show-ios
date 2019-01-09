//
//  SIWeekView.h
//  Edu
//
//  Created by chenyh on 2018/9/29.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIWeekView : UIView

+ (instancetype)weekView;

@property (nonatomic, assign) SIWeekDisplayState state;

- (void)show;

@end

NS_ASSUME_NONNULL_END
