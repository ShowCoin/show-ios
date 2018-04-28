//
//  UIImageView+XFExtension.h
//
//  Created by  JokeSmileZhang on 16/7/5.
//  Copyright © 2016年 JokeSmileZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XFExtension)

- (void)xf_setCircleHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;

- (void)xf_setRectHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;

- (void)xf_setSixSideHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;
//设置图片剧中显示
-(UIImageView*)setImageClipsToBounds;
@end
