//
//  AES128CTR.h
//  imToken
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128CTR : NSObject
//aes-128-ctr
+ (NSData *)encryptedDataForData:(NSData *)data
                        password:(NSString *)password
                              iv:(NSData *)iv
                            salt:(NSData *)salt
                           error:(NSError **)error;


+ (NSData *)randomDataOfLength:(size_t)length;
+ (NSData *)AESKeyForPassword:(NSString *)password
                         salt:(NSData *)salt;
@end
