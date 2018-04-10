//
//  PrivacyModel.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "PrivacyModel.h"
#import "NSObject+BGModel.h"

#define bg_tableNameString @"BGFMDB"
#define aes128Key @"10x0dfad03x1df00dasf3049dafkdsf9sdfn3m39mdf949m4mdf99fd9f9ds"
@interface PrivacyModel()

@property (nonatomic, readwrite) NSData *private;
@property (nonatomic, readwrite) NSData *Data;
@property (nonatomic, readwrite) NSData *jsondata;

@property (nonatomic, readwrite) NSData *checksum;
@property (nonatomic, readwrite) NSData *icap;
@property (nonatomic, readwrite) NSString * accountID;

@property (nonatomic, readwrite) NSString *privateString;
@property (nonatomic, readwrite) NSString *DataString;
@property (nonatomic, readwrite) NSString *jsonString;

@property (nonatomic, readwrite) NSString *checksumString;
@property (nonatomic, readwrite) NSString *icapString;
@property (nonatomic, readwrite) NSData *nickName;
@property (nonatomic, readwrite) NSString *nickNameString;

@end

@implementation PrivacyModel

+ (void)savedPrivacyModelToDBWith:(id)account accountID:(NSString *)accountID json:(NSString *)jsonString nickName:(NSString *)nickName{
    id  model = [[NSObject alloc]init];
  
  
  //  model.bg_tableName = bg_tableNameString;//自定义数据库表名称(库自带的字段).
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [model bg_saveOrUpdate];
    });
}
//+(NSArray* _Nonnull)bg_uniqueKeys{
//    return @[@"private"];
//}
//
//+(NSArray *)getPrivacyModelFromDBWithAccount:(NSString *)accountID{
//    NSArray *array =    [PrivacyModel bg_find:bg_tableNameString where:[NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"accountID"),bg_sqlValue(accountID)]];
//    for (PrivacyModel *model in array) {
//        model.privateString = [AES128Encrypt decryptData:model.private withKey:aes128Key iv:NULL];
//        model.DataString = [AES128Encrypt decryptData:model.private withKey:aes128Key iv:NULL];
//        model.checksumString = [AES128Encrypt decryptData:model.private withKey:aes128Key iv:NULL];
//        model.icapString = [AES128Encrypt decryptData:model.private withKey:aes128Key iv:NULL];
//        model.jsonString = [AES128Encrypt decryptData:model.jsondata withKey:aes128Key iv:NULL];
//        model.nickNameString = [AES128Encrypt decryptData:model.nickName withKey:aes128Key iv:NULL];
//    }
//    return array ;
//}
//
//+ (void)deletePrivacyModel:(PrivacyModel *)model{
//    [PrivacyModel bg_delete:bg_tableNameString where:[NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"private"),bg_sqlValue(model.private)]];
//}
@end
