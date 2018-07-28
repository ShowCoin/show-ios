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
- (NSString*) urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\|~ "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString*) urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}
- (NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *nationalDate2 = [formatter dateFromString:self];
    
    return nationalDate2;
}
- (NSDate *)datetime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *nationalDate2 = [formatter dateFromString:self];
    
    return nationalDate2;
}

+ (NSString *)fileSize:(long long)size {
    
    NSInteger KB = 1024;
    NSInteger MB = KB * KB;
    NSInteger GB = MB * KB;
    if (size < 10)
        return @"0.0 KB";
    else if (size < KB)
        return @"小于1KB";
    else if (size < MB)
        return [NSString stringWithFormat:@"%.1f KB", ((CGFloat)size)/KB];
    else if (size < GB)
        return [NSString stringWithFormat:@"%.1f MB", ((CGFloat)size)/MB];
    else
        return [NSString stringWithFormat:@"%.1f GB", ((CGFloat)size)/GB];
}

- (BOOL)isValidatePhoneNumber {
    
    NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [phoneTest evaluateWithObject:self];
}
- (BOOL)isValidateEmail {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
- (BOOL)isChinese {
    
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
- (CGFloat)heightOfTextWithWidth:(float)width theFont:(UIFont*)aFont {
    
    return [self heightOfTextWithWidth:width height:MAXFLOAT theFont:aFont];
}
- (CGFloat)heightOfTextWithWidth:(float)width height:(float)height theFont:(UIFont*)aFont {
    
    CGFloat result;
    CGSize textSize = { width, height };
    
    CGSize size = [self sizeWithFont:aFont constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
    result = size.height + size.height * 0.15f;
    return result;
}
- (CGFloat)heightOfTextViewWithWidth:(float)width theFont:(UIFont*)aFont {
    
    return [self heightOfTextViewWithWidth:width height:MAXFLOAT theFont:aFont];
}


- (CGFloat)heightOfTextViewWithWidth:(float)width height:(float)height theFont:(UIFont*)aFont {
    
    CGFloat result;
    
    if (self.length == 0)
        return 0.0f;
    
    CGSize textSize = CGSizeMake(width - 16.0f, height - 16.0f);
    CGSize size = [self sizeWithFont:aFont constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
    result = size.height + size.height * 0.15f + 16.0f;
    return result;
}
- (CGFloat)textViewHeightWithFont:(UIFont *)font width:(CGFloat)width {
    
    NSDictionary *attributes = @{ NSFontAttributeName:font };
    NSAttributedString * attributedString = [[NSAttributedString alloc]initWithString:self attributes:attributes];
    
    return [self textViewHeightWithAttributedString:attributedString width:width limitedHeight:MAXFLOAT];
}
- (CGFloat)textViewHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width {
    
    return [self textViewHeightWithAttributedString:attributedString width:width limitedHeight:MAXFLOAT];
}

- (CGFloat)textViewHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width limitedHeight:(CGFloat)height {
    
    CGFloat result;
    
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:attributedString];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    //    size.height -= 16.0f;
    if (size.height > height)
        result = height;
    else
        result = size.height;
    
    return result;
}
- (UIColor *)color {
    
    NSArray *rgbArray = [self componentsSeparatedByString:@","];
    int r = [[rgbArray objectAtIndex:0] intValue];
    int g = [[rgbArray objectAtIndex:1] intValue];
    int b = [[rgbArray objectAtIndex:2] intValue];
    return RGBACOLOR(r, g, b, 1.0f);
    
}
- (BOOL)containsString:(NSString *)aString
{
    NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]];
    return range.location != NSNotFound;
}

- (NSString*)telephoneWithReformat
{
    NSString *telphoneString = self;
    
    if ([telphoneString containsString:@"-"])
    {
        telphoneString = [telphoneString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    if ([telphoneString containsString:@"("])
    {
        telphoneString = [telphoneString stringByReplacingOccurrencesOfString:@"(" withString:@""];
    }
    
    if ([telphoneString containsString:@")"])
    {
        telphoneString = [telphoneString stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    
    if ([telphoneString containsString:@" "])
    {
        telphoneString = [telphoneString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if ([telphoneString containsString:@" "])
    {
        telphoneString = [telphoneString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return telphoneString;
}
+ (NSString *)spaceWithCount:(NSInteger)count {
    
    NSMutableString *space = [[NSMutableString alloc] init];
    for (int i = 0;i<count;i++) {
        
        [space appendString:@" "];
    }
    
    return space;
}

//分转元
- (NSString *)pointToDollar {
    
    float pointTemp = [self floatValue];
    float dollar = pointTemp / 100.00;
    NSString *dollarStr = [NSString stringWithFormat:@"%0.2f", dollar];
    return dollarStr;
}
//元转分
- (NSString *)dollarToPoint {
    
    float dollarTemp = [self floatValue];
    float pointTemp = dollarTemp * 100;
    NSString *pointStr = [NSString stringWithFormat:@"%0.0f", pointTemp];
    return pointStr;
}

//数字转换成万
-(NSString *)numberToMyriad{
    
    long number = 0;
    
    if (![self isEqualToString:@"(null)"]) {
        number = [self integerValue];
    }
    long myriad ;
    NSString *myriadStr = [NSString stringWithFormat:@"%ld", number];
    if (number>=100000) {
        myriad= number/10000;
        myriadStr = [NSString stringWithFormat:@"%ld万", myriad];
    }
    return myriadStr;
}
- (NSString *)typesetting {
    
    NSString *typesettingString;
    
    NSArray *array = [NSArray arrayWithArray:[self componentsSeparatedByString:@"\n"]];
    NSMutableString *allStr = [[NSMutableString alloc] initWithString:@"       "];
    for (int i = 0; i < array.count; i++) {
        
        NSString *str = [[array objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [allStr appendFormat:@"%@\n       ", str];
    }
    
    if (allStr.length > 7)
        typesettingString = [allStr substringToIndex:allStr.length - 7];//去掉最后的\n
    else
        typesettingString = allStr;
    
    return typesettingString;
}

-(NSMutableString*)urlWithStringFormatAddString:(NSString*)addString //给字符串 添加 语音秒数
{
    NSMutableString *string=[NSMutableString stringWithFormat:@"%@",self];
    [string insertString:addString atIndex:string.length-4];
    
    return string;
}




@end
