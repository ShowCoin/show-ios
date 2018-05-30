//
//  SLHorizontalView.h
//  ShowLive
//
//  Created by 陈英豪 on 2018/5/30.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const kHorizontalViewTitle;
UIKIT_EXTERN NSString * const kHorizontalViewImage;
UIKIT_EXTERN CGFloat const kSLHorizontalViewH;
UIKIT_EXTERN NSInteger const kRowCount;

@interface SLHorizontalView : UIView

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) SLOneBlock clickBlock;

@end
