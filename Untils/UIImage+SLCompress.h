//
//  UIImage+SLCompress.h
//  ShowLive
//
//  Created by showgx on 2018/5/30.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_IMAGEPIX 1000.0 // max pix 200.0px


@interface UIImage (SLCompress)
//图像质量压缩
-(UIImage *)compressedImage;
-(NSData *)compressedData;
-(NSData *)compressedDataSize:(float)size;          //kb
-(NSData *)compressedDataWithRate;
-(NSData *)compressedData:(CGFloat)compressionQuality;
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;
- (UIImage *)cutCircleImage;
- (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
- (UIImage *)correctTheDirectionWithImage;
@end
