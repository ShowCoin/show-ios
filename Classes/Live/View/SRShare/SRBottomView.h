//
//  SRBottomView.h
//  ShowLive
//
//  Created by chenyh on 2019/1/15.
//  Copyright © 2019 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRBottomView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *show;
@property (nonatomic, strong) NSString *name;

+ (CGFloat)viewH;

@end

NS_ASSUME_NONNULL_END
