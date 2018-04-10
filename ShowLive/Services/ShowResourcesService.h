//
//  ShowResourcesService.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/5.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowResourcesService : NSObject

+(ShowResourcesService *)shared;

- (NSString *)stringForKey:(NSString *)key ;

- (UIImage *)imageForkey:(NSString *)name;

@end
