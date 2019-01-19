//
//  SRLeftView.h
//  ShowLive
//
//  Created by chenyh on 2019/1/16.
//  Copyright © 2019 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRLeftView : UITableView

+ (instancetype)leftView;
+ (CGFloat)viewH;

@property (nonatomic, strong) NSArray *values;

@end

NS_ASSUME_NONNULL_END
