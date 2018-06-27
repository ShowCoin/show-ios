//
//  NSString+DLPictureChoice.h
//  Dreamer-ios-client
//
//  Created by Ant on 17/2/13.
//  Copyright © 2017年 Beijing Dreamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DLPictureChoice)

/**
 根据需求大小获取图片资源代码

 @param str 图片大小 比如 头像100-100  最新封面324-324  大厅关注封面800-800;

 @return 拼接好的字符串
 */
- (NSString *)stringWithSizeString:(NSString *)str;

@end
