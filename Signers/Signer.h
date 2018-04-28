/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/


#import <Foundation/Foundation.h>

#import <ethers/Address.h>
#import <ethers/Provider.h>
#import <ethers/Transaction.h>

#include "ConfigController.h"

#pragma mark - Notifications

extern const NSNotificationName SignerRemovedNotification;

extern const NSNotificationName SignerNicknameDidChangeNotification;

extern const NSNotificationName SignerBalanceDidChangeNotification;
extern const NSNotificationName SignerHistoryUpdatedNotification;
extern const NSNotificationName SignerTransactionDidChangeNotification;

extern const NSNotificationName SignerSyncDateDidChangeNotification;


#pragma mark - Notification Keys

extern const NSString* SignerNotificationNicknameKey;
extern const NSString* SignerNotificationFormerNicknameKey;

extern const NSString* SignerNotificationBalanceKey;
extern const NSString* SignerNotificationFormerBalanceKey;

extern const NSString* SignerNotificationTransactionKey;

extern const NSString* SignerNotificationSyncDateKey;

#pragma mark - Errors

extern NSErrorDomain SignerErrorDomain;

typedef enum SignerError {
    SignerErrorNotImplemented                 = -1,
    SignerErrorUnsupported                    = -2,
    SignerErrorCancelled                      = -10,
    
    SignerErrorAccountLocked                  = -40,
    SignerErrorTransactionTooBig              = -41,

    SignerErrorFailed                         = -50,
    
} SignerError;

typedef enum SignerTextMessage {
    SignerTextMessageSendButton,
    SignerTextMessageSignButton,
    SignerTextMessageCancelButton,
} SignerTextMessage;

#pragma mark - Signer

@interface Signer : NSObject

- (instancetype)initWithCacheKey: (NSString*)cacheKey address: (Address*)address provider: (Provider*)provider;

@property (nonatomic, readonly) NSString *cacheKey;
@property (nonatomic, assign) NSUInteger accountIndex;
@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, readonly) Address *address;

@property (nonatomic, readonly) Provider *provider;



#pragma Blockchain Data

// This purges cached blockchain data, for example, when switching networks
- (void)purgeCachedData;

@property (nonatomic, readonly) BigNumber *balance;
@property (nonatomic, readonly) NSUInteger transactionCount;
@property (nonatomic, readonly) BOOL truncatedTransactionHistory;
@property (nonatomic, readonly) NSArray<TransactionInfo*> *transactionHistory;

@property (nonatomic, readonly) NSUInteger blockNumber;

@property (nonatomic, readonly) NSTimeInterval syncDate;

- (void)refresh: (void (^)(BOOL))callback;

#pragma mark - Signing

// Biometric-Based Unlocking
//  - A wallet only supports fingerprints if the password has previously been entered
@property (nonatomic, readonly) BOOL supportsBiometricUnlock;
- (void)unlockBiometricCallback: (void (^)(Signer*, NSError*))callback;

// Password-Based Unlocking
//   - Watch-only wallets (just an address) do not have passwords
//   - Various hardware wallets may manage their own password requirements
//   - Firefly hardware wallets require a password to decrypt the Firefly private key
//   - Secret Storage JSON wallets require a password to unlock them
@property (nonatomic, readonly) BOOL supportsPasswordUnlock;
- (void)unlockPassword: (NSString*)password callback: (void (^)(Signer*, NSError*))callback;


// Send
//  - Watch-only wallets (just an address) cannot sign
//  - Signing on Firefly hardware wallets opens a BLECast controller and a QR code scanner
//  - Secret Storage JSON wallets support signing with unlocked signers
//@property (nonatomic, readonly) BOOL supportsSign;

- (ConfigController*)send: (Transaction*)transaction callback: (void (^)(Transaction*, NSError*))callback;

- (ConfigController*)signMessage: (NSData*)message callback: (void (^)(Signature*, NSError*))callback;

// Cancel any pending transactions or signing
- (void)cancel;


// Mnemonic Phrase
//   - Watch-only wallets (just an address) do not have (known) mnemonic phrases
//   - Secret storage JSON wallets VNing ethers do
//   - Firefly (version 0) wallets do not
@property (nonatomic, readonly) BOOL supportsMnemonicPhrase;

// This is only available if the signer is unlocked and supports mnemonic phrases
@property (nonatomic, readonly) NSString *mnemonicPhrase;

// If unlocked, may call send:callback: or signMessage:callback:
@property (nonatomic, readonly) BOOL unlocked;

// Lock and cancel any in-flight unlock
- (void)lock;

// Cancel any unlock in progress
- (void)cancelUnlock;

- (NSString*)textMessageFor: (SignerTextMessage)textMessageType;

#pragma mark - Subclass support functions

// Sub-classes can use these to update the cached state
- (void)addTransaction: (Transaction*)transaction;

// Stores values, unencrypted in a local-only data store
- (NSString*)dataStoreValueForKey: (NSString*)key;
- (void)setDataStoreValue: (NSString*)value forKey: (NSString*)key;


@end
