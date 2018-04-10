//
//  ShowWallet.h
//  ShowLive
//
//  Created by 周华 on 2018/4/3.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ethers/Address.h>
#import <ethers/BigNumber.h>
#import <ethers/Payment.h>
#import <ethers/Provider.h>
#import <ethers/Transaction.h>
#import <ethers/TransactionInfo.h>
#import <ethers/Account.h>
#define WalletProfile [ShowWallet walletWithKeychainKey:@"io.ethers.showWallet"]

typedef NSUInteger AccountIndex;

#define AccountNotFound          NSIntegerMax

static NSString *const kSessionAccount_token    = @"kSessionAccount_token";
static NSString *const kSessionAccount_pass    = @"kSessionAccount_pass";
static NSString *const kSessionAccount_mn    = @"kSessionAccount_mn";

#pragma mark - Notifications

extern const NSNotificationName WalletAccountAddedNotification;
extern const NSNotificationName WalletAccountRemovedNotification;
extern const NSNotificationName WalletAccountsReorderedNotification;

// 帐户更改名称。
extern const NSNotificationName WalletAccountNicknameDidChangeNotification;

// 如果账户余额发生变化。
extern const NSNotificationName WalletAccountBalanceDidChangeNotification;

// 如果活动帐户事务更改(包括确认计数)
extern const NSNotificationName WalletTransactionDidChangeNotification;
extern const NSNotificationName WalletAccountHistoryUpdatedNotification;

extern const NSNotificationName WalletActiveAccountDidChangeNotification;

extern const NSNotificationName WalletDidSyncNotification;


#pragma mark - Notification Keys

extern const NSString* WalletNotificationAddressKey;
extern const NSString* WalletNotificationProviderKey;
extern const NSString* WalletNotificationIndexKey;

extern const NSString* WalletNotificationNicknameKey;

extern const NSString* WalletNotificationBalanceKey;
extern const NSString* WalletNotificationTransactionKey;

extern const NSString* WalletNotificationSyncDateKey;


#pragma mark - Errors

extern NSErrorDomain WalletErrorDomain;

typedef enum WalletError {
    WalletErrorNetwork                   =  -1,
    WalletErrorUnknown                   =  -5,
    WalletErrorSendCancelled             = -11,
    WalletErrorSendInsufficientFunds     = -12,
    WalletErrorNoAccount                 = -40,
    WalletErrorNotImplemented            = -50,
} WalletError;

#pragma mark - Constants

typedef enum WalletTransactionAction {
    WalletTransactionActionNormal = 0,
    WalletTransactionActionRush = 1,
    WalletTransactionActionCancel = 2
} WalletTransactionAction ;

typedef enum WalletOptionsType {
    WalletOptionsTypeDebug,
    WalletOptionsTypeFirefly
} WalletOptionsType;


@interface ShowWallet : NSObject
+ (instancetype)walletWithKeychainKey: (NSString*)keychainKey;

@property (nonatomic, readonly) NSString *keychainKey;

@property (nonatomic, readonly) NSTimeInterval syncDate;

@property (nonatomic, readonly) float etherPrice;

- (void)refresh: (void (^)(BOOL))callback;


#pragma mark - Accounts

@property (nonatomic, assign) AccountIndex activeAccountIndex;

@property (nonatomic, readonly) Address *activeAccountAddress;
@property (nonatomic, readonly) Provider *activeAccountProvider;
@property (nonatomic, readonly)Account * account;

@property (nonatomic, assign) NSUInteger activeAccountBlockNumber;


@property (nonatomic, readonly) NSUInteger numberOfAccounts;

- (Address*)addressForIndex: (AccountIndex)index;
- (BigNumber*)balanceForIndex: (AccountIndex)index;
- (ChainId)chainIdForIndex: (AccountIndex)index;
- (NSString*)nicknameForIndex: (AccountIndex)index;
- (void)setNickname: (NSString*)nickname forIndex: (AccountIndex)index;
- (NSArray<TransactionInfo*>*)transactionHistoryForIndex: (AccountIndex)index;

- (void)moveAccountAtIndex: (NSUInteger)fromIndex toIndex: (NSUInteger)toIndex;


#pragma mark - Account Management (Modal UI)

- (void)addAccountCallback ;
- (void)manageAccountAtIndex: (AccountIndex)index callback: (void (^)(void))callback;


#pragma mark - Transactions (Modal UI)

- (void)scan: (void (^)(Transaction*, NSError*))callback;

- (void)sendPayment: (Payment*)payment callback: (void (^)(Transaction*, NSError*))callback;
- (void)sendTransaction: (Transaction*)transaction callback:(void (^)(Transaction*, NSError*))callback;

- (void)overrideTransaction: (TransactionInfo*)oldTransaction
                     action: (WalletTransactionAction)action
                   callback:(void (^)(Transaction*, NSError*))callback;

- (void)signMessage: (NSData*)message callback:(void (^)(Signature*, NSError*))callback;

#pragma mark - Debug (Modal UI)

- (void)showDebuggingOptions: (WalletOptionsType)walletOptionsType callback: (void (^)(void))callback;


#pragma mark - Debugging Options

@property (nonatomic, assign) BOOL fireflyEnabled;
@property (nonatomic, assign) BOOL testnetEnabled;
- (void)purgeCacheData;

@end
