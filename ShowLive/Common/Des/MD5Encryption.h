//
//  MyUtility.h
//  ThuInfo
//
//  Created by BigHao on 17-10-30.
//  Copyright (c) 2012年 BigHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Encryption : NSObject
+ (NSString *)md5by32:(NSString*)input;
- (NSString *)md5:(NSString *)str;
@end
