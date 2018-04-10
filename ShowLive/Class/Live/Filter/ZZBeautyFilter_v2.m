//
//  ZZBeautyFilter_v2.m
//  demo
//
//  Created by 郅鹏 宋 on 16/3/4.
//  Copyright © 2016年 songzhipeng. All rights reserved.
//

#import "ZZBeautyFilter_v2.h"


NSString *const kZZBeautyFilterFragmentShaderString = SHADER_STRING
( precision highp float;
 uniform sampler2D inputImageTexture;
 varying highp vec2 textureCoordinate;
 uniform vec2 textureSize;
 void main(){
     
     vec3 centralColor;
     float sampleColor;
     
     
     vec2 blurCoordinates[20];
     
     float mul = 2.0;
     
     float mul_x = mul / textureSize.x;
     float mul_y = mul / textureSize.y;
     
     
     blurCoordinates[0] = textureCoordinate + vec2(0.0 * mul_x,-10.0 * mul_y);
     blurCoordinates[1] = textureCoordinate + vec2(5.0 * mul_x,-8.0 * mul_y);
     blurCoordinates[2] = textureCoordinate + vec2(8.0 * mul_x,-5.0 * mul_y);
     blurCoordinates[3] = textureCoordinate + vec2(10.0 * mul_x,0.0 * mul_y);
     blurCoordinates[4] = textureCoordinate + vec2(8.0 * mul_x,5.0 * mul_y);
     blurCoordinates[5] = textureCoordinate + vec2(5.0 * mul_x,8.0 * mul_y);
     blurCoordinates[6] = textureCoordinate + vec2(0.0 * mul_x,10.0 * mul_y);
     blurCoordinates[7] = textureCoordinate + vec2(-5.0 * mul_x,8.0 * mul_y);
     blurCoordinates[8] = textureCoordinate + vec2(-8.0 * mul_x,5.0 * mul_y);
     blurCoordinates[9] = textureCoordinate + vec2(-10.0 * mul_x,0.0 * mul_y);
     blurCoordinates[10] = textureCoordinate + vec2(-8.0 * mul_x,-5.0 * mul_y);
     blurCoordinates[11] = textureCoordinate + vec2(-5.0 * mul_x,-8.0 * mul_y);
     blurCoordinates[12] = textureCoordinate + vec2(0.0 * mul_x,-6.0 * mul_y);
     blurCoordinates[13] = textureCoordinate + vec2(-4.0 * mul_x,-4.0 * mul_y);
     blurCoordinates[14] = textureCoordinate + vec2(-6.0 * mul_x,0.0 * mul_y);
     blurCoordinates[15] = textureCoordinate + vec2(-4.0 * mul_x,4.0 * mul_y);
     blurCoordinates[16] = textureCoordinate + vec2(0.0 * mul_x,6.0 * mul_y);
     blurCoordinates[17] = textureCoordinate + vec2(4.0 * mul_x,4.0 * mul_y);
     blurCoordinates[18] = textureCoordinate + vec2(6.0 * mul_x,0.0 * mul_y);
     blurCoordinates[19] = textureCoordinate + vec2(4.0 * mul_x,-4.0 * mul_y);
     
     
     sampleColor = texture2D(inputImageTexture, textureCoordinate).g * 22.0;
     
     sampleColor += texture2D(inputImageTexture, blurCoordinates[0]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[1]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[2]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[3]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[4]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[5]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[6]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[7]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[8]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[9]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[10]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[11]).g;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[12]).g * 2.0;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[13]).g * 2.0;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[14]).g * 2.0;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[15]).g * 2.0;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[16]).g * 2.0;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[17]).g * 2.0;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[18]).g * 2.0;
     sampleColor += texture2D(inputImageTexture, blurCoordinates[19]).g * 2.0;
     
     
     
     sampleColor = sampleColor/50.0;
     
     
     centralColor = texture2D(inputImageTexture, textureCoordinate).rgb;
     
     float dis = centralColor.g - sampleColor + 0.5;
     
     
     if(dis <= 0.5)
     {
         dis = dis * dis * 2.0;
     }
     else
     {
         dis = 1.0 - ((1.0 - dis)*(1.0 - dis) * 2.0);
     }
     
     if(dis <= 0.5)
     {
         dis = dis * dis * 2.0;
     }
     else
     {
         dis = 1.0 - ((1.0 - dis)*(1.0 - dis) * 2.0);
     }
     
     if(dis <= 0.5)
     {
         dis = dis * dis * 2.0;
     }
     else
     {
         dis = 1.0 - ((1.0 - dis)*(1.0 - dis) * 2.0);
     }
     
     if(dis <= 0.5)
     {
         dis = dis * dis * 2.0;
     }
     else
     {
         dis = 1.0 - ((1.0 - dis)*(1.0 - dis) * 2.0);
     }
     
     if(dis <= 0.5)
     {
         dis = dis * dis * 2.0;
     }
     else
     {
         dis = 1.0 - ((1.0 - dis)*(1.0 - dis) * 2.0);
     }
     
     
     float aa= 1.03;
     vec3 smoothColor = centralColor*aa - vec3(dis)*(aa-1.0);
     
     float hue = dot(smoothColor, vec3(0.299,0.587,0.114));
     
     aa = 1.0 + pow(hue, 0.8)*0.1;
     smoothColor = centralColor*aa - vec3(dis)*(aa-1.0);
     
     smoothColor.r = clamp(pow(smoothColor.r, 0.9),0.0,1.0);
     smoothColor.g = clamp(pow(smoothColor.g, 0.9),0.0,1.0);
     smoothColor.b = clamp(pow(smoothColor.b, 0.9),0.0,1.0);
     
     
     vec3 lvse = vec3(1.0)-(vec3(1.0)-smoothColor)*(vec3(1.0)-centralColor);
     vec3 bianliang = max(smoothColor, centralColor);
     vec3 rouguang = 2.0*centralColor*smoothColor + centralColor*centralColor - 2.0*centralColor*centralColor*smoothColor;
     
     
     gl_FragColor = vec4(mix(centralColor, lvse, pow(hue, 0.0)), 1.0);
     gl_FragColor.rgb = mix(gl_FragColor.rgb, bianliang, pow(hue, 0.35));
     gl_FragColor.rgb = mix(gl_FragColor.rgb, rouguang, 0.31);
     
     
     
     mat3 saturateMatrix = mat3(
                                1.1102,
                                -0.0598,
                                -0.061,
                                -0.0774,
                                1.0826,
                                -0.1186,
                                -0.0228,
                                -0.0228,
                                1.1772);
     
     vec3 satcolor = gl_FragColor.rgb * saturateMatrix;
     gl_FragColor.rgb = mix(gl_FragColor.rgb, satcolor, 0.2);
 
 }
 );
 
@implementation ZZBeautyFilter_v2 {
}

- (id)init
{
    hasOverriddenImageSizeFactor = false;
    if(! (self = [super initWithFragmentShaderFromString:kZZBeautyFilterFragmentShaderString]) )
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

@end
