//
//  SLMemberListSortManager.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLMemberListSortManager.h"
#import "SLLiveMemberListAction.h"
static SLMemberListSortManager * manager = nil;

@interface SLMemberListSortManager ()
{
     NSOperationQueue  *sortQueue;
}

//房间成员列表
@property(nonatomic,strong)NSMutableArray * memberSortArray;

//排序模型字典
@property(nonatomic,strong)NSMutableDictionary * memberDic;

//队列
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation SLMemberListSortManager

+(SLMemberListSortManager*)shareManager;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[SLMemberListSortManager alloc] init];
        
    });
    return manager;
}
-(id)init
{
    self = [super init];
    if (self) {
 
        [self initTaskQueue];
    }
    
    return self;
}
- (void)initTaskQueue
{
    sortQueue = [[NSOperationQueue alloc]init];
    sortQueue.name = @"one.SHOW.ShowLive.sortArray";
    sortQueue.maxConcurrentOperationCount = 1;
}

//获取直播间成员列表
-(void)requestMemberListWithLiveId:(NSString*)liveId;
{
    SLLiveMemberListAction * action = [SLLiveMemberListAction action];
    action.roomId = liveId;
    action.cursor = @"0";
    action.count = @"20";
    [self sl_startRequestAction:action Sucess:^(id result) {
  
    } FaildBlock:^(NSError *error) {
        
    }];
    
}

-(void)addMemberArray:(NSArray*)userArray
{
    [userArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL*stop) {
        
        SLMemberListModel * member = (SLMemberListModel*)obj;
        [self addMemerToSortArray:member sort:NO];
        
    }];
    
    [self sortMemberQueue];
}

-(void)joinChatRoomWithMember:(SLMemberListModel*)member
{

    [self addMemerToSortArray:member sort:YES];
}

-(void)exitChatRoomWithMember:(SLMemberListModel*)member
{

    [self removeMemberFromSortArray:member sort:YES];
}

-(void)upgradeWithMember:(SLMemberListModel*)member
{

    //如果成员字典里面包含当前主播模型
    SLMemberListModel* obj  = [self.memberDic objectForKey:member.uid];
    if (obj != nil) {
        [self sortMemberQueue];
    }
    
}

-(void)addMemerToSortArray:(SLMemberListModel*)member sort:(BOOL)isSort
{
    
    if (member != nil && [member isKindOfClass:[SLMemberListModel class]]) {
     
        // 限制观众列表数为50个
        @synchronized (self) {
            
            if (self.memberDic.count >= 50 && IS_ARRAY_CLASS(self.memberSortArray)) {
                
                SLMemberListModel *model = self.memberSortArray.lastObject;
                
                if (model.fanLevel == 1 || model.fanLevel == 0) {
                    [self removeMemberFromSortArray:model sort:NO];
                }
                
                // 最后进来的等级为1的不需要排序
                if (model.fanLevel == 1 || model.fanLevel == 0) {
                    isSort = NO;
                }
            }
        }
        
        
        @synchronized (self) {
            
            [self.memberDic setObject:member forKey:member.uid];
        }
        
        if (isSort) {
            [self sortMemberQueue];
        }
    }
}

-(void)removeMemberFromSortArray:(SLMemberListModel*)member sort:(BOOL)isSort
{
    
    SLMemberListModel * model = [self.memberDic objectForKey:member.uid];
    if (model == nil) {
        return;
    }
    
    @synchronized (self) {
    
        [self.memberDic removeObjectForKey:model.uid];
        [self.memberSortArray removeObject:model];
        
    }
    
    if (isSort) {
        [self sortMemberQueue];
    }
    
}


-(void)sortMemberQueue
{
    [sortQueue cancelAllOperations];
    [sortQueue addOperationWithBlock:^{
        [self sortMember];
    }];
}


//排序
-(void)sortMember
{

    @synchronized(self) {
        
        self.memberSortArray = [[NSMutableArray arrayWithArray:self.memberDic.allValues] mutableCopy];
        
        [self.memberSortArray sortWithOptions:NSSortStable usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            SLMemberListModel * member1 = obj1;
            SLMemberListModel * member2 = obj2;
            
            if (member1.fanLevel== member2.fanLevel) {
                return [member1.uid compare:member2.uid];
            } else {
                
                return member1.fanLevel < member2.fanLevel;
            }
            
            
        }];

    }
    
    //这里可以reload成员列表
    dispatch_async(dispatch_get_main_queue(), ^(){
        
        @synchronized(self) {
            
            NSArray *memberArray = [self.memberSortArray mutableCopy];
            if (self.reloadMemberView) {
                self.reloadMemberView(memberArray);
            }

        }
        
    });
    
}


-(void)clearData
{
    //   NSLog(@"ant: sort clearDate");
    [sortQueue cancelAllOperations];
    
    @synchronized(self) {
        [self.memberDic removeAllObjects];
        [self.memberSortArray removeAllObjects];
 
        
    }
}

-(NSMutableDictionary*)memberDic
{
    if (!_memberDic) {
        _memberDic = [NSMutableDictionary dictionary];
    }
    return _memberDic;
}

-(NSMutableArray*)memberSortArray
{
    if (!_memberSortArray) {
        _memberSortArray = [NSMutableArray array];
    }
    return _memberSortArray;
}



@end
