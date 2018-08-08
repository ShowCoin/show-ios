//
//  SLRPResultCell.h
//  demoPro
//
//  Created by chenyh on 2018/7/31.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kSLRPResultCellH;

@interface SLRPResultCell : UITableViewCell

/// cellID
@property (nonatomic, readonly, class) NSString *kCellID;

@property (nonatomic, strong) NSDictionary *info;

@end
