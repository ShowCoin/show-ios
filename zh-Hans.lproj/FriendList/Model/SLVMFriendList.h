//
//  SLVMFriendList.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLVMFriendList : NSObject
//数据字典
@property (nonatomic,strong)NSMutableDictionary* dataDict;
//好友列表
@property (nonatomic,strong)NSMutableArray* listAry;
//排序列表
@property (nonatomic,strong)NSMutableArray* sortArray;
//搜索key
@property (nonatomic,copy) NSString* searchKey;
//页数
@property (nonatomic,assign)NSInteger cursor;
//uid
@property (nonatomic,assign)NSUInteger uid;
//父视图
@property (nonatomic,weak)id parentVC;
@property (nonatomic,assign)BOOL isAt;

//从本地加载
-(void)loadFromLocal;
//刷新数据失败回调
-(void)refreshData:(SuccessBlock)succ withFail:(FailBlock)fail;
//加载更多数据失败回调
-(void)loadMoreData:(SuccessBlock)succ withFail:(FailBlock)fail;

@end
