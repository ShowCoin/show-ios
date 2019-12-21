//
//  DCSafetyIDModel.h
//  ShowLive
//
//  Created by chenyh on 2019/1/28.
//  Copyright © 2019 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DCCodeType) {
    DCCodeTypeSMS = 0,
    DCCodeTypeEmail,
    DCCodeTypeGoogle,
};

@interface DCSafetyIDModel : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *typeValue;
@property (nonatomic, strong) NSString *country_code;

@property (nonatomic, assign) DCCodeType codeType;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *detail;

@end

NS_ASSUME_NONNULL_END
