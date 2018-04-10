//
//  NSArray+Addition.h

//
//  Copyright © 2016年 will23. All rights reserved.
//

#import "NSArray+Addition.h"
#import "NSObject+Addition.h"

@implementation NSArray (Addition)

+ (NSArray*)objectListWithPlistName:(NSString*)plistName clsName:(NSString*)clsName
{
    NSURL* url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    NSArray* list = [NSArray arrayWithContentsOfURL:url];

    NSMutableArray* arrayM = [NSMutableArray arrayWithCapacity:list.count];

    Class cls = NSClassFromString(clsName);
    // 断言
    NSAssert(cls, @"加载 plist 文件时指定的 clsName - %@ 错误", clsName);

    for (NSDictionary* dict in list) {
        [arrayM addObject:[cls objectWithDict:dict]];
    }

    return arrayM.copy;
}

@end
