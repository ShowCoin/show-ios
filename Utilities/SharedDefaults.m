/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/

#import "SharedDefaults.h"

NSString* UserDefaultsAddress = @"USER_SHARED_DEFAULTS_ADDRESS";
NSString* UserDefaultsBalance = @"USER_SHARED_DEFAULTS_BALANCE";

NSString* UserDefaultsTotalBalance = @"USER_SHARED_DEFAULTS_TOTAL_BALANCE";
NSString* UserDefaultsEtherPrice = @"USER_SHARED_DEFAULTS_ETHER_PRICE";

@interface SharedDefaults () {
    NSUserDefaults *_userDefaults;
}

@end

@implementation SharedDefaults

+ (instancetype)sharedDefaults {
    static SharedDefaults *sharedDefaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDefaults = [[SharedDefaults alloc] init];
    });
    return sharedDefaults;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.io.ethers.app"];
    }
    return self;
}

- (BigNumber*)balance {
    NSString *balanceHex = [_userDefaults objectForKey:UserDefaultsBalance];
    if (!balanceHex) { return [BigNumber constantZero]; }
    return [BigNumber bigNumberWithHexString:balanceHex];
}

- (void)setBalance:(BigNumber *)balance {
    [_userDefaults setObject:[balance hexString] forKey:UserDefaultsBalance];
}

- (Address*)address {
    NSString *address = [_userDefaults objectForKey:UserDefaultsAddress];
    if (!address) { return nil; }
    return [Address addressWithString:address];
}

- (void)setAddress:(Address *)address {
    if (address) {
        [_userDefaults setObject:[address checksumAddress] forKey:UserDefaultsAddress];
    } else {
        [_userDefaults removeObjectForKey:UserDefaultsAddress];
    }
}

- (BigNumber*)totalBalance {
    NSString *balanceHex = [_userDefaults objectForKey:UserDefaultsTotalBalance];
    if (!balanceHex) { return [BigNumber constantZero]; }
    return [BigNumber bigNumberWithHexString:balanceHex];
}

- (void)setTotalBalance:(BigNumber *)totalBalance {
    [_userDefaults setObject:[totalBalance hexString] forKey:UserDefaultsTotalBalance];
}

- (float)etherPrice {
    return [_userDefaults floatForKey:UserDefaultsEtherPrice];
}

- (void)setEtherPrice:(float)etherPrice {
    [_userDefaults setFloat:etherPrice forKey:UserDefaultsEtherPrice];
}

@end
