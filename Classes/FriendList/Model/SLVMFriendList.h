//
//  SLVMFriendList.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLVMFriendList : NSObject
//好友列表
@property (nonatomic,strong)NSMutableDictionary* dataDict;
@property (nonatomic,strong)NSMutableArray* listAry;
@property (nonatomic,strong)NSMutableArray* sortArray;
@property (nonatomic,copy) NSString* searchKey;
@property (nonatomic,assign)NSInteger cursor;
@property (nonatomic,assign)NSUInteger uid;
@property (nonatomic,weak)id parentVC;
@property (nonatomic,assign)BOOL isAt;

-(void)loadFromLocal;
-(void)refreshData:(SuccessBlock)succ withFail:(FailBlock)fail;
-(void)loadMoreData:(SuccessBlock)succ withFail:(FailBlock)fail;

@end
