//
//  UIImage+KMShortVideoPlayer.m
//  ShowLive
//
//  Created by WorkNew on 16/10/9.
//  Copyright © 2016年 show. All rights reserved.
//

#import "UIImage+KMShortVideoPlayer.h"
@import AVFoundation;

@implementation UIImage (ShowShortVideoPlayer)

+ (UIImage *)SHOW_previewImageWithVideoURL:(NSURL *)videoURL {
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(1, asset.duration.timescale) actualTime:NULL error:nil];
    UIImage *image = [UIImage imageWithCGImage:img];
    
    CGImageRelease(img);
    return image;
}

@end
