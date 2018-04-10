#import "ImageRawDataOutput.h"

#import "GPUImageContext.h"
#import "GLProgram.h"
#import "GPUImageFilter.h"
#import "GPUImageMovieWriter.h"

@interface ImageRawDataOutput ()
{
    GPUImageFramebuffer *firstInputFramebuffer, *outputFramebuffer, *retainedFramebuffer;
    
    BOOL hasReadFromTheCurrentFrame;
    
    GLProgram *dataProgram;
    GLint dataPositionAttribute, dataTextureCoordinateAttribute;
    GLint dataInputTextureUniform;
    GLint textureSizeUniform;
    
    GLubyte *_rawBytesForImage;
    
    BOOL lockNextFramebuffer;
}

// Frame rendering
- (void)renderAtInternalSize;

@end

@implementation ImageRawDataOutput

@synthesize rawBytesForImage = _rawBytesForImage;
@synthesize newFrameAvailableBlock = _newFrameAvailableBlock;
@synthesize enabled;

#pragma mark -
#pragma mark Initialization and teardown

- (id)initWithImageSize:(CGSize)newImageSize resultsInBGRAFormat:(BOOL)resultsInBGRAFormat;
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    self.enabled = YES;
    lockNextFramebuffer = NO;
    imageSize = newImageSize;
    hasReadFromTheCurrentFrame = NO;
    _rawBytesForImage = NULL;
    inputRotation = kGPUImageNoRotation;
    
    [GPUImageContext useImageProcessingContext];
    
    dataProgram = [[GPUImageContext sharedImageProcessingContext] programForVertexShaderString:kGPUImageVertexShaderString fragmentShaderString:kGPUImagePassthroughFragmentShaderString];
  
    if (!dataProgram.initialized)
    {
        [dataProgram addAttribute:@"position"];
        [dataProgram addAttribute:@"inputTextureCoordinate"];
        
        if (![dataProgram link])
        {
            NSString *progLog = [dataProgram programLog];
            NSLog(@"Program link log: %@", progLog);
            NSString *fragLog = [dataProgram fragmentShaderLog];
            NSLog(@"Fragment shader compile log: %@", fragLog);
            NSString *vertLog = [dataProgram vertexShaderLog];
            NSLog(@"Vertex shader compile log: %@", vertLog);
            dataProgram = nil;
            NSAssert(NO, @"Filter shader link failed");
        }
    }
    
    dataPositionAttribute = [dataProgram attributeIndex:@"position"];
    dataTextureCoordinateAttribute = [dataProgram attributeIndex:@"inputTextureCoordinate"];
    dataInputTextureUniform = [dataProgram uniformIndex:@"inputImageTexture"];
    textureSizeUniform = [dataProgram uniformIndex:@"textureSize"];
    
    [GPUImageContext setActiveShaderProgram:dataProgram];
    glEnableVertexAttribArray(dataPositionAttribute);
    glEnableVertexAttribArray(dataTextureCoordinateAttribute);
    GLfloat sizeArray[2];
    sizeArray[0] = imageSize.width;
    sizeArray[1] = imageSize.height;
    
    glUniform2fv(textureSizeUniform, 1, sizeArray);
    
    static const GLfloat squareVertices[] = {
        -1.0f, -1.0f,
        1.0f, -1.0f,
        -1.0f,  1.0f,
        1.0f,  1.0f,
    };
    
    static const GLfloat textureCoordinates[] = {
        0.0f, 0.0f,
        1.0f, 0.0f,
        0.0f, 1.0f,
        1.0f, 1.0f,
    };
    
    
    glVertexAttribPointer(dataPositionAttribute, 2, GL_FLOAT, 0, 0, squareVertices);
    glVertexAttribPointer(dataTextureCoordinateAttribute, 2, GL_FLOAT, 0, 0, textureCoordinates);
    
    return self;
}

- (void)dealloc
{
    if (_rawBytesForImage != NULL && (![GPUImageContext supportsFastTextureUpload]))
    {
        free(_rawBytesForImage);
        _rawBytesForImage = NULL;
    }
}

#pragma mark -
#pragma mark Data access

- (void)renderAtInternalSize;
{
    [GPUImageContext setActiveShaderProgram:dataProgram];
    outputFramebuffer = [[GPUImageContext sharedFramebufferCache] fetchFramebufferForSize:imageSize onlyTexture:NO];
    [outputFramebuffer activateFramebuffer];
    
    if(lockNextFramebuffer)
    {
        retainedFramebuffer = outputFramebuffer;
        [retainedFramebuffer lock];
        [retainedFramebuffer lockForReading];
        lockNextFramebuffer = NO;
    }
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glActiveTexture(GL_TEXTURE4);
    glBindTexture(GL_TEXTURE_2D, [firstInputFramebuffer texture]);
    glUniform1i(dataInputTextureUniform, 4);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
   
}


#pragma mark -
#pragma mark GPUImageInput protocol

- (void)newFrameReadyAtTime:(CMTime)frameTime atIndex:(NSInteger)textureIndex;
{
    hasReadFromTheCurrentFrame = NO;
    
    if (_newFrameAvailableBlock != NULL)
    {
        _newFrameAvailableBlock();
    }
}

- (NSInteger)nextAvailableTextureIndex;
{
    return 0;
}

- (void)setInputFramebuffer:(GPUImageFramebuffer *)newInputFramebuffer atIndex:(NSInteger)textureIndex;
{
    firstInputFramebuffer = newInputFramebuffer;
    [firstInputFramebuffer lock];
}

- (void)setInputRotation:(GPUImageRotationMode)newInputRotation atIndex:(NSInteger)textureIndex;
{
    inputRotation = newInputRotation;
}

- (void)setInputSize:(CGSize)newSize atIndex:(NSInteger)textureIndex;
{
}

- (CGSize)maximumOutputSize;
{
    return imageSize;
}

- (void)endProcessing;
{
}

- (BOOL)shouldIgnoreUpdatesToThisTarget;
{
    return NO;
}

- (BOOL)wantsMonochromeInput;
{
    return NO;
}

- (void)setCurrentlyReceivingMonochromeInput:(BOOL)newValue;
{
    
}

#pragma mark -
#pragma mark Accessors

- (GLubyte *)rawBytesForImage;
{
    if ( (_rawBytesForImage == NULL) && (![GPUImageContext supportsFastTextureUpload]) )
    {
        _rawBytesForImage = (GLubyte *) calloc(imageSize.width * imageSize.height * 4, sizeof(GLubyte));
        hasReadFromTheCurrentFrame = NO;
    }
    
    if (hasReadFromTheCurrentFrame)
    {
        return _rawBytesForImage;
    }
    else
    {
        runSynchronouslyOnVideoProcessingQueue(^{
            // Note: the fast texture caches speed up 640x480 frame reads from 9.6 ms to 3.1 ms on iPhone 4S
           
            if ([GPUImageContext supportsFastTextureUpload])
            {
                glFinish();
                _rawBytesForImage = [firstInputFramebuffer byteBuffer];
            }
            else
            {
                [GPUImageContext useImageProcessingContext];
                [self renderAtInternalSize];
                glReadPixels(0, 0, imageSize.width, imageSize.height, GL_RGBA, GL_UNSIGNED_BYTE, _rawBytesForImage);
            }
            hasReadFromTheCurrentFrame = YES;
            
        });
        
        return _rawBytesForImage;
    }
}

- (NSUInteger)bytesPerRowInOutput;
{
    return [firstInputFramebuffer bytesPerRow];
}

- (void)setImageSize:(CGSize)newImageSize {
    imageSize = newImageSize;
    if (_rawBytesForImage != NULL && (![GPUImageContext supportsFastTextureUpload]))
    {
        free(_rawBytesForImage);
        _rawBytesForImage = NULL;
    }
    
}

- (void)lockFramebufferForReading;
{
    lockNextFramebuffer = YES;
}

- (void)unlockFramebufferAfterReading;
{
    [firstInputFramebuffer unlock];
    if(outputFramebuffer != nil) {
        [outputFramebuffer unlock];
    }
    if(retainedFramebuffer != nil){
        [retainedFramebuffer unlockAfterReading];
        [retainedFramebuffer unlock];
        retainedFramebuffer = nil;
    }
}




@end
