//
//  SLMoreCollectionViewCell.h
//  ShowLive
//
//  Created by gongxin on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLLMModel;

static NSString * const kSLMoreCollectionViewCellID = @"kSLMoreCollectionViewCellID";

@interface SLMoreCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SLLMModel *model;

@end

@interface SLLMModel : NSObject

@end
