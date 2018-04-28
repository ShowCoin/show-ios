//
//  SLLiveBottomCollectionViewCell.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/13.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SLLiveBottomViewCellType) {
    
    SLLiveBottomViewCellTypeOnlyImage=0,
    SLLiveBottomViewCellTypeText,
    SLLiveBottomViewCellTypeInput,
};

@interface SLLiveBottomCollectionViewCell : UICollectionViewCell


@property(nonatomic,assign)SLLiveBottomViewCellType type;

@property(nonatomic,copy)NSString * icon;

@property(nonatomic,assign)BOOL redPointHidden;

@end
