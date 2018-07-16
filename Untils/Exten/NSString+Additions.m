#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MKNetworkKitAdditions)

- (NSString *)trim {
    
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return string;
}
- (NSString *)trimString:(NSString *)string {
    
    return [self stringByReplacingOccurrencesOfString:string withString:@""];
}
+ (BOOL)isValidString:(NSString *)value
{
    return (value &&
            (![@"" isEqualToString:value]) &&
            (value.length > 0) &&
            (![value isKindOfClass:[NSNull class]]) &&
            (![@"(null)" isEqualToString:value])) &&
    (([value isKindOfClass:[NSString class]] && [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]));
}

@end
