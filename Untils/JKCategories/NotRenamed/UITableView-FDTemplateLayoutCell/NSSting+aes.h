//
//  NSSting+aes.h
//  ShowLive
//
//  Created by gongxin on 2019/1/19.
//  Copyright © 2019 vning. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSSting (aes)

/**< 加密方法 */
- (NSString*)aci_encryptWithAES;

/**< 解密方法 */
- (NSString*)aci_decryptWithAES;


//md5
+ (NSString *) md5:(NSString *) str;
@end

NS_ASSUME_NONNULL_END
