//
//  Created by Wang Tao on 22/06/2016.
//  Copyright (c) 2016 Wang Tao. All rights reserved.
//

#import "AutoWhiteBalanceFilter.h"


NSString *const kGPUImageRGBAWBFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     lowp float redCurveValue = texture2D(inputImageTexture2, vec2(textureColor.r, 0.0)).r;
     lowp float greenCurveValue = texture2D(inputImageTexture2, vec2(textureColor.g, 0.0)).g;
     lowp float blueCurveValue = texture2D(inputImageTexture2, vec2(textureColor.b, 0.0)).b;
     
     gl_FragColor = vec4(redCurveValue, greenCurveValue, blueCurveValue, textureColor.a);
 }
 );
NSString *const kGPUImageLuminanceAWBFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 const lowp vec3 W = vec3(0.2125, 0.7154, 0.0721);
 
 void main()
 {
     lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     lowp float luminance = dot(textureColor.rgb, W);
     lowp float newLuminance = texture2D(inputImageTexture2, vec2(luminance, 0.0)).r;
     lowp float deltaLuminance = newLuminance - luminance;
     
     lowp float red   = clamp(textureColor.r + deltaLuminance, 0.0, 1.0);
     lowp float green = clamp(textureColor.g + deltaLuminance, 0.0, 1.0);
     lowp float blue  = clamp(textureColor.b + deltaLuminance, 0.0, 1.0);
     
     gl_FragColor = vec4(red, green, blue, textureColor.a);
 }
 );

@implementation AutoWhiteBalanceFilter

@synthesize downsamplingFactor = _downsamplingFactor;

#pragma mark -
#pragma mark Initialization

- (id)init;
{
    if (!(self = [self initWithHistogramType:kGPUImageHistogramRGB]))
    {
        return nil;
    }
    
    return self;
}

- (id)initWithHistogramType:(GPUImageHistogramType)newHistogramType
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    histogramFilter = [[GPUImageHistogramFilter alloc] initWithHistogramType:newHistogramType];
    [self addFilter:histogramFilter];
    
    GLubyte dummyInput[4 * 256]; // NB: No way to initialise GPUImageRawDataInput without providing bytes
    rawDataInputFilter = [[GPUImageRawDataInput alloc] initWithBytes:dummyInput size:CGSizeMake(256.0, 1.0) pixelFormat:GPUPixelFormatRGBA type:GPUPixelTypeUByte];
    rawDataOutputFilter = [[GPUImageRawDataOutput alloc] initWithImageSize:CGSizeMake(256.0, 3.0) resultsInBGRAFormat:YES];
    
    __unsafe_unretained GPUImageRawDataOutput *_rawDataOutputFilter = rawDataOutputFilter;
    __unsafe_unretained GPUImageRawDataInput *_rawDataInputFilter = rawDataInputFilter;
    [rawDataOutputFilter setNewFrameAvailableBlock:^{
        
        unsigned int histogramBins[3][256];
        int          minR=0,minG=0,minB=0,maxR=255,maxG=255,maxB=255;
        int          dataIndex,binIndex;
        long         rSize,gSize,bSize,maxSize;
        
        [_rawDataOutputFilter lockFramebufferForReading];
        
        GLubyte *data  = [_rawDataOutputFilter rawBytesForImage];
        NSUInteger size = [_rawDataOutputFilter bytesPerRowInOutput];
        __unused GLubyte *start = data;
        data += size;
        
        histogramBins[0][0] = *data++;
        histogramBins[1][0] = *data++;
        histogramBins[2][0] = *data++;
        data++;
        
        for (unsigned int x = 1; x < 256; x++) {
            histogramBins[0][x] = histogramBins[0][x-1] + *data++;
            histogramBins[1][x] = histogramBins[1][x-1] + *data++;
            histogramBins[2][x] = histogramBins[2][x-1] + *data++;
            data++;
        }
        
        rSize = histogramBins[0][255];
        gSize = histogramBins[1][255];
        bSize = histogramBins[2][255];
        maxSize = rSize>gSize?rSize:gSize;
        maxSize = maxSize>bSize?maxSize:bSize;
//        if(maxSize<30000) maxSize=41000;
//        rSize = maxSize;
//        gSize = maxSize;
//        bSize = maxSize;
        
        [_rawDataOutputFilter unlockFramebufferAfterReading];
        
        GLubyte colorMapping[4 * 256];
        GLubyte *_colorMapping = colorMapping;

//        if(maxSize>30000)
//        {
        for (dataIndex=0;dataIndex<256;dataIndex++) {
            if ((double)(histogramBins[0][dataIndex]) <= (double)rSize*1.0/100) {
                minR = minR + 1;
            }
            else {
                break;
            }
        }
        for (dataIndex=0;dataIndex<256;dataIndex++) {
            if ((double)(histogramBins[1][dataIndex]) <= (double)gSize*1.0/100 ){
                minG = minG + 1;
            }
            else {
                break;
            }
        }
        for (dataIndex=0;dataIndex<256;dataIndex++) {
            if( (double)(histogramBins[2][dataIndex]) <= (double)bSize*1.0/100) {
                minB = minB + 1;
            }
            else {
                break;
            }
        }
        //
        for (dataIndex=255;dataIndex>=0;dataIndex--) {
            if( (double)(histogramBins[0][dataIndex]) > (double)rSize*99.0/100 ){
                maxR = maxR - 1;
            }
            else {
                break;
            }
        }
        if(maxR<255) maxR++;
        
        for (dataIndex=255;dataIndex>=0;dataIndex--) {
            if ((double)(histogramBins[1][dataIndex]) > (double)gSize*99.0/100 ){
                maxG = maxG - 1;
            }
            else {
                break;
            }
        }
        if(maxG<255) maxG++;

        for (dataIndex=255;dataIndex>=0;dataIndex--) {
            if((double)(histogramBins[2][dataIndex]) > (double)bSize*99.0/100 ){
                maxB = maxB - 1;
            }
            else {
                break;
            }
        }
        if(maxB<255) maxB++;
        
        
//        GLubyte colorMapping[4 * 256];
//        GLubyte *_colorMapping = colorMapping;
        
        double  diffR = (maxR-minR);
        double  diffG = (maxG-minG);
        double  diffB = (maxB-minB);
        
#if 0
        for(binIndex=0;binIndex<minR;binIndex++){
            _colorMapping[binIndex * 4] = 0;
        }
        for(binIndex=minR;binIndex<maxR;binIndex++ ){
            _colorMapping[binIndex * 4] = (GLubyte)((double)(binIndex-minR)*255/diffR+0.5);
        }
        for(binIndex=maxR;binIndex<256;binIndex++ ){
            _colorMapping[binIndex * 4] = 255;
        }
        if((diffR-diffG)>10&&(diffB-diffG)>10){
            for (binIndex = 0; binIndex < 256; binIndex++) {
                _colorMapping[binIndex*4+1] =(GLubyte)((double)binIndex+0.5);
            }
        }
        else{
            for(binIndex=0;binIndex<minG;binIndex++ ){
                _colorMapping[binIndex * 4+1] = 0;
            }
            for (binIndex=minG;binIndex<maxG;binIndex++ ){
                _colorMapping[binIndex * 4+1] = (GLubyte)((double)(binIndex-minG)*255/diffG+0.5);
            }
            for (binIndex=maxG;binIndex<256;binIndex++) {
                _colorMapping[binIndex * 4+1] = 255;
            }
        }
        
        for(binIndex=0;binIndex<minB;binIndex++) {
            _colorMapping[binIndex * 4+2] = 0;
        }
        for(binIndex=minB;binIndex<maxB;binIndex++ ){
            _colorMapping[binIndex * 4+2] = (GLubyte)((double)(binIndex-minB)*255/diffB+0.5);
        }
        for (binIndex=maxB;binIndex<256;binIndex++ ){
            _colorMapping[binIndex * 4+2] = 255;
        }
        
        for (binIndex=0;binIndex<256;binIndex++) {
            _colorMapping[(binIndex * 4) + 3] = 255;
        }
//        }
//        else{
//            for (unsigned int x = 0; x < 256; x++) {
//                _colorMapping[x*4]   =(GLubyte)((double)(x-0)*255/255+0.5);
//                _colorMapping[x*4+1] =(GLubyte)((double)(x-0)*255/255+0.5);
//                _colorMapping[x*4+2] =(GLubyte)((double)(x-0)*255/255+0.5);
//                _colorMapping[x*4+3] =(GLubyte)((double)(x-0)*255/255+0.5);
//            }
//
//        }
#else
        if((fabs(diffR-diffG)>10&&fabs(diffB-diffG)>10)||(diffR<10&&diffG<10&&diffB<10)
           ||(diffR+diffG<20||diffR+diffB<20||diffG+diffB<20)){
            for (unsigned int x = 0; x < 256; x++) {
                _colorMapping[x*4]   =(GLubyte)((double)(x-0)*255/255+0.5);
                _colorMapping[x*4+1] =(GLubyte)((double)(x-0)*255/255+0.5);
                _colorMapping[x*4+2] =(GLubyte)((double)(x-0)*255/255+0.5);
                _colorMapping[x*4+3] =255;
            }
        }
        else{
            for(binIndex=0;binIndex<minR;binIndex++){
                _colorMapping[binIndex * 4] = 0;
            }
            for(binIndex=minR;binIndex<maxR;binIndex++ ){
                _colorMapping[binIndex * 4] = (GLubyte)((double)(binIndex-minR)*255/diffR+0.5);
            }
            for(binIndex=maxR;binIndex<256;binIndex++ ){
                _colorMapping[binIndex * 4] = 255;
            }
            for(binIndex=0;binIndex<minG;binIndex++ ){
                _colorMapping[binIndex * 4+1] = 0;
            }
            for (binIndex=minG;binIndex<maxG;binIndex++ ){
                _colorMapping[binIndex * 4+1] = (GLubyte)((double)(binIndex-minG)*255/diffG+0.5);
            }
            for (binIndex=maxG;binIndex<256;binIndex++) {
                _colorMapping[binIndex * 4+1] = 255;
            }
            
            for(binIndex=0;binIndex<minB;binIndex++) {
                _colorMapping[binIndex * 4+2] = 0;
            }
            for(binIndex=minB;binIndex<maxB;binIndex++ ){
                _colorMapping[binIndex * 4+2] = (GLubyte)((double)(binIndex-minB)*255/diffB+0.5);
            }
            for (binIndex=maxB;binIndex<256;binIndex++ ){
                _colorMapping[binIndex * 4+2] = 255;
            }
            
            for (binIndex=0;binIndex<256;binIndex++) {
                _colorMapping[(binIndex * 4) + 3] = 255;
            }
        }
        
#endif
        _colorMapping = colorMapping;
        [_rawDataInputFilter updateDataFromBytes:_colorMapping size:CGSizeMake(256.0, 1.0)];
        [_rawDataInputFilter processData];
    }];
    [histogramFilter addTarget:rawDataOutputFilter];
    
    NSString *fragmentShader = nil;
    switch (newHistogramType) {
        default:
        case kGPUImageHistogramRGB:
            fragmentShader = kGPUImageRGBAWBFragmentShaderString;
            break;
        case kGPUImageHistogramLuminance:
            fragmentShader = kGPUImageLuminanceAWBFragmentShaderString;
            break;
    }
    GPUImageFilter *equalizationFilter = [[GPUImageTwoInputFilter alloc] initWithFragmentShaderFromString:fragmentShader];
    [rawDataInputFilter addTarget:equalizationFilter atTextureLocation:1];
    
    [self addFilter:equalizationFilter];
    
    self.initialFilters = [NSArray arrayWithObjects:histogramFilter, equalizationFilter, nil];
    self.terminalFilter = equalizationFilter;
    
    self.downsamplingFactor = 16;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setDownsamplingFactor:(NSUInteger)newValue;
{
    if (_downsamplingFactor != newValue)
    {
        _downsamplingFactor = newValue;
        histogramFilter.downsamplingFactor = newValue;
    }
}

@end
