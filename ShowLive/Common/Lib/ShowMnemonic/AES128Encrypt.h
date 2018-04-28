//
//  AES123Encrypt.h
//  imToken
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128Encrypt : NSObject
@property (nonatomic, copy) NSString *cipherFinalDecrypt;
+ (NSMutableData*) encryptString: (NSString*)stringToEncrypt withKey: (NSString*) keyString iv:(NSData *)iv;
+ (NSString*) decryptData: (NSData*) data withKey: (NSString*) keyString iv:(NSData *)iv;
@end
