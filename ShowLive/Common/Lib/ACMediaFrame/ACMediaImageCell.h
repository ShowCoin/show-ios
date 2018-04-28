//
//  ACMediaImageCell.h
//
//  Created by  JokeSmileZhang on 16/12/2.
//  Copyright © 2016年 SnSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACMediaModel.h"
@class ACMediaImageCell;

@protocol ACMediaImageCellDelegate <NSObject>
@optional

-(void)selectCellBtn:(UIButton *)Btn clickedWithData:(id)celldata;

@end
/** 用于展示的 媒体图片cell */
@interface ACMediaImageCell : UICollectionViewCell
@property(nonatomic,weak)id<ACMediaImageCellDelegate>delegate;
@property (nonatomic,strong)ACMediaModel *model;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, assign) BOOL isLast;

/** 删除按钮 */
@property (nonatomic, strong) UIButton *selectBtn;

/** 视频标志 */
@property (nonatomic, strong) UIImageView *videoImageView;

/** 点击删除按钮的回调block */
@property (nonatomic, copy) void(^ACMediaClickDeleteButton)();

- (void)clickDeleteButton:(UIButton *)sender;

@end
