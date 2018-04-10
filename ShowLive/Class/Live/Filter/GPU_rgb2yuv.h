//
//  GPU_rgb2yuv.h
//  funlive
//
//  Created by Wang Tao on 16/6/28.
//  Copyright © 2016年 renzhen. All rights reserved.
//

#ifndef GPU_rgb2yuv_h
#define GPU_rgb2yuv_h

#import "GPUImage.h"

@interface GPURGB2YUV : GPUImageFilter
{
    GLint texelWidthUniform, texelHeightUniform;
    bool hasOverriddenImageSizeFactor;
}
@end

#endif /* GPU_rgb2yuv_h */
