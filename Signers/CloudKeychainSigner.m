/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/


#import "CloudKeychainSigner.h"

@import LocalAuthentication;

#import <ethers/Account.h>
#import <ethers/SecureData.h>

#import "CachedDataStore.h"


static NSString *KeychainKeyEncryptedKey                   = @"ENCRYPTED_KEY";

static NSString *DataStoreKeySecureEnclavePublicKey        = @"SECURE_ENCLAVE_PUBLIC_KEY";


static Address *checkJson(NSString *json) {
    NSError *error = nil;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                             options:0
                                                               error:&error];
    if (error) {
        NSLog(@"ERROR: Invalid JSON Wallet - %@", error);
        return nil;
    }
    
    if (![jsonData isKindOfClass:[NSDictionary class]]) { return nil; }
    
    // @TODO: Add more checks in here?
    return [Address addressWithString:[jsonData objectForKey:@"address"]];
}


static NSString *getNickname(NSString *label) {
    
    static NSRegularExpression *regexLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        regexLabel = [NSRegularExpression regularExpressionWithPattern:@"[^(]*\\((.*)\\)" options:0 error:&error];
        if (error) {
            NSLog(@"CloudKeychainSigner: Error creating regular expression - %@", error);
        }
    });
    
    NSTextCheckingResult *result = [regexLabel firstMatchInString:label options:0 range:NSMakeRange(0, label.length)];
    
    if ([result numberOfRanges] && [result rangeAtIndex:1].location != NSNotFound) {
        return [label substringWithRange:[result rangeAtIndex:1]];
    }
    
    return @"ethers.io";
}


#pragma mark - Keychain helpers


static NSString *getServiceName(NSString *keychainKey) {
    if ([keychainKey isEqualToString:@"io.ethers.sharedWallet"]) {
        return @"ethers.io";
    } else if ([keychainKey isEqualToString:@"io.ethers.sharedWallet/ropsten"]) {
        return @"ethers.io/ropsten";
    } else if ([keychainKey isEqualToString:@"io.ethers.sharedWallet/kovan"]) {
        return @"ethers.io/kovan";
    } else if ([keychainKey isEqualToString:@"io.ethers.sharedWallet/rinkeby"]) {
        return @"ethers.io/rinkeby";
    } else if ([keychainKey isEqualToString:@"io.ethers.sharedWallet/firefly/homestead"]) {
        return @"ethers.io/firefly/homestead";
    } else if ([keychainKey isEqualToString:@"io.ethers.sharedWallet/firefly/ropsten"]) {
        return @"ethers.io/firefly/ropsten";
    } else if ([keychainKey isEqualToString:@"io.ethers.sharedWallet/firefly/kovan"]) {
        return @"ethers.io/firefly/kovan";
    } else if ([keychainKey isEqualToString:@"io.ethers.sharedWallet/firefly/rinkeby"]) {
        return @"ethers.io/firefly/rinkeby";
    }

    // @TODO: return keychainKey
    return nil;
}

static NSString* getKeychainValue(NSString *keychainKey, Address *address) {
    NSString *serviceName = getServiceName(keychainKey);
    if (!serviceName) { return nil; }
    
    NSDictionary *query = @{
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrGeneric: [keychainKey dataUsingEncoding:NSUTF8StringEncoding],
                            (id)kSecReturnData: (id)kCFBooleanTrue,
                            (id)kSecAttrSynchronizable: (id)kCFBooleanTrue,
                            
                            (id)kSecAttrAccount: address.checksumAddress,
                            (id)kSecAttrService: serviceName,
                            };
    
    NSString *value = nil;
    
    {
        CFDataRef data = nil;
        
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef*)&data);
        if (status == noErr) {
            value = [[NSString alloc] initWithBytes:[(__bridge NSData*)data bytes]
                                             length:[(__bridge NSData*)data length]
                                           encoding:NSUTF8StringEncoding];
        }
        
        if (data) { CFRelease(data); }
    }
    
    
    return value;
}

static BOOL addKeychainVaue(NSString *keychainKey, Address *address, NSString *nickname, NSString *value, BOOL updateOnly) {
    NSString *serviceName = getServiceName(keychainKey);
    if (!serviceName) { return NO; }

    NSDictionary *query = @{
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrGeneric: [keychainKey dataUsingEncoding:NSUTF8StringEncoding],
                            (id)kSecReturnAttributes: (id)kCFBooleanTrue,
                            (id)kSecAttrSynchronizable: (id)kCFBooleanTrue,
                            
                            (id)kSecAttrAccount: address.checksumAddress,
                            (id)kSecAttrService: serviceName,
                            };
    
    CFDictionaryRef existingEntry = nil;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef*)&existingEntry);
    if (status == noErr) {
        NSMutableDictionary *updateQuery = [(__bridge NSDictionary *)existingEntry mutableCopy];
        [updateQuery setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
        
        NSDictionary *updateEntry = @{
                                      (id)kSecAttrSynchronizable: (id)kCFBooleanTrue,
                                      
                                      (id)kSecAttrAccount: address.checksumAddress,
                                      (id)kSecAttrService: serviceName,
                                      (id)kSecValueData: [value dataUsingEncoding:NSUTF8StringEncoding],
                                      
                                      (id)kSecAttrLabel: [NSString stringWithFormat:@"Ethers Account (%@)", nickname],
                                      (id)kSecAttrDescription: @"Encrypted JSON Wallet",
                                      (id)kSecAttrComment: @"This is managed by Ethers and contains an encrypted copy of your JSON wallet.",
                                      };
        
        status = SecItemUpdate((__bridge CFDictionaryRef)updateQuery, (__bridge CFDictionaryRef)updateEntry);
        if (status != noErr) {
            NSLog(@"ERROR: Failed to update %@ - %d", address, (int)status);
        }
        
    } else if (!updateOnly) {
        NSDictionary *addEntry = @{
                                   (id)kSecClass: (id)kSecClassGenericPassword,
                                   (id)kSecAttrGeneric: [keychainKey dataUsingEncoding:NSUTF8StringEncoding],
                                   (id)kSecAttrSynchronizable: (id)kCFBooleanTrue,
                                   
                                   (id)kSecAttrAccount: address.checksumAddress,
                                   (id)kSecAttrService: serviceName,
                                   (id)kSecValueData: [value dataUsingEncoding:NSUTF8StringEncoding],
                                   (id)kSecAttrLabel: [NSString stringWithFormat:@"Ethers Account (%@)", nickname],
                                   (id)kSecAttrDescription: @"Encrypted JSON Wallet",
                                   (id)kSecAttrComment: @"This is managed by Ethers and contains an encrypted copy of your JSON wallet.",
                                   };
        
        status = SecItemAdd((__bridge CFDictionaryRef)addEntry, NULL);
        if (status != noErr) {
            NSLog(@"Keychain: Error adding %@ - %d", address, (int)status);
        }
        
    } else {
        status = !noErr;
    }
    
    if (existingEntry) { CFRelease(existingEntry); }
    
    return (status == noErr);
}

BOOL removeKeychainValue(NSString *keychainKey, Address *address) {
    NSString *serviceName = getServiceName(keychainKey);
    if (!serviceName) { return NO; }

    NSDictionary *query = @{
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrGeneric: [keychainKey dataUsingEncoding:NSUTF8StringEncoding],
                            (id)kSecReturnAttributes: (id)kCFBooleanTrue,
                            (id)kSecAttrSynchronizable: (id)kCFBooleanTrue,
                            
                            (id)kSecAttrAccount: address.checksumAddress,
                            (id)kSecAttrService: serviceName,
                            };
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != noErr) {
        NSLog(@"Error deleting");
    }
    
    return (status == noErr);
}


#pragma mark - CloudKeychainSigner

static NSString *DataStoreKeyAccounts                 = @"ACCOUNTS";

@implementation CloudKeychainSigner {
    Account *_account;
    Cancellable *_unlocking;
    NSString *_serviceName;
}


#pragma mark - Life-Cycle

+ (NSArray<Address*>*)addressesForKeychainKey: (NSString*)keychainKey {
    NSString *serviceName = getServiceName(keychainKey);
    if (!serviceName) { return @[]; }
    
    NSString *cacheKey = [@"cloudkeychainsigner-" stringByAppendingString:keychainKey];
    CachedDataStore *dataStore = [CachedDataStore sharedCachedDataStoreWithKey:cacheKey];;
    
    NSMutableArray<Address*> *addresses = [NSMutableArray array];
    
    // If the devices is unlocked, we can load all the JSON wallets
    NSDictionary *query = @{
                            (id)kSecMatchLimit: (id)kSecMatchLimitAll,
                            (id)kSecAttrSynchronizable: (id)kCFBooleanTrue,
                            
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrGeneric: [keychainKey dataUsingEncoding:NSUTF8StringEncoding],
                            (id)kSecAttrService: serviceName,
                            (id)kSecReturnAttributes: (id)kCFBooleanTrue
                            };
    
    CFMutableArrayRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef*)&result);
    
    if (status == noErr) {
        NSMutableArray *addressStrings = [NSMutableArray array];
        
        for (NSDictionary *entry in ((__bridge NSArray*)result)) {
            NSString *addressString = [entry objectForKey:(id)kSecAttrAccount];
            [addressStrings addObject:addressString];
            [addresses addObject:[Address addressWithString:addressString]];
        }

        // Save the list of addresses to the data store (so we can load it without keychain access if needed)
        [dataStore setArray:addressStrings forKey:DataStoreKeyAccounts];
        
    } else if (status == errSecItemNotFound) {
        // No problem... No exisitng entries

        [dataStore setArray:nil forKey:DataStoreKeyAccounts];
        
    } else {
        // Error... Possibly the device is locked?
        NSLog(@"Keychain: Error - status=%d (maybe the device is locked?)", (int)status);

        // Device locked; load the addresses from the data store
        for (NSString *addressString in [dataStore arrayForKey:DataStoreKeyAccounts]) {
            [addresses addObject:[Address addressWithString:addressString]];
        }
    }
    
    if (result) { CFRelease(result); }
    
    return addresses;
}


+ (instancetype)writeToKeychain:(NSString *)keychainKey
                       nickname:(NSString *)nickname
                           json:(NSString *)json
                       provider:(Provider *)provider {
    
    
    Address *address = checkJson(json);
    if (!address) { return nil; }
    
    addKeychainVaue(keychainKey, address, nickname, json, NO);
    
    CloudKeychainSigner *signer = [self signerWithKeychainKey:keychainKey address:address provider:provider];
    [signer _setNickname:nickname];
    return signer;
}

+ (instancetype)signerWithKeychainKey: (NSString*)keychainKey address: (Address*)address provider: (Provider*)provider {
    return [[self alloc] initWithKeychainKey:keychainKey address:address provider:provider];
}

- (instancetype)initWithKeychainKey: (NSString*)keychainKey address: (Address*)address provider: (Provider*)provider {
    self = [super initWithCacheKey:keychainKey address:address provider:provider];
    if (self) {
        _keychainKey = keychainKey;
        
        _serviceName = getServiceName(_keychainKey);
        if (!_serviceName) { return nil; }
        
        __weak CloudKeychainSigner *weakSelf = self;
        [NSTimer scheduledTimerWithTimeInterval:4.0f repeats:YES block:^(NSTimer *timer) {
            if (!weakSelf) {
                [timer invalidate];
                return;
            }
            
            // No longer alive, stop polling
            BOOL maybeAlive = [weakSelf checkNickname];
            if (!maybeAlive) { [timer invalidate]; }
        }];
    }
    return self;
}

- (BOOL)checkNickname {
    BOOL maybeAlive = YES;
    
    NSDictionary *query = @{
                            //(id)kSecMatchLimit: (id)kSecMatchLimitAll,
                            
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrGeneric: [self.keychainKey dataUsingEncoding:NSUTF8StringEncoding],
                            (id)kSecReturnAttributes: (id)kCFBooleanTrue,
                            (id)kSecAttrSynchronizable: (id)kCFBooleanTrue,
                            
                            (id)kSecAttrAccount: self.address.checksumAddress,
                            (id)kSecAttrService: _serviceName,
                            };
    
    NSString *label = nil;
    
    CFDictionaryRef entry = nil;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef*)&entry);
    if (status == noErr) {
        label = [(__bridge NSDictionary*)entry objectForKey:(id)kSecAttrLabel];
        
    } else if (status == errSecItemNotFound) {
        maybeAlive = NO;
        
        __weak CloudKeychainSigner *weakSelf = self;
        //NSDictionary *userInfo = @{ SignerNotificationSignerKey: self };
        NSDictionary *userInfo = @{};
        dispatch_async(dispatch_get_main_queue(), ^() {
            [[NSNotificationCenter defaultCenter] postNotificationName:SignerRemovedNotification
                                                                object:weakSelf
                                                              userInfo:userInfo];
        });
    }
    
    if (entry) { CFRelease(entry); }
    
    // We found a label, set our nickname (super handles changed notifications)
    if (label) {
        NSString *nickname = getNickname(label);
        if (nickname) { [super setNickname:nickname]; }
    }
    
    return maybeAlive;
}

- (BOOL)_remove {
    BOOL success = removeKeychainValue(_keychainKey, self.address);
    if (success) {
        [self purgeCachedData];
        
        __weak CloudKeychainSigner *weakSelf = self;
        
        NSDictionary *userInfo = @{};
        dispatch_async(dispatch_get_main_queue(), ^() {
            [[NSNotificationCenter defaultCenter] postNotificationName:SignerRemovedNotification
                                                                object:weakSelf
                                                              userInfo:userInfo];
        });
    }
    
    return success;
}
- (BOOL)remove {
    if (!_account) { return NO; }
    return [self _remove];
}

#pragma mark - UI State

// We use this from writeToKeychain so the nickname gets reflected immediately
- (void)_setNickname: (NSString*)nickname {
    [super setNickname:nickname];
}

- (void)setNickname:(NSString *)nickname {
    NSString *json = [self _json];
    Address *address = checkJson(json);
    if (address) {
        if ([address isEqualToAddress:self.address]) {
            addKeychainVaue(self.keychainKey, address, nickname, json, YES);
            [super setNickname:nickname];
        } else {
            NSLog(@"ERROR: setNickname - address does not match JSON");
        }
    }
}


#pragma mark - Blockchain Data

- (void)purgeCachedData {
    [super purgeCachedData];
    
    [self removeKeychainKey:KeychainKeyEncryptedKey];
    [self setDataStoreValue:nil forKey:DataStoreKeySecureEnclavePublicKey];
}


#pragma mark - Unlocking

- (BOOL)_setAccount: (Account*)account {
    if (![account.address isEqualToAddress:self.address]) { return NO; }
    _account = account;
    return YES;
}


#pragma mark - Biometric Unlocking

/**
 *  Keychain
 *
 *  The following keychain helper methods are used to maintain data which we want
 *  to keep secret, but limited to only this device and only while unlocked.
 *
 *  The only current example of this is the unlocked private key for an account
 *  which has been encrypted with the device's Secure Enclave. The purpose of this
 *  is to bypass the ~5s time required to run the scrpyt memory-hard password-based
 *  key derivation function. It is not really necessary to protect this data so
 *  strongly, since it is encrypted in the secure enclave and may only be decrypted
 *  inside it; but we might as well error on the side of caution (paranoia).
 *
 */

// Fetch local secret value
- (NSString*)keychainKeyForKey: (NSString*)key {
    NSString *suffix = @"";
    switch (self.provider.chainId) {
        case ChainIdHomestead:
            break;
        case ChainIdRopsten:
            suffix = @"/ropsten";
            break;
        case ChainIdKovan:
            suffix = @"/kovan";
            break;
        case ChainIdRinkeby:
            suffix = @"/rinkeby";
            break;
        default:
            return nil;
    }
    
    return [NSString stringWithFormat:@"%@%@_%@", self.address.checksumAddress, suffix, key];
}

// Set local secret value
- (BOOL)setKeychainKey: (NSString*)key value: (NSString*)value {
    NSString *keychainKey = [self keychainKeyForKey:key];
    
    NSDictionary *query = @{
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrGeneric: [keychainKey dataUsingEncoding:NSUTF8StringEncoding],
                            (id)kSecReturnAttributes: (id)kCFBooleanTrue,
                            (id)kSecAttrSynchronizable: (id)kCFBooleanFalse,
                            
                            (id)kSecAttrAccount: self.address.checksumAddress,
                            (id)kSecAttrService: keychainKey,
                            };
    
    CFDictionaryRef existingEntry = nil;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef*)&existingEntry);
    if (status == noErr) {
        NSMutableDictionary *updateQuery = [(__bridge NSDictionary *)existingEntry mutableCopy];
        [updateQuery setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
        
        NSDictionary *updateEntry = @{
                                      (id)kSecAttrSynchronizable: (id)kCFBooleanFalse,
                                      (id)kSecAttrIsInvisible: (id)kCFBooleanTrue,
                                      
                                      (id)kSecAttrAccount: self.address.checksumAddress,
                                      (id)kSecAttrService: keychainKey,
                                      (id)kSecValueData: [value dataUsingEncoding:NSUTF8StringEncoding],
                                      };
        
        status = SecItemUpdate((__bridge CFDictionaryRef)updateQuery, (__bridge CFDictionaryRef)updateEntry);
        if (status != noErr) {
            NSLog(@"CloudKeychainSigner: Failed updating keychain value - address=%@ key=%@ - %d", self.address, key, (int)status);
        }
        
    } else {
        NSError *error = nil;
        
        if (error) {
            NSLog(@"CloudKeychainSigner: Faile");
        }
        

        NSDictionary *addEntry = @{
                                   (id)kSecClass: (id)kSecClassGenericPassword,
                                   (id)kSecAttrGeneric: [keychainKey dataUsingEncoding:NSUTF8StringEncoding],

                                   (id)kSecAttrSynchronizable: (id)kCFBooleanFalse,
                                   (id)kSecAttrIsInvisible: (id)kCFBooleanTrue,
                                   
                                   (id)kSecAttrAccount: self.address.checksumAddress,
                                   (id)kSecAttrService: keychainKey,
                                   (id)kSecValueData: [value dataUsingEncoding:NSUTF8StringEncoding],
                                   };
        
        status = SecItemAdd((__bridge CFDictionaryRef)addEntry, NULL);
        if (status != noErr) {
            NSLog(@"CloudKeychainSigner: Failed adding keychain value - address=%@ key=%@ - %d", self.address, key, (int)status);
        }
    }
    
    if (existingEntry) { CFRelease(existingEntry); }
    
    return (status == noErr);
}

- (NSString*)getKeychainValueForKey: (NSString*)key {
    
    NSString *value = nil;
    
    {
        CFDataRef data = nil;
        
        NSString *keychainKey = [self keychainKeyForKey:key];
        
        NSDictionary *query = @{
                                (id)kSecClass: (id)kSecClassGenericPassword,
                                (id)kSecAttrGeneric: [keychainKey dataUsingEncoding:NSUTF8StringEncoding],
                                (id)kSecReturnData: (id)kCFBooleanTrue,
                                
                                (id)kSecAttrSynchronizable: (id)kCFBooleanFalse,
                                (id)kSecAttrIsInvisible: (id)kCFBooleanTrue,

                                (id)kSecAttrAccount: self.address.checksumAddress,
                                (id)kSecAttrService: keychainKey,
                                };
        

        
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef*)&data);
        if (status == noErr) {
            value = [[NSString alloc] initWithBytes:[(__bridge NSData*)data bytes]
                                             length:[(__bridge NSData*)data length]
                                           encoding:NSUTF8StringEncoding];
        }
        
        if (data) { CFRelease(data); }
    }
    
    return value;
}

- (BOOL)removeKeychainKey: (NSString*)key {
    NSString *keychainKey = [self keychainKeyForKey:key];

    NSDictionary *query = @{
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrGeneric: [keychainKey dataUsingEncoding:NSUTF8StringEncoding],
                            (id)kSecReturnAttributes: (id)kCFBooleanTrue,
                            
                            (id)kSecAttrSynchronizable: (id)kCFBooleanFalse,
                            (id)kSecAttrIsInvisible: (id)kCFBooleanTrue,
                            
                            (id)kSecAttrAccount: self.address.checksumAddress,
                            (id)kSecAttrService: keychainKey,
                            };
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != noErr) {
        NSLog(@"Error deleting 2");
    }
    
    return (status == noErr);
}


- (BOOL)generateSecureEnclaveKey {
    CFErrorRef error = NULL;
    SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                                    kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                                    kSecAccessControlTouchIDAny | kSecAccessControlPrivateKeyUsage, &error);
    
    if (error) {
        NSLog(@"CloudKeychainSigner: Error generating secure enclave access control - %d", (int)error);
        return NO;
    }
    
    // Create a new private key on the secure enclave
    NSDictionary *parameters = @{
                                 (id)kSecAttrTokenID: (id)kSecAttrTokenIDSecureEnclave,
                                 (id)kSecAttrKeyType: (id)kSecAttrKeyTypeECSECPrimeRandom,
                                 (id)kSecAttrKeySizeInBits: @256,
                                 (id)kSecAttrLabel: @"secure-enclave.ethers.io",
                                 (id)kSecPrivateKeyAttrs: @{
                                         (id)kSecAttrAccessControl: (__bridge_transfer id)sacObject,
                                         (id)kSecAttrIsPermanent: @YES,
                                         }
                                 };
    id privateKey = CFBridgingRelease(SecKeyCreateRandomKey((__bridge CFDictionaryRef)parameters, (void *)&error));
    
    if (privateKey == nil || error) {
        NSLog(@"CloudKeychainSigner: Error generating secure enclave key - %d", (int)error);
        return NO;
    }
    
    NSLog(@"CloudKeychainSigner: Created secure enclave private key");
    
    return YES;
}

- (void)destroySecureEnclaveKey {
    NSDictionary *query = @{
                            (id)kSecAttrTokenID: (id)kSecAttrTokenIDSecureEnclave,
                            (id)kSecClass: (id)kSecClassKey,
                            (id)kSecAttrKeyClass: (id)kSecAttrKeyClassPrivate,
                            (id)kSecAttrLabel: @"secure-enclave.ethers.io",
                            (id)kSecReturnRef: @YES,
                            };
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    
    if (status != noErr) {
        NSLog(@"CloudKeychainSigner: Error SecItemDelete - %d", (int)status);
    } else {
        NSLog(@"CloudKeychainSigner: Success - destroyed Secure Enclave key");
    }
}

- (NSData*)useSecureEnclaveKeyData: (NSData*)data encrypt: (BOOL)encrypt error: (NSError**)error {
    
    NSDictionary *params = @{
                             (id)kSecClass: (id)kSecClassKey,
                             (id)kSecAttrKeyType: (id)kSecAttrKeyTypeECSECPrimeRandom,
                             (id)kSecAttrKeySizeInBits: @256,
                             (id)kSecAttrLabel: @"secure-enclave.ethers.io",
                             (id)kSecReturnRef: @YES,
                             (id)kSecUseOperationPrompt: @"Authenticate to decrypt Private Key"
                             };

    // Retrieve the key from the keychain.  No authentication is needed at this point.
    SecKeyRef privateKey = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)params, (CFTypeRef *)&privateKey);
    
    // No private key on the secure enclave, try to create one
    if (status != errSecSuccess) {
        
        // This shouldn't happen if there was an error, but who knows
        if (privateKey) { CFRelease(privateKey); }
        
        // Attempt generation of a new secure enclave key, and redo the search
        [self generateSecureEnclaveKey];
        status = SecItemCopyMatching((__bridge CFDictionaryRef)params, (CFTypeRef *)&privateKey);
    }
    
    NSData *result = nil;
    
    if (status == errSecSuccess) {
        NSError *keychainError = nil;

        if (data) {
            if (encrypt) {
                
                // Encrypt the plaintext (does not require authentication)
                id publicKey = CFBridgingRelease(SecKeyCopyPublicKey((SecKeyRef)privateKey));
                result = CFBridgingRelease(SecKeyCreateEncryptedData((SecKeyRef)publicKey, kSecKeyAlgorithmECIESEncryptionCofactorX963SHA256AESGCM, (CFDataRef)data, (void*)&keychainError));
                
                if (keychainError) {
                    NSLog(@"CloudKeychainSigner: Error SecKeyCreateEncryptedData - %@", keychainError);
                    if (error) {
                        NSDictionary *userInfo = @{ @"error": keychainError };
                        *error = [NSError errorWithDomain:SignerErrorDomain code:SignerErrorFailed userInfo:userInfo];
                    }
                    result = nil;
                }

            } else {
                
                // Decrypt ciphertext using the public key (will cause authentication UI)
                result = CFBridgingRelease(SecKeyCreateDecryptedData((SecKeyRef)privateKey, kSecKeyAlgorithmECIESEncryptionCofactorX963SHA256AESGCM, (CFDataRef)data, (void*)&keychainError));
                
                if (keychainError) {
                    NSLog(@"CloudKeychainSigner: Error SecKeyCreateDecryptedData - %@", keychainError);

                    // Just cancelled... Not *really* an error
                    if ([keychainError.domain isEqualToString:LAErrorDomain] &&
                        (keychainError.code == LAErrorUserCancel || keychainError.code == LAErrorAppCancel)) {

                        if (error) {
                            *error = [NSError errorWithDomain:SignerErrorDomain code:SignerErrorCancelled userInfo:@{}];
                        }
                    
                    } else {
                        // Biometry failure; we may have been comprimised, so lets just error on the side of
                        // caution. Worst case, the legit use will need to re-enter their password to unlock
                        // their account
                        NSLog(@"CloudKeychainSigner: Security Fault; destroying secure enclave key - %@", keychainError);
                        [self destroySecureEnclaveKey];

                        if (error) {
                            NSDictionary *userInfo = @{ @"error": keychainError };
                            *error = [NSError errorWithDomain:SignerErrorDomain code:SignerErrorFailed userInfo:userInfo];
                        }
                    }
                    
                    result = nil;
                }
            }
        
        } else {
            
            // Query for the public key (does not require authentication)
            id publicKey = CFBridgingRelease(SecKeyCopyPublicKey((SecKeyRef)privateKey));
            result = CFBridgingRelease(SecKeyCopyExternalRepresentation((SecKeyRef)publicKey, (void*)&keychainError));
            
            if (keychainError) {
                NSLog(@"CloudKeychainSigner: Error SecKeyCopyExternalRepresentation - %@", keychainError);

                if (error) {
                    NSDictionary *userInfo = @{ @"error": keychainError };
                    *error = [NSError errorWithDomain:SignerErrorDomain code:SignerErrorFailed userInfo:userInfo];
                }
                
                result = nil;
            }
        }
    }
    
    if (privateKey) { CFRelease(privateKey); }

    return result;
}

- (BOOL)supportsBiometricUnlock {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    BOOL biometricsSupported = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (!biometricsSupported) { return NO; }
    
    NSData *publicKey = [self useSecureEnclaveKeyData:nil encrypt:NO error:nil];
    if (!publicKey || publicKey.length == 0) { return NO; }
    
    NSString *publicKeyString = [self dataStoreValueForKey:DataStoreKeySecureEnclavePublicKey];
    if (![publicKeyString isEqualToString:[SecureData dataToHexString:publicKey]]) { return NO; }
    
    return YES;
}

- (void)setBiometricSupport {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    BOOL biometricsSupported = [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    NSData *publicKey = [self useSecureEnclaveKeyData:nil encrypt:NO error:nil];
    if (_account && biometricsSupported && publicKey && publicKey.length) {
        NSData *encryptedKey = [self useSecureEnclaveKeyData:_account.privateKey encrypt:YES error:nil];
        if (encryptedKey) {
            [self setKeychainKey:KeychainKeyEncryptedKey value:[SecureData dataToHexString:encryptedKey]];
            [self setDataStoreValue:[SecureData dataToHexString:publicKey] forKey:DataStoreKeySecureEnclavePublicKey];
        }
        
    } else {
        [self removeKeychainKey:KeychainKeyEncryptedKey];
        [self setDataStoreValue:nil forKey:DataStoreKeySecureEnclavePublicKey];
    }
}

- (void)unlockBiometricCallback:(void (^)(Signer *, NSError *))callback {
    [self cancelUnlock];
    
    __weak CloudKeychainSigner *weakSelf = self;
    void (^sendError)(NSError*) = ^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^() {
            callback(weakSelf, error);
        });
    };
    
    NSString *encryptedKeyString = [self getKeychainValueForKey:KeychainKeyEncryptedKey];
    if (!encryptedKeyString) {
        sendError([NSError errorWithDomain:SignerErrorDomain code:SignerErrorUnsupported userInfo:@{}]);
        return;
    }
    
    NSData *encryptedKey = [SecureData hexStringToData:encryptedKeyString];
    if (!encryptedKey) {
        sendError([NSError errorWithDomain:SignerErrorDomain code:SignerErrorUnsupported userInfo:@{}]);
        return;
    }
    
    NSError *error = nil;
    NSData *key = [self useSecureEnclaveKeyData:encryptedKey encrypt:NO error:&error];
    if (!key) {
        if (!error) {
            error = [NSError errorWithDomain:SignerErrorDomain code:SignerErrorFailed userInfo:@{}];
        }
        sendError(error);
        return;
    }
    
    if (![self _setAccount:[Account accountWithPrivateKey:key]]) {
        sendError([NSError errorWithDomain:SignerErrorDomain code:SignerErrorFailed userInfo:@{}]);
        return;
    }
    
    // All good!
    sendError(nil);
}

- (void)_send:(Transaction *)transaction callback:(void (^)(Transaction *, NSError *))callback {
    __weak CloudKeychainSigner *weakSelf = self;
    
    NSData *signedTransaction = [transaction serialize];
    [[self.provider sendTransaction:signedTransaction] onCompletion:^(HashPromise *promise) {
        NSLog(@"%@: Sent - signed=%@ hash=%@ error=%@", NSStringFromClass([self class]), signedTransaction, promise.value, promise.error);
        
        if (promise.error) {
            callback(nil, promise.error);
        } else {
            [weakSelf addTransaction:transaction];
            callback(transaction, nil);
        }
    }];
}

- (ConfigController*)send:(Transaction *)transaction callback:(void (^)(Transaction *, NSError *))callback {
    transaction = [transaction copy];
    NSLog(@"CloudKeychainSigner: Sending - address=%@ transaction=%@", _account.address, transaction);

    if (!_account) {
        dispatch_async(dispatch_get_main_queue(), ^() {
            callback(nil, [NSError errorWithDomain:SignerErrorDomain code:SignerErrorAccountLocked userInfo:@{}]);
        });
        return nil;
    }
    
    [_account sign:transaction];
    
    [self setBiometricSupport];

    [self _send:transaction callback:callback];
    
    return nil;
}

- (ConfigController*)signMessage: (NSData*)message callback: (void (^)(Signature*, NSError*))callback {
    if (!_account) {
        dispatch_async(dispatch_get_main_queue(), ^() {
            callback(nil, [NSError errorWithDomain:SignerErrorDomain code:SignerErrorAccountLocked userInfo:@{}]);
        });
        return nil;
    }
    
    Signature *signature = [_account signMessage:message];
    
    [self setBiometricSupport];

    dispatch_async(dispatch_get_main_queue(), ^() {
        callback(signature, nil);
    });

    return nil;
}

#pragma mark - Password-Based Unlock

- (NSString*)_json {
    return getKeychainValue(self.keychainKey, self.address);
}

- (BOOL)supportsPasswordUnlock {
    return YES;
}

- (void)unlockPassword:(NSString *)password callback:(void (^)(Signer *, NSError *))callback {
    [self cancelUnlock];

    __weak CloudKeychainSigner *weakSelf = self;

    if (_account) {
        dispatch_async(dispatch_get_main_queue(), ^() {
            callback(weakSelf, nil);
        });
        return;
    }
    
    _unlocking = [Account decryptSecretStorageJSON:[self _json] password:password callback:^(Account *account, NSError *error) {
        if (error) {
            callback(weakSelf, error);
        
        } else if (![weakSelf _setAccount:account]){
            callback(weakSelf, [NSError errorWithDomain:SignerErrorDomain code:SignerErrorFailed userInfo:@{}]);
        
        } else {
            callback(weakSelf, nil);
        }
    }];
}


- (BOOL)supportsMnemonicPhrase {
    NSError *error = nil;
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:[[self _json] dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:0
                                                           error:&error];
    
    return (!error && [info objectForKey:@"x-ethers"] != nil);
}

- (NSString*)mnemonicPhrase {
    return _account.mnemonicPhrase;
}

- (BOOL)unlocked {
    return (_account != nil);
}

- (void)lock {
    [super lock];
    _account = nil;
}

- (void)cancelUnlock {
    if (_unlocking) {
        [_unlocking cancel];
        _unlocking = nil;
    }
}


@end
