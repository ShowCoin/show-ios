//
//  UIImage+ShowShortVideoPlayer.h
//  ShowLive
//
//  Created by WorkNew on 16/10/9.
//  Copyright © 2016年 show. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AVAsset;

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ShowShortVideoPlayer)

+ (UIImage *)SL_previewImageWithVideoURL:(NSURL *)videoURL;

@end

NS_ASSUME_NONNULL_END

