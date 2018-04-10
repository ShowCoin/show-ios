/**
 *  MIT License
 *
 *  Copyright (c) 2018 Richard Moore <me@ricmoo.com>
 *
**/


#import "CloudKeychainSigner.h"

@interface FireflySigner : CloudKeychainSigner

+ (instancetype)writeToKeychain: (NSString*)keychainKey
                       nickname: (NSString*)nickname
                        address: (Address*)address
                      secretKey: (NSData*)secretKey
                       provider: (Provider*)provider;

/**
 *  The version of the Firefly Hardware Firmware
 *
 *  Firmware Version 0
 *    - No password
 *    - Private Key is burned in at compile time (no pairing)
 *    - Only supports v0 transactions
 *  Version 1 (tentative) - Password encrypted private key on Firefly; provided by Ethers Wallet at pair-time via ECDH
 *  Version 2 (tentative) - Password encrypted private key on Firefly; generated on Firefly (multisig-mode only)
 *
 *  Transaction Version: v0
 *    - Maximum length of 758 bytes
 *    - Maximum nonce is 0xffffffff (4 bytes)
 *    - Maximum gasLimit is 0xffffffff (4 bytes)
 *    - Maximum Gas Price is 0xffffffffff (5 bytes)
 *    - ChainId must be 0 or has an EIP155 v that fits into 1 byte
 */

@property (nonatomic, readonly) uint8_t version;

@end
