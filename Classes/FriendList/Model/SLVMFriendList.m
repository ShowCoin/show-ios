//
//  SLVMFriendList.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLVMFriendList.h"
#import "SLDatabaseManager.h"
#import "SLFansModel.h"
#import "MJExtension.h"
#import "BMChineseSort.h"
#import "SLAttentionListAction.h"
#import "SLFriendListCell.h"

static NSString * kLocalData4FriendList = @"kFriendListLocalData:%@";

@interface SLVMFriendList()<UITableViewDataSource>
{
    NSMutableArray* searchedAry;
    NSLock* _lock;
}
@property (nonatomic, strong) SLAttentionListAction *friendListAction;

@end

@implementation SLVMFriendList

- (instancetype)init{
    if (self=[super init]) {
        self.dataDict=[NSMutableDictionary dictionaryWithCapacity:1];
        self.listAry=[NSMutableArray arrayWithCapacity:1];
        searchedAry=[NSMutableArray arrayWithCapacity:1];
        self.sortArray=[NSMutableArray arrayWithCapacity:1];
        _lock=[[NSLock alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onObserverNotify:) name:SL_LOGINSUSSCES object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onObserverNotify:) name:kNotificationFriendRemark object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onObserverNotify:) name:kNotificationChangeFollowStatus object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onObserverNotify:(NSNotification*)notification{
    if ([notification.name isEqualToString:kNotificationFriendRemark]) {
        ShowUserModel* notifyUser=(ShowUserModel*)notification.object;
        BOOL isNeedRefresh=NO;
        if (notification.object&&[notifyUser isKindOfClass:[ShowUserModel class]]) {
            for (SLFansModel* user in self.listAry) {
                if ([user.uid isEqualToString:notifyUser.uid]) {
                    user.localRemarkName=notifyUser.remarkName;
                    NSString* letterFrom=user.nickname;
                    if (ValidStr(user.localRemarkName)) {
                        letterFrom=user.localRemarkName;
                    }
                    user.firstLetter=[BMChineseSort getFirstLetter1:letterFrom];
                    if ([user.firstLetter length]>1) {
                        user.firstLetter=[user.firstLetter substringToIndex:1];
                    }
                    isNeedRefresh=YES;
                    break;
                }
            }
        }
        if (isNeedRefresh) {
            if (!_isAt) {
                [self updateData];
            }
            UITableView* _tableView=[self.parentVC valueForKey:@"_tableView"];
            if (_tableView&&[_tableView isKindOfClass:[UITableView class]]) {
                [_tableView reloadData];
            }
        }
    }
    else if ([notification.name isEqualToString:SL_LOGINSUSSCES]) {
        if (self.parentVC&&[self.parentVC respondsToSelector:@selector(loadData)]) {
            [self.parentVC performSelector:@selector(loadData) withObject:nil];
        }
    }
    else if ([notification.name isEqualToString:kNotificationChangeFollowStatus]) {
         @weakify(self);
        dispatch_sub_thread(^{
            @strongify(self);
            NSDictionary* dict=notification.object;
            if (dict&&[dict isKindOfClass:[NSDictionary class]]) {
                if (![[dict objectForKey:@"isfollow"] boolValue]) {
                    NSString* uid=[dict objectForKey:@"uid"];
                    if(ValidStr(uid)){
                        for (SLFansModel* user in self.listAry) {
                            if ([user.uid isEqualToString:uid]) {
                                [self.listAry removeObject:user];
                                
                                if (!self->_isAt) {
                                    [self updateData];
                                }
                                dispatch_safe_main((^{
                                    UITableView* _tableView=[self.parentVC valueForKey:@"_tableView"];
                                    if (_tableView&&[_tableView isKindOfClass:[UITableView class]]) {
                                        [_tableView reloadData];
                                    }
                                    UILabel* _lblFriendTotals=[self.parentVC valueForKey:@"_lblFriendTotals"];
                                    if (_lblFriendTotals
                                        &&[_lblFriendTotals isKindOfClass:[UILabel class]]) {
                                        _lblFriendTotals.text=[NSString stringWithFormat:@"%lu个SHOW好友",self.listAry.count];
                                    }
                                }));
                                break;
                            }
                        }
                        return;
                    }
                }
            }
            
            [self->_lock lock];
            dispatch_safe_main(^{
                if (self.parentVC&&[self.parentVC respondsToSelector:@selector(loadData)]) {
                    [self.parentVC performSelector:@selector(loadData) withObject:nil];
                }
            });
            [self->_lock unlock];
        });
        
    }
}

-(void)setSearchKey:(NSString*)key{
    _searchKey=key;
    [searchedAry removeAllObjects];
    if (ValidStr(key)) {
        for (SLFansModel* user in self.listAry) {
            if ([user.nickname containsString:_searchKey]||[user.popularNo containsString:_searchKey]) {
                [searchedAry addObject:user];
            }
        }
    }
    UITableView* _tableView=[self.parentVC valueForKey:@"_tableView"];
    if (_tableView&&[_tableView isKindOfClass:[UITableView class]]) {
        [_tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (ValidStr(_searchKey)) {
        return 1;
    }else{
        return _isAt?1:[self.sortArray count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (ValidStr(_searchKey)) {
        return [searchedAry count];
    }else{
        if (_isAt) {
            return self.listAry.count;
        }
        else
        {
            if (section < [self.sortArray count]) {
                NSArray *array = [self.dataDict objectForKey:[self.sortArray objectAtIndex:section]];
                return array.count;
            }
            else{
                return 0;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLFriendListCell* cell=[SLFriendListCell cellWithTableView:tableView];
    SLFansModel *curData=nil;
    if (ValidStr(_searchKey)) {
        if (indexPath.row < [searchedAry count]) {
            curData = [searchedAry objectAtIndex:indexPath.row];
        }
    }
    else if (_isAt)
    {
        curData = [self.listAry  objectAtIndex:indexPath.row];
    }
    else{
        if (indexPath.section < [self.sortArray  count]) {
            NSArray *array = [self.dataDict objectForKey:[self.sortArray objectAtIndex:indexPath.section]];
            if (indexPath.row < [array count]) {
                curData = [array objectAtIndex:indexPath.row];
            }
        }
    }
    if (curData && [curData isKindOfClass:[SLFansModel class]]) {
        cell.userListModel = curData;
        cell.functionDelegate=(id)self.parentVC;
    }
    cell.isAt =_isAt;
    return cell;
}

- (void)updateData{
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc]init];
    
    NSString * pinyin=@"#";
    NSMutableArray *arr=[NSMutableArray arrayWithCapacity:1];
    
    for (SLFansModel * user in self.listAry) {
        if (ValidStr(user.firstLetter)) {
            pinyin = user.firstLetter;
        }
        
        if([[dataDic allKeys]containsObject:pinyin]){
            arr = [dataDic objectForKey:pinyin];
            [arr addObject:user];
            [dataDic setObject:arr forKey:pinyin];
            
        }else{
            arr = [[NSMutableArray alloc]initWithObjects:user, nil];
            [dataDic setObject:arr forKey:pinyin];
        }
        pinyin=@"#";
    }
    [self.sortArray removeAllObjects];
    [self.sortArray addObjectsFromArray:[[NSArray array] arrayByAddingObjectsFromArray:[[dataDic allKeys] sortedArrayUsingSelector:@selector(compare:)]]];
    [self.dataDict removeAllObjects];
    for (NSInteger i = 0; i < [self.sortArray count]; i++) {
        NSString *strKey = [self.sortArray objectAtIndex:i];
        
        NSArray *array = [dataDic objectForKey:strKey];
        [self.dataDict setObject:array forKey:strKey];
    }
}


- (void)loadFromLocal{
    NSDictionary* dict=[SLHelper dictionaryWithJSON:[UserDefaultsUtils valueWithKey:[NSString stringWithFormat:kLocalData4FriendList,AccountUserInfoModel.uid]]];
    if (ValidDict(dict)) {
        [self handleData:dict];
        UITableView* _tableView=[self.parentVC valueForKey:@"_tableView"];
        if (_tableView&&[_tableView isKindOfClass:[UITableView class]]) {
            [_tableView reloadData];
        }
    }
}
- (void)loadData:(SuccessBlock)succ withFail:(FailBlock)fail withCursor:(NSUInteger)cursor withUid:(NSUInteger)uid{
    @weakify_old(self)
    _friendListAction = [SLAttentionListAction action];
    _friendListAction.cursor = [NSString stringWithFormat:@"%ld", (long)_cursor];
    _friendListAction.count = @"500";
    _friendListAction.uid = [NSString stringWithFormat:@"%lu", (unsigned long)_uid];
    _friendListAction.finishedBlock = ^(id result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            @strongify_old(self)
            [weak_self handleData:result];
            NSString *nextCursor = [result valueForKey:@"next_cursor"];
            if ([result objectForKey:@"next_cursor"]
                &&ValidNum([result objectForKey:@"next_cursor"])) {
                strong_self.cursor = [nextCursor integerValue];
            }
            if (succ) {
                succ(-1==weak_self.cursor);
            }
        }
    };
    _friendListAction.failedBlock = ^(NSError *error) {
        if (fail) {
            fail(error.userInfo[@"msg"]);
        }
    };
    [_friendListAction start];
}

- (void)refreshData:(SuccessBlock)succ withFail:(FailBlock)fail{
    self.cursor=0;
    [self loadData:succ withFail:fail withCursor:self.cursor withUid:self.uid];
}

- (void)loadMoreData:(SuccessBlock)succ withFail:(FailBlock)fail{
    [self loadData:succ withFail:fail withCursor:self.cursor withUid:self.uid];
}

@end
