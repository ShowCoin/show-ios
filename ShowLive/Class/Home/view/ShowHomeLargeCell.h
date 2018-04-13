//
//  ShowHomeLargeCell.h
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowHomeLargeCell : UICollectionViewCell
@property (nonatomic, strong) YYAnimatedImageView    * coverImage;
@property (nonatomic, strong) UIButton               * headPortraitBtn;
@property (nonatomic, strong) UIButton               * addBtn;
@property (nonatomic, strong) UIButton               * thumbBtn;
@property (nonatomic, strong) UIButton               * commentBtn;
@property (nonatomic, strong) UIButton               * shareBtn;
@property (nonatomic, strong) UILabel                * peopleNum;
@property (nonatomic, strong) UILabel                * peopleText;
@property (nonatomic, strong) UILabel                * nickName;
@property (nonatomic, strong) UILabel                * liveTitle;

@end
