//
//  UIImage+Additional.h
//  
//
//  Created by Bob on 15/4/10.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT CGRect swapWidthAndHeight(CGRect rect);

@interface UIImage (Additional)
/**
 *  @brief 通过色值生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/*
 *  extend stretchableImageWithLeftCapWidth:topCapHeight on ios5++
 *
 *  on ios4 make sure your capInsets's left as stretchableImageWithLeftCapWidth:topCapHeight 's width and capInsets'top as stretchableImageWithLeftCapWidth:topCapHeight 's height
 *  on ios5&ios5++ like call resizableImageWithCapInsets:
 */
- (UIImage *)resizableImageExtendWithCapInsets:(UIEdgeInsets)capInsets;


/*
 * Creates an image from the contents of a URL
 */
+ (UIImage*)imageWithContentsOfURL:(NSURL*)url;

/*
 * Scales the image to the given size
 */
- (UIImage*)scaleToSize:(CGSize)size;

/*
 *高斯模糊效果，渲染很费电，占内存，慎用。
 */
- (UIImage *)blurred;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

/**
 *  将某个视图渲染成一张图片
 */
+ (UIImage *)createImageFromView:(UIView *)view;

/**
 * 缩放图片
 */
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 *  降低图片质量
 *
 *  @param quality 值在0.1~1.0之间
 *
 *  @return <#return value description#>
 */
- (UIImage *)imageWithQuality:(CGFloat)quality;

/**
 *  截取图片中区域的内容
 *
 */
- (UIImage *)imageWithWithRect:(CGRect)rect;
/**
 *  截取图片中某个区域的内容，并生成一个固定尺寸大小的图片
 *
 *  @param rect      原图片的区域
 *  @param imageSize 图片大小
 *
 *  @return <#return value description#>
 */
- (UIImage *)imageWithWithRect:(CGRect)rect size:(CGSize)imageSize;

/**
 *  根据宽高比例生成一张新图，若是当前图的比例与新生成的图比例不一样，则截取中间部分
 *
 *  @param ratio 生成的新图的宽高比例
 *
 *  @return <#return value description#>
 */
- (UIImage *)createImageWithRatio:(CGFloat)ratio;

/**
 *  缩放一张图片到对应大小，若是图片大小比例不一样，则取中间部分
 *
 *  @param size size
 *
 *  @return UIImage
 */
- (UIImage *)scaleImageToSize:(CGSize)size;

/**
 * 图片镜像翻转
 */

-(UIImage*)rotate:(UIImageOrientation)orient;
/**
 * 图片尺寸修改
 */
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

//+ (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer;
+(UIImage*) createImageWithColor:(UIColor*) color;

+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize;
#pragma mark - 创建二维码/条形码
+ (UIImage *)createNonInterpolatedUIImageFormStr:(NSString *)str type:(NSInteger )type;
#pragma mark - 截屏
+ (UIImage *)screenshot;
+ (UIImage *)snapshotScreenInView:(UIView *)contentView;
//拉伸图片
- (UIImage *)StretchImageWithInsets:(UIEdgeInsets)insets;

/*
 *  压缩图片方法(先压缩质量再压缩尺寸)
 */
-(NSData *)compressWithLengthLimit:(NSUInteger)maxLength;
/*
 *  压缩图片方法(压缩质量)
 */
-(NSData *)compressQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩质量二分法)
 */
-(NSData *)compressMidQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩尺寸)
 */
-(NSData *)compressBySizeWithLengthLimit:(NSUInteger)maxLength;
@end
