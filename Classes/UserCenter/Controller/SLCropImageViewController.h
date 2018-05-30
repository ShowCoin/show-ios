//
//  SLCropImageViewController.h
//  ShowLive
//
//  Created by iori_chou on 2018/5/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"

@interface SLCropImageViewController : BaseViewController

@property (nonatomic,assign)BOOL isShoot;

- (instancetype)initWithCropImage:(UIImage *)cropImage;

@end
