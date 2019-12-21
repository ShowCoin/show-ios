//
//  SLCountryCover.h
//  ShowLive
//
//  Created by chenyh on 2019/11/28.
//  Copyright © 2019 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLCountryCover : UIView

@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, copy) SLOneBlock selectBlock;
@property (nonatomic, assign) BOOL hideTable;

@end

NS_ASSUME_NONNULL_END
