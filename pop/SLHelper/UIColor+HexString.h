//
//  UIColor+HexString.h
//
//  Created by Micah Hainline
//  http://stackoverflow.com/users/590840/micah-hainline
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString;
- (NSString *)hexString;


+ (UIColor *)colorWithHexStringdata:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexStringdata:(NSString *)color alpha:(CGFloat)alpha;

- (UIImage *)colorImage ;

+ (UIColor *)sl_arc4randomColor;

@end
