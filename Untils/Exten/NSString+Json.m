//
//  NSString+Json.m
//  Titop
//
//  Created by WenQiangXu on 15/7/24.
//  Copyright (c) 北京认真创造科技有限公司. All rights reserved.
//

#import "NSString+Json.h"

@implementation NSString (Json)

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    if(![JSONString isKindOfClass:[NSString class]]
       || JSONString.length == 0){
        return nil;
    }
    
    if([JSONString isKindOfClass:[NSDictionary class]]){
        return (NSDictionary*)JSONString;
    }
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

@end
