/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/

// @TODO: Should anything (i.e. Modal) using this be moved to Promise?

#import <Foundation/Foundation.h>

@interface AsyncOperation : NSOperation

+ (instancetype)asyncOperationWithSetup: (void (^)(AsyncOperation*))setupCallback;

@property (nonatomic, readonly) NSObject *result;

// The asynchronous task must call this when it completed
- (void)done: (NSObject*)result;

@end
