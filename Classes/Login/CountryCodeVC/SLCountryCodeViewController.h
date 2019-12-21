//
//  SLCountryCodeViewController.h
//  ShowLive
//
//  Created by iori_chou on 2019/11/16.
//  Copyright © 2019 vning. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^returnCountryCodeBlock) (NSString *countryName, NSString *code);

@protocol SLCountryCodeControllerDelegate <NSObject>

@optional

/**
 Delegate 回调所选国家代码

 @param countryName 所选国家
 @param code 所选国家代码
 */
-(void)returnCountryName:(NSString *)countryName code:(NSString *)code;

@end

@interface SLCountryCodeViewController : BaseViewController
@property (nonatomic, weak) id<SLCountryCodeControllerDelegate> deleagete;

@property (nonatomic, copy) returnCountryCodeBlock returnCountryCodeBlock;
@end

NS_ASSUME_NONNULL_END
