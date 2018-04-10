/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/

#import <Foundation/Foundation.h>

#import <ethers/Address.h>
#import <ethers/BigNumber.h>


@interface SharedDefaults : NSObject

+ (instancetype)sharedDefaults;

@property (nonatomic, strong) Address *address;
@property (nonatomic, strong) BigNumber *balance;

@property (nonatomic, strong) BigNumber *totalBalance;

@property (nonatomic, assign) float etherPrice;

@end
