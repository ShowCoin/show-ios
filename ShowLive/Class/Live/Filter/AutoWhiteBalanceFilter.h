//
//  Created by Wang Tao on 22/06/2016.
//  Copyright (c) 2016 Wang Tao. All rights reserved.
//

//#import "GPUImageFilterGroup.h"
//#import "GPUImageHistogramFilter.h"
//#import "GPUImageRawDataOutput.h"
//#import "GPUImageRawDataInput.h"
//#import "GPUImageTwoInputFilter.h"
#import "GPUImage.h"

@interface AutoWhiteBalanceFilter : GPUImageFilterGroup
{
    GPUImageHistogramFilter *histogramFilter;
    GPUImageRawDataOutput *rawDataOutputFilter;
    GPUImageRawDataInput *rawDataInputFilter;
}

@property(readwrite, nonatomic) NSUInteger downsamplingFactor;

- (id)initWithHistogramType:(GPUImageHistogramType)newHistogramType;

@end
