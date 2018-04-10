/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
 */

#import "AsyncOperation.h"

@interface AsyncOperation () {
    BOOL _isFinished, _isExecuting;
    NSObject *_result;
    
    void (^_setupCallback)(AsyncOperation*);
}

@end

@implementation AsyncOperation

- (instancetype)initWithSetup:(void (^)(AsyncOperation *))setupCallback {
    self = [super init];
    if (self) {
        _setupCallback = setupCallback;
    }
    return self;
}

+ (instancetype)asyncOperationWithSetup:(void (^)(AsyncOperation *))setupCallback {
    return [[AsyncOperation alloc] initWithSetup:setupCallback];
}

- (void)done:(NSObject *)result {
    @synchronized (self) {
        _result = result;
    }
    [self finish];
}

- (NSObject*)result {
    @synchronized (self) {
        return _result;
    }
}

- (void)start {
    
    if ([self isCancelled]) {
        [self finish];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];

    if (_setupCallback) {
        _setupCallback(self);
    }
    
}

-(void)finish {
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _isExecuting = NO;
    _isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return _isExecuting;
}

- (BOOL)isFinished {
    return _isFinished;
}

@end
