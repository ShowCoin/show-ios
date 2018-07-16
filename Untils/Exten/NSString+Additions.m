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

- (BOOL)isNilOrEmpty {
    
    if (!self)
        return YES;
    else if (self.length == 0)
        return YES;
    else
        return NO;
}
- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
+ (NSString*) uniqueString
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);
    NSString    *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

@end
