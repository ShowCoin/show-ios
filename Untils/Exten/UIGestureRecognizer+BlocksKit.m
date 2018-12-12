//
//  UIGestureRecognizer+BlocksKit.m
//  BlocksKit
//

#import <objc/runtime.h>
#import "UIGestureRecognizer+BlocksKit.h"

static const void *BKGestureRecognizerBlockKey = &BKGestureRecognizerBlockKey;
static const void *BKGestureRecognizerDelayKey = &BKGestureRecognizerDelayKey;
static const void *BKGestureRecognizerShouldHandleActionKey = &BKGestureRecognizerShouldHandleActionKey;

@interface UIGestureRecognizer (BlocksKitInternal)

@property (nonatomic, setter = bk_setShouldHandleAction:) BOOL bk_shouldHandleAction;

- (void)bk_handleAction:(UIGestureRecognizer *)recognizer;

@end

@implementation UIGestureRecognizer (BlocksKit)

+ (id)bk_recognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block delay:(NSTimeInterval)delay
{
	return [[[self class] alloc] bk_initWithHandler:block delay:delay];
}



@end
