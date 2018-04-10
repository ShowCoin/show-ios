//
//  ACMediaModel.h
//
//  Created by caoyq on 16/12/25.
//  Copyright © 2016年 ArthurCao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface ACMediaModel : NSObject
/** id */
@property (nonatomic, copy) NSString *id;
/** 网络返回链接 */
@property (nonatomic, copy) NSString *img;
/** 媒体名字 */
@property (nonatomic, copy) NSString *name;

/** 媒体上传格式 图片是NSData，视频主要是路径名，也有NSData */
@property (nonatomic, strong) id uploadType;

//兼容 MWPhotoBrowser 的附加属性

/** 媒体照片 */
@property (nonatomic, strong) UIImage *image;

/** url string image */
@property (nonatomic, copy) NSString *imageUrlString;

/** iOS8 之后的媒体属性 */
@property (nonatomic, strong) PHAsset *asset;

/** 是否属于可播放的视频类型 */
@property (nonatomic, assign) BOOL isVideo;
/** 是否属于可播放的视频类型 */
@property (nonatomic, assign) BOOL isSelect;
/** 视频的URL */
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) NSString *file;
@property (nonatomic, strong) NSString *thumbnail;

@end
