//
//  ShowWallet.h
//  ShowLive
//
//  Created by Mac on 2018/4/3.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ethers/Address.h>
#import <ethers/BigNumber.h>
#import <ethers/Payment.h>
#import <ethers/Provider.h>
#import <ethers/Transaction.h>
#import <ethers/TransactionInfo.h>
#import <ethers/Account.h>

typedef NSUInteger AccountIndex;

#define AccountNotFound          NSIntegerMax

static NSString *const ShowSessionAccount_token    = @"kSessionAccount_token";
static NSString *const ShowSessionAccount_pass    = @"kSessionAccount_pass";
static NSString *const ShowSessionAccount_mn    = @"kSessionAccount_mn";

#pragma mark - Notifications

extern const NSNotificationName ShowWalletAccountAddedNotification;
extern const NSNotificationName ShowWalletAccountRemovedNotification;
extern const NSNotificationName ShowWalletAccountsReorderedNotification;

// 帐户更改名称。
extern const NSNotificationName ShowWalletAccountNicknameDidChangeNotification;

// 如果账户余额发生变化。
extern const NSNotificationName ShowWalletAccountBalanceDidChangeNotification;

// 如果活动帐户事务更改(包括确认计数)
extern const NSNotificationName ShowWalletTransactionDidChangeNotification;
// 账户历史更新
extern const NSNotificationName ShowWalletAccountHistoryUpdatedNotification;
// 激活账户更新通知
extern const NSNotificationName ShowWalletActiveAccountDidChangeNotification;
// 账户同步通知
extern const NSNotificationName ShowWalletDidSyncNotification;


#pragma mark - Notification Keys
// 账户地址私钥
extern const NSString* ShowWalletNotificationAddressKey;
extern const NSString* ShowWalletNotificationProviderKey;
extern const NSString* ShowWalletNotificationIndexKey;
// 账户名称
extern const NSString* ShowWalletNotificationNicknameKey;
// 余额变化
extern const NSString* ShowWalletNotificationBalanceKey;
// 事务key
extern const NSString* ShowWalletNotificationTransactionKey;
// 同步时间
extern const NSString* ShowWalletNotificationSyncDateKey;


#pragma mark - Errors

extern NSErrorDomain WalletErrorDomain;

typedef enum ShowWalletError {
    ShowWalletErrorNetwork                   =  -1,
    ShowWalletErrorUnknown                   =  -5,
    ShowWalletErrorSendCancelled             = -11,
    ShowWalletErrorSendInsufficientFunds     = -12,
    ShowWalletErrorNoAccount                 = -40,
    ShowWalletErrorNotImplemented            = -50,
} WalletError;

#pragma mark - Constants

typedef enum ShowWalletTransactionAction {
    ShowWalletTransactionActionNormal = 0,
    ShowWalletTransactionActionRush = 1,
    ShowWalletTransactionActionCancel = 2
} WalletTransactionAction ;

typedef enum ShowWalletOptionsType {
    ShowWalletOptionsTypeDebug,
    ShowWalletOptionsTypeFirefly
} WalletOptionsType;


@interface ShowWallet : NSObject

+ (instancetype)show_walletWithKeychainKey: (NSString*)keychainKey;

@property (nonatomic, readonly) NSString *keychainKey;

@property (nonatomic, readonly) NSTimeInterval syncDate;

@property (nonatomic, readonly) float etherPrice;

- (void)show_refresh: (void (^)(BOOL))callback;


#pragma mark - Accounts

@property (nonatomic, assign) AccountIndex activeAccountIndex;

//当前使用中钱包的地址
@property (nonatomic, readonly) show_Address *activeAccountAddress;
@property (nonatomic, readonly) show_Provider *activeAccountProvider;
@property (nonatomic, readonly) show_Account * account;

@property (nonatomic, assign) NSUInteger activeAccountBlockNumber;

//当前账户数
@property (nonatomic, readonly) NSUInteger numberOfAccounts;

- (Address*)show_addressForIndex: (AccountIndex)index;
- (BigNumber*)show_balanceForIndex: (AccountIndex)index;
- (ChainId)show_chainIdForIndex: (AccountIndex)index;
- (NSString*)show_nicknameForIndex: (AccountIndex)index;
- (void)show_setNickname: (NSString*)nickname forIndex: (AccountIndex)index;
- (NSArray<TransactionInfo*>*)show_transactionHistoryForIndex: (AccountIndex)index;

- (void)show_moveAccountAtIndex: (NSUInteger)fromIndex toIndex: (NSUInteger)toIndex;


#pragma mark - Account Management (Modal UI)

- (void)show_addAccountCallback ;
- (void)show_manageAccountAtIndex: (AccountIndex)index callback: (void (^)(void))callback;


#pragma mark - Transactions (Modal UI)

- (void)ShowScan: (void (^)(Transaction*, NSError*))callback;

- (void)show_sendPayment: (Payment*)payment callback: (void (^)(Transaction*, NSError*))callback;
- (void)show_sendTransaction: (Transaction*)transaction callback:(void (^)(Transaction*, NSError*))callback;

- (void)show_overrideTransaction: (TransactionInfo*)oldTransaction
                     action: (WalletTransactionAction)action
                   callback:(void (^)(Transaction*, NSError*))callback;

- (void)show_signMessage: (NSData*)message callback:(void (^)(Signature*, NSError*))callback;

#pragma mark - Debug (Modal UI)

- (void)show_showDebuggingOptions: (WalletOptionsType)walletOptionsType callback: (void (^)(void))callback;


#pragma mark - Debugging Options

@property (nonatomic, assign) BOOL fireflyEnabled;
@property (nonatomic, assign) BOOL testnetEnabled;

- (void)show_purgeCacheData;

@end
