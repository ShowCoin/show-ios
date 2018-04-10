//
//  UIImage+KMShortVideoPlayer.h
//  ShowLive
//
//  Created by GongXin on 16/10/9.
//  Copyright © 2016年 show. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AVAsset;

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KMShortVideoPlayer)

+ (UIImage *)KM_previewImageWithVideoURL:(NSURL *)videoURL;

@end

NS_ASSUME_NONNULL_END

