/*
     File: UIImageEffects.m
 Abstract: This class contains methods to apply blur and tint effects to an image. 
 This is the code you’ll want to look out to find out how to use vImage to 
 efficiently calculate a blur.
  Version: 1.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 
 */

#import "UIImage+Effects.h"
#import <QuartzCore/QuartzCore.h>

@import Accelerate;

@implementation UIImage(UIImageEffects)

+ (UIImage *)screenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    //  if (NULL != UIGraphicsBeginImageContextWithOptions) {
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    //    } else {
    //        UIGraphicsBeginImageContext(imageSize);
    //    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            
            CGContextConcatCTM(context, [window transform]);
            
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
            break;
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)fixOrientation:(UIImage *)aImage {

    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }

    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
            CGImageGetBitsPerComponent(aImage.CGImage), 0,
            CGImageGetColorSpace(aImage.CGImage),
            CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark -
#pragma mark - Effects

//| ----------------------------------------------------------------------------
- (UIImage *)imageByApplyingLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self imageByApplyingBlurToImage:self withRadius:60 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


//| ----------------------------------------------------------------------------
- (UIImage *)imageByApplyingExtraLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self imageByApplyingBlurToImage:self withRadius:40 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


//| ----------------------------------------------------------------------------
- (UIImage *)imageByApplyingDarkEffect
{
    UIColor *tintColor = HexRGBAlpha(0x000000, 0.70f);
    return [self imageByApplyingBlurToImage:self withRadius:40 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


//| ----------------------------------------------------------------------------
- (UIImage *)imageByApplyingTintEffectWithColor:(UIColor *)tintColor
{
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self imageByApplyingBlurToImage:self withRadius:20 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}

- (UIImage *)imageByApplyingTintEffectWithColor:(UIColor *)tintColor radius:(CGFloat)radius{
    return [self imageByApplyingBlurToImage:self withRadius:radius tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

#pragma mark -
#pragma mark - Implementation

//| ----------------------------------------------------------------------------
//! Applies a blur, tint color, and saturation adjustment to @a inputImage,
//! optionally within the area specified by @a maskImage.
//!
//! @param  inputImage
//!         The source image.  A modified copy of this image will be returned.
//! @param  blurRadius
//!         The radius of the blur in points.
//! @param  tintColor
//!         An optional UIColor object that is uniformly blended with the
//!         result of the blur and saturation operations.  The alpha channel
//!         of this color determines how strong the tint is.
//! @param  saturationDeltaFactor
//!         A value of 1.0 produces no change in the resulting image.  Values
//!         less than 1.0 will desaturation the resulting image while values
//!         greater than 1.0 will have the opposite effect.
//! @param  maskImage
//!         If specified, @a inputImage is only modified in the area(s) defined
//!         by this mask.  This must be an image mask or it must meet the
//!         requirements of the mask parameter of CGContextClipToMask.


//| ----------------------------------------------------------------------------
- (UIImage*)imageByApplyingBlurToImage:(UIImage*)inputImage withRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
#define ENABLE_BLUR                     1
#define ENABLE_SATURATION_ADJUSTMENT    1
#define ENABLE_TINT                     1
    
    // Check pre-conditions.
    if (inputImage.size.width < 1 || inputImage.size.height < 1)
    {
        NSLog(@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", inputImage.size.width, inputImage.size.height, inputImage);
        return nil;
    }
    if (!inputImage.CGImage)
    {
        NSLog(@"*** error: inputImage must be backed by a CGImage: %@", inputImage);
        return nil;
    }
    if (maskImage && !maskImage.CGImage)
    {
        NSLog(@"*** error: effectMaskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    
    CGImageRef inputCGImage = inputImage.CGImage;
    CGFloat inputImageScale = inputImage.scale;
    CGBitmapInfo inputImageBitmapInfo = CGImageGetBitmapInfo(inputCGImage);
    CGImageAlphaInfo inputImageAlphaInfo = (inputImageBitmapInfo & kCGBitmapAlphaInfoMask);
    
    CGSize outputImageSizeInPoints = inputImage.size;
    CGRect outputImageRectInPoints = { CGPointZero, outputImageSizeInPoints };
    
    // Set up output context.
    BOOL useOpaqueContext;
    if (inputImageAlphaInfo == kCGImageAlphaNone || inputImageAlphaInfo == kCGImageAlphaNoneSkipLast || inputImageAlphaInfo == kCGImageAlphaNoneSkipFirst)
        useOpaqueContext = YES;
    else
        useOpaqueContext = NO;
    UIGraphicsBeginImageContextWithOptions(outputImageRectInPoints.size, useOpaqueContext, inputImageScale);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -outputImageRectInPoints.size.height);
    
    if (hasBlur || hasSaturationChange)
    {
        vImage_Buffer effectInBuffer;
        vImage_Buffer scratchBuffer1;
        
        vImage_Buffer *inputBuffer;
        vImage_Buffer *outputBuffer;
        
        vImage_CGImageFormat format = {
            .bitsPerComponent = 8,
            .bitsPerPixel = 32,
            .colorSpace = NULL,
            // (kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little)
            // requests a BGRA buffer.
            .bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little,
            .version = 0,
            .decode = NULL,
            .renderingIntent = kCGRenderingIntentDefault
        };
        
        vImage_Error e = vImageBuffer_InitWithCGImage(&effectInBuffer, &format, NULL, inputImage.CGImage, kvImagePrintDiagnosticsToConsole);
        if (e != kvImageNoError)
        {
            NSLog(@"*** error: vImageBuffer_InitWithCGImage returned error code %zi for inputImage: %@", e, inputImage);
            UIGraphicsEndImageContext();
            return nil;
        }
        
        vImageBuffer_Init(&scratchBuffer1, effectInBuffer.height, effectInBuffer.width, format.bitsPerPixel, kvImageNoFlags);
        inputBuffer = &effectInBuffer;
        outputBuffer = &scratchBuffer1;
        
#if ENABLE_BLUR
        if (hasBlur)
        {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * inputImageScale;
            if (inputRadius - 2. < __FLT_EPSILON__)
                inputRadius = 2.;
            uint32_t radius = floor((inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5) / 2);
            
            radius |= 1; // force radius to be odd so that the three box-blur methodology works.
            
            NSInteger tempBufferSize = vImageBoxConvolve_ARGB8888(inputBuffer, outputBuffer, NULL, 0, 0, radius, radius, NULL, kvImageGetTempBufferSize | kvImageEdgeExtend);
            void *tempBuffer = malloc(tempBufferSize);
            
            vImageBoxConvolve_ARGB8888(inputBuffer, outputBuffer, tempBuffer, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(outputBuffer, inputBuffer, tempBuffer, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(inputBuffer, outputBuffer, tempBuffer, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            
            free(tempBuffer);
            
            vImage_Buffer *temp = inputBuffer;
            inputBuffer = outputBuffer;
            outputBuffer = temp;
        }
#endif
        
#if ENABLE_SATURATION_ADJUSTMENT
        if (hasSaturationChange)
        {
            CGFloat s = saturationDeltaFactor;
            // These values appear in the W3C Filter Effects spec:
            // https://dvcs.w3.org/hg/FXTF/raw-file/default/filters/index.html#grayscaleEquivalent
            //
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,                    1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            vImageMatrixMultiply_ARGB8888(inputBuffer, outputBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            
            vImage_Buffer *temp = inputBuffer;
            inputBuffer = outputBuffer;
            outputBuffer = temp;
        }
#endif
        
        CGImageRef effectCGImage;
        if ( (effectCGImage = vImageCreateCGImageFromBuffer(inputBuffer, &format, &cleanupBuffer, NULL, kvImageNoAllocate, NULL)) == NULL ) {
            effectCGImage = vImageCreateCGImageFromBuffer(inputBuffer, &format, NULL, NULL, kvImageNoFlags, NULL);
            free(inputBuffer->data);
        }
        if (maskImage) {
            // Only need to draw the base image if the effect image will be masked.
            CGContextDrawImage(outputContext, outputImageRectInPoints, inputCGImage);
        }
        
        // draw effect image
        CGContextSaveGState(outputContext);
        if (maskImage)
            CGContextClipToMask(outputContext, outputImageRectInPoints, maskImage.CGImage);
        CGContextDrawImage(outputContext, outputImageRectInPoints, effectCGImage);
        CGContextRestoreGState(outputContext);
   
        // Cleanup
        CGImageRelease(effectCGImage);
        free(outputBuffer->data);
    }
    else
    {
        // draw base image
        CGContextDrawImage(outputContext, outputImageRectInPoints, inputCGImage);
    }
    
#if ENABLE_TINT
    // Add in color tint.
    if (tintColor)
    {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, outputImageRectInPoints);
        CGContextRestoreGState(outputContext);
    }
#endif
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
 
    return outputImage;
#undef ENABLE_BLUR
#undef ENABLE_SATURATION_ADJUSTMENT
#undef ENABLE_TINT
}


//| ----------------------------------------------------------------------------
//  Helper function to handle deferred cleanup of a buffer.
//
void cleanupBuffer(void *userData, void *buf_data)
{ free(buf_data); }

@end

