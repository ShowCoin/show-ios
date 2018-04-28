//
//  Base64Util.h
//  ThuInfo
//
//  Created by BigHao on 17-10-30.
//  Copyright (c) 2012年 BigHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"

@interface Base64Util : NSObject

+ (NSString*)encodeBase64:(NSString*)input;
+ (NSString*)decodeBase64:(NSString*)input;

@end
