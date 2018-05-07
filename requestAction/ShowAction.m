//
//  ShowAction.m
//  ShowLive
//
//  Created by iori_chou on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAction.h"

@implementation ShowAction
{
    BOOL _finished;
}

/**
 * 开始
 */
- (void)start {
    @weakify(self);
    [ShowRequest requestWithData:MainURL requestData:[self requestData] succeed:^(ShowRequest *request, id responseObject) {
       @strongify(self);
        [self parseModel:responseObject];
    } failed:^(ShowRequest *request, NSError *error) {
        @strongify(self);
        [self throwError:error];
    } cancelled:^(ShowRequest *request) {
       @strongify(self);
        [self  throwCancel];
    }];
}
-(ShowRequestData *)requestData{
    ShowRequestData *rd = [[ShowRequestData alloc] init];
    rd.interface = [self interface];
    [rd appendPostDictionary:self.mj_keyValues ignoreArray:[self ignoreArray]];
    return rd ;
}
//不写入请求的属性
- (NSArray *)ignoreArray{
    return @[@"modelClass",@"model",@"finishedBlock",@"failedBlock",@"cancelledBlock"];
}

- (NSString *)interface{
    return @"";
}
/**
 * 取消
 */
- (void)cancel {
    [self throwCancel];
}

+ (instancetype)action {
    id obj = [[self alloc] init];
    return obj;
}

- (void)throwResult:(id)result {
    @synchronized (self) {
        if (_finished) {
            return;
        }
        _finished = YES;
        @weakify(self);
        dispatch_block_t block = ^{
            @strongify(self);
            if (self.finishedBlock) {
                self.finishedBlock(result);
            }
        };
        dispatch_main_sync_safe(block);
    }
}
- (void)parseModel:(NSDictionary *)respDic{
    
    
    if(!respDic || !_modelClass){
        [self throwResult:respDic];
    }

    if([respDic isKindOfClass:[NSString class]]){
        respDic = [(NSString *)respDic mj_JSONObject];
    }
    if([respDic isKindOfClass:[NSDictionary class]]){
        NSError* err = nil;
        self.model = [[self.modelClass alloc]initWithDictionary:respDic error:&err];
        if(err){
            [self throwResult:respDic];
        }else{
            [self throwResult:self.model];
        }
    }else{
        [self throwResult:respDic];
    }
}

- (void)throwError:(NSError *)error {
    @synchronized (self) {
        if (_finished) {
            return;
        }
        _finished = YES;
        @weakify(self);
        dispatch_block_t block = ^{
            @strongify(self);
            if (self.failedBlock) {
                self.failedBlock(error);
            }
        };
        dispatch_main_sync_safe(block);
    }
}

- (void)throwCancel {
    @synchronized (self) {
        if (_finished) {
            return;
        }
        _finished = YES;
        @weakify(self);
        dispatch_block_t block = ^{
            @strongify(self);
            if (self.cancelledBlock) {
                self.cancelledBlock();
            }
        };
        dispatch_main_sync_safe(block);
    }
}
- (void)startRequestSucess:(ShowActionFinishedBlock)sucess FaildBlock:(ShowActionFailedBlock)faild cancellBlock:(ShowActionCancelledBlock)cancelled{
    self.failedBlock = faild ;
    self.finishedBlock = sucess ;
    self. cancelledBlock =  cancelled;
    [self start];
}

- (void)startRequestSucess:(ShowActionFinishedBlock)sucess FaildBlock:(ShowActionFailedBlock)faild{
    [self startRequestSucess:sucess FaildBlock:faild cancellBlock:nil];
}

-(void)dealloc{
       NSLog(@"---%s---",__func__);
}
@end
