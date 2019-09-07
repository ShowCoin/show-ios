//
//  ShowHomeSamallCell.h
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowHomeSamallCell : UICollectionViewCell<HeadPortraitDelegate>
@property (nonatomic, strong) YYAnimatedImageView *coverImage;
@property (nonatomic, strong) SLLiveListModel          * dataModel;
@property (nonatomic, strong) SLHeadPortrait           * headPortrait;
@property (nonatomic, strong) UILabel                  * nickName;

@end
