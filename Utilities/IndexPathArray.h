/**
 *  MIT License
 *
 *  Copyright (c) 2017 Richard Moore <me@ricmoo.com>
 *
**/

#import <UIKit/UIKit.h>

@interface IndexPathArray : NSObject

- (void)moveObjectAtIndexPath: (NSIndexPath*)fromIndexPath toIndexPath: (NSIndexPath*)toIndexPath;
- (void)deleteObjectAtIndexPath:(NSIndexPath*)indexPath;
- (void)insert: (NSObject*)object atIndexPath:(NSIndexPath*)indexPath;

- (NSIndexPath*)indexPathOfObject: (NSObject*)object;
- (NSObject*)objectAtIndexPath: (NSIndexPath*)indexPath;

@end
