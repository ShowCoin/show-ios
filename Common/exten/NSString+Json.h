//
//  NSString+Json.h
//  Titop
//
//  Created by WenQiangXu on 15/7/24.
//  Copyright (c) 北京认真创造科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Json)

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;
@end
