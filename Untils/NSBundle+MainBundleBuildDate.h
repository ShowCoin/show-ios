//
//  NSBundle+MainBundleBuildDate.h
//  Dreamer
//
//  Created by Ant on 16/10/21.
//  Copyright © 2016年 Beijing Dreamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (MainBundleBuildDate)

/*
 * Retrieves the build date from the main bundle after diverting to the BuildDate.plist.
 */
+ (NSString *)mainBundleBuildDate;

@end
