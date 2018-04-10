/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/


#import <ethers/Provider.h>
#import "Signer.h"

@interface CloudKeychainSigner : Signer

+ (NSArray<Address*>*)addressesForKeychainKey: (NSString*)keychainKey;

+ (instancetype)writeToKeychain: (NSString*)keychainKey
                       nickname: (NSString*)nickname
                           json: (NSString*)json
                       provider: (Provider*)provider;

+ (instancetype)signerWithKeychainKey: (NSString*)keychainKey
                              address: (Address*)address
                             provider: (Provider*)provider;

@property (nonatomic, readonly) NSString *keychainKey;


// Account must be unlocked to remove it
- (BOOL)remove;

@end
