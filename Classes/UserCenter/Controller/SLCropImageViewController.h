//
//  SLCropImageViewController.h
//  ShowLive
//
//  Created by iori_chou on 2018/5/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
//裁剪图片
@interface SLCropImageViewController : BaseViewController
//是否拍照
@property (nonatomic,assign)BOOL isShoot;
//根据cropImage初始化
- (instancetype)initWithCropImage:(UIImage *)cropImage;

@end
