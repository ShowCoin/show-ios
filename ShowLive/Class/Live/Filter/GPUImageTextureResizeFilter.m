#import "GPUImageTextureResizeFilter.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kGPUImageResizeFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 
 void main()
 {
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    gl_FragColor = textureColor;
 }
);                                                                    
#else
NSString *const kGPUImageResizeFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 
 void main()
 {
     vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     gl_FragColor = textureColor;
 }
 );
#endif

@implementation GPUImageTextureResizeFilter

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageResizeFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end

