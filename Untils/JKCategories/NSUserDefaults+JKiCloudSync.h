//
//  NSUserDefaults+iCloudSync.h
//
//  Created by Riccardo Paolillo on 09/05/13.
//  Copyright (c) 2013. All rights reserved.
//

//https://github.com/RiccardoPaolillo/NSUserDefault-iCloud
// A very simple iOS Category for synchronize NSUserDefaults with iCloud (NSUbiquitousKeyValueStore)

#import <Foundation/Foundation.h>


@interface NSUserDefaults (JKiCloudSync)
//设置  value,key iClound
-(void)jk_setValue:(id)value  forKey:(NSString *)key iCloudSync:(BOOL)sync;
//设置  object,key iClound
-(void)jk_setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;
//根据key取出value
-(id)jk_valueForKey:(NSString *)key  iCloudSync:(BOOL)sync;
//根据key取出对象
-(id)jk_objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

-(BOOL)jk_synchronizeAlsoiCloudSync:(BOOL)sync;

@end
