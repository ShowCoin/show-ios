//
//

//  XHPhotoExample
//
//  Created by showgx on 17/2/1.
//  Copyright © 2017年 show. All rights reserved.


#import <UIKit/UIKit.h>

typedef void(^photoBlock)(UIImage *photo);

@interface UIViewController (XHPhoto)

/**
 *  照片选择->图库/相机
 *
 *  @param edit  照片是否需要裁剪,默认NO
 *  @param block 照片回调
 */
-(void)showCanEdit:(BOOL)edit photo:(photoBlock)block;


/**
 *  照片选择->相机
 *
 *  @param edit  照片是否需要裁剪,默认NO
 *  @param block 照片回调
 */
-(void)takephtoEdit:(BOOL)edit photo:(photoBlock)block;


@end
