//
//  GPU_rgb2yuv.m
//  funlive
//
//  Created by Wang Tao on 16/6/28.
//  Copyright © 2016年 renzhen. All rights reserved.
//

#import "GPU_rgb2yuv.h"

NSString *const RGB2YUVFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 uniform vec2 textureSize;
 
 void main() {
    
     vec3 offset = vec3(0.0625, 0.5, 0.5);
     vec3 ycoeff = vec3(0.256816, 0.504154, 0.0979137);
     vec3 ucoeff = vec3(-0.148246, -0.29102, 0.439266);
     vec3 vcoeff = vec3(0.439271, -0.367833, -0.071438);
     
     vec2 nowTxtPos = textureCoordinate;
     
     float width  = textureSize.x;
     float height = textureSize.y;
     float uvlines = 0.0625*height;
     float uvlinesI = float(int(uvlines));
     vec2 uvPosOffset = vec2(uvlines-uvlinesI,uvlinesI/height);
     vec2 uMaxPos = uvPosOffset+vec2(0,0.25);
     vec2 vMaxPos = uvPosOffset+uMaxPos;
     
     vec2 yScale = vec2(4,4);
     vec2 uvScale = vec2(8,8);
     
     if(nowTxtPos.y<0.25){

         vec2 basePos = nowTxtPos * yScale * textureSize;
         float addY = float(int((basePos.x / width)));
         basePos.x -= addY * width;
         basePos.y += addY;

         float y1;
         float y2;
         float y3;
         float y4;
         
         vec2 samplingPos = basePos / textureSize;
         vec4 texel = texture2D(inputImageTexture, samplingPos);
         y1 = dot(texel.rgb, ycoeff);
         y1 += offset.x;
         
         basePos.x+=1.0;
         samplingPos = basePos/textureSize;
         texel = texture2D(inputImageTexture, samplingPos);
         y2 = dot(texel.rgb, ycoeff);
         y2 += offset.x;
         
         
         basePos.x+=1.0;
         samplingPos = basePos/textureSize;
         texel = texture2D(inputImageTexture, samplingPos);
         y3 = dot(texel.rgb, ycoeff);
         y3 += offset.x;
         
         basePos.x+=1.0;
         samplingPos = basePos/textureSize;
         texel = texture2D(inputImageTexture, samplingPos);
         y4 = dot(texel.rgb, ycoeff);
         y4 += offset.x;
         
         gl_FragColor = vec4(y1, y2, y3, y4);
     }

     else if(nowTxtPos.y<uMaxPos.y || (nowTxtPos.y == uMaxPos.y && nowTxtPos.x<uMaxPos.x)){
         nowTxtPos.y -= 0.25;
         vec2 basePos = nowTxtPos * uvScale * textureSize;
         float addY = float(int(basePos.x / width));
         basePos.x -= addY * width;
         basePos.y += addY;
         basePos.y *= 2.0;
         basePos -= clamp(uvScale * 0.5 - 2.0, vec2(0.0), uvScale);
         basePos.y -= 2.0;
         
         // 1
         vec4 sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         float u1 = dot(sample.rgb, ucoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u1 += dot(sample.rgb, ucoeff);
         
         basePos.x -= 1.0;
         basePos.y += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u1 += dot(sample.rgb, ucoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u1 += dot(sample.rgb, ucoeff);
         
         u1 /= 4.0;
         u1 += offset.y;
         
         // 2
         basePos.y -= 1.0;
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         float u2 = dot(sample.rgb, ucoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u2 += dot(sample.rgb, ucoeff);
         
         basePos.x -= 1.0;
         basePos.y += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u2 += dot(sample.rgb, ucoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u2 += dot(sample.rgb, ucoeff);
         
         u2 /= 4.0;
         u2 += offset.y;
         
         // 3
         basePos.y -= 1.0;
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         float u3 = dot(sample.rgb, ucoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u3 += dot(sample.rgb, ucoeff);
         
         basePos.x -= 1.0;
         basePos.y += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u3 += dot(sample.rgb, ucoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u3 += dot(sample.rgb, ucoeff);
         
         u3 /= 4.0;
         u3 += offset.y;
         
         // 4
         basePos.y -= 1.0;
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         float u4 = dot(sample.rgb, ucoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u4 += dot(sample.rgb, ucoeff);
         
         basePos.x -= 1.0;
         basePos.y += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u4 += dot(sample.rgb, ucoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u4 += dot(sample.rgb, ucoeff);
         
         u4 /= 4.0;
         u4 += offset.y;
         
         gl_FragColor = vec4(u1, u2, u3, u4);
     }

     else if(nowTxtPos.y<vMaxPos.y || (nowTxtPos.y == vMaxPos.y && nowTxtPos.x<vMaxPos.x)){
         
         nowTxtPos -= uMaxPos;
         vec2 basePos = nowTxtPos * uvScale * textureSize;
         float addY = float(int(basePos.x / width));
         basePos.x -= addY * width;
         basePos.y += addY;
         basePos.y *= 2.0;
         basePos -= clamp(uvScale * 0.5 - 2.0, vec2(0.0), uvScale);
         basePos.y -= 2.0;
         
         // 1
         vec4 sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         float u1 = dot(sample.rgb, vcoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u1 += dot(sample.rgb, vcoeff);
         
         basePos.x -= 1.0;
         basePos.y += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u1 += dot(sample.rgb, vcoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u1 += dot(sample.rgb, vcoeff);
         
         u1 /= 4.0;
         u1 += offset.z;
         
         // 2
         basePos.y -= 1.0;
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         float u2 = dot(sample.rgb, vcoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u2 += dot(sample.rgb, vcoeff);
         
         basePos.x -= 1.0;
         basePos.y += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u2 += dot(sample.rgb, vcoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos/ textureSize).rgba;
         u2 += dot(sample.rgb, vcoeff);
         
         u2 /= 4.0;
         u2 += offset.z;
         
         // 3
         basePos.y -= 1.0;
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         float u3 = dot(sample.rgb, vcoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u3 += dot(sample.rgb, vcoeff);
         
         basePos.x -= 1.0;
         basePos.y += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u3 += dot(sample.rgb, vcoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u3 += dot(sample.rgb, vcoeff);
         
         u3 /= 4.0;
         u3 += offset.z;
         
         // 4
         basePos.y -= 1.0;
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         float u4 = dot(sample.rgb, vcoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u4 += dot(sample.rgb, vcoeff);
         
         basePos.x -= 1.0;
         basePos.y += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u4 += dot(sample.rgb, vcoeff);
         
         basePos.x += 1.0;
         sample = texture2D(inputImageTexture, basePos / textureSize).rgba;
         u4 += dot(sample.rgb, vcoeff);
         
         u4 /= 4.0;
         u4 += offset.z;
         
         gl_FragColor = vec4(u1, u2, u3, u4);
     }
 }
 );

@implementation GPURGB2YUV {
}

- (id)init
{
    hasOverriddenImageSizeFactor = false;
    if(! (self = [super initWithFragmentShaderFromString:RGB2YUVFragmentShaderString]) )
    {
        return nil;
    }
    
    return self;
}

- (void)setupFilterForSize:(CGSize)filterFrameSize;
{
    if (!hasOverriddenImageSizeFactor)
    {
        hasOverriddenImageSizeFactor = true;
        [super setupFilterForSize:filterFrameSize];
        [self setSize:filterFrameSize forUniformName:@"textureSize"];
    }
}

- (void)renderToTextureWithVertices:(const GLfloat *)vertices textureCoordinates:(const GLfloat *)textureCoordinates;
{
    [super renderToTextureWithVertices:vertices textureCoordinates:textureCoordinates];
}


@end
