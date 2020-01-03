//
//  NSDictionary+SLKeyValue.h
//  show gx
//
//  Created by show gx on 17/3/27.
//  Copyright © 2017年 Show. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SLKeyValue)

- (NSString *)sl_safeStringForKey:(id)key;

- (NSString *)sl_safeStringForValue:(id)value;
@end
