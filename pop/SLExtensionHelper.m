
//  Created by SHOW gx on 4/25/16.
//  Copyright © 2016 show. All rights reserved.
//

#import "SLMExtensionHelper.h"
#import <objc/runtime.h>


@implementation NSString (SLMKitExtension)

static char SLMKitStringJsonDictionaryAddress;

- (NSDictionary *)slkit_jsonDict
{
    NSDictionary *dict = [objc_getAssociatedObject(self, &SLKitStringJsonDictionaryAddress) copy];
    if (dict == nil)    //解析过一次后就缓存解析结果，避免多次解析
    {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        dict = [NSJSONSerialization JSONObjectWithData:data
                                               options:0
                                                 error:nil];
        if (![dict isKindOfClass:[NSDictionary class]])
        {
            dict = [NSDictionary dictionary];
        }
        objc_setAssociatedObject(self,&SLKitStringJsonDictionaryAddress,dict,OBJC_ASSOCIATION_COPY);
    }
    return dict;
    
}


@end


@implementation NSDictionary (SLKitExtension)
- (NSString *)slkit_jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:nil];
    return data ? [[NSString alloc] initWithData:data
                                        encoding:NSUTF8StringEncoding] : nil;
}
@end
