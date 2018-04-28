//
//  UIViewController+TrackLoadLog.m
//  ShowLive
//
//  Created by BigHao on 2017/8/26.
//  Copyright © 2017年 show. All rights reserved.
//

#import "UIViewController+TrackLoadLog.h"

#if DEBUG
void NSILog(NSString *format, ...) {
    if (format == nil) {
        printf("nil\n");
        return;
    }
    va_list argList;
    va_start(argList, format);
    NSString *s = [[NSString alloc] initWithFormat:format arguments:argList];
    printf("%s\n", [[s stringByReplacingOccurrencesOfString:@"%%" withString:@"%%%%"] UTF8String]);
    va_end(argList);
}
#endif

#if DEBUG

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu-zero-variadic-macro-arguments"

#define SLog(fmt, ...) NSILog(fmt, ##__VA_ARGS__);
#define LLog(fmt, ...) NSILog((@"[Line: %d] %s: " fmt), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__);
#pragma clang diagnostic pop

#else

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu-zero-variadic-macro-arguments"

#define SLog(fmt, ...)
#define LLog(fmt, ...)
#pragma clang diagnostic pop

#endif


#if DEBUG

#import <objc/runtime.h>

#pragma mark - Dealloc watcher

const char kViewControllerWatcherKey;

@interface ViewControllerWatcher : NSObject
@property (nonatomic, copy, readonly) NSString *classString;
+ (instancetype)viewControllerWatcherWithClassString:(NSString *)classString;
@end

@implementation ViewControllerWatcher

#pragma mark - Dealloc watcher

+ (instancetype)viewControllerWatcherWithClassString:(NSString *)classString {
    return [[ViewControllerWatcher alloc] initWithClassString:classString];
}

- (id)initWithClassString:(NSString *)classString {
    self = [super init];
    if (!self) {
        return nil;
    }
    _classString = classString;
    
    return self;
}

- (void)dealloc {
    if ([_classString isEqualToString:@"UICompatibilityInputViewController"]
        || [_classString isEqualToString:@"_UIRemoteInputViewController"]
        || [_classString isEqualToString:@"UIInputWindowController"]) {
        return;
    }
    SLog(@"\n-> %@ : dealloc\n", _classString);
}

@end

@implementation UIViewController (TrackLoadLog)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzleMethod(class, @selector(viewDidLoad), @selector(nsi_viewDidLoad));
        swizzleMethod(class, @selector(viewDidAppear:), @selector(nsi_viewDidAppear:));
//        swizzleMethod(class, @selector(viewDidDisappear:), @selector(nsi_viewDidDisappear:));
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - Method Swizzling Life Cycle

//- (void)nsi_loadView {
//    SLog(@"%@ loadView", NSStringFromClass([self class]));
//    [self nsi_loadView];
//}
//
- (void)nsi_viewDidLoad {
    //    SLog(@"%@ viewDidLoad", NSStringFromClass([self class]));
    ViewControllerWatcher *watcher = [ViewControllerWatcher viewControllerWatcherWithClassString:NSStringFromClass([self class])];
    objc_setAssociatedObject(self, &kViewControllerWatcherKey, watcher, OBJC_ASSOCIATION_RETAIN);
    [self nsi_viewDidLoad];
}
//
//- (void)nsi_viewWillAppear:(BOOL)animated {
//    SLog(@"%@ viewWillAppear:%@", NSStringFromClass([self class]), animated ? @"YES":@"NO");
//    [self nsi_viewWillAppear:animated];
//}

- (void)nsi_viewDidAppear:(BOOL)animated {
    //    SLog(@"%@: viewDidAppear", NSStringFromClass([self class]));
    [self nsi_viewDidAppear:animated];
    [self logHierarchy];
}

//- (void)nsi_viewWillDisappear:(BOOL)animated {
//    SLog(@"%@ viewWillDisappear:%@", NSStringFromClass([self class]), animated ? @"YES":@"NO");
//    [self nsi_viewWillDisappear:animated];
//}

//- (void)nsi_viewDidDisappear:(BOOL)animated {
//    //    SLog(@"%@: viewDidDisappear", NSStringFromClass([self class]));
//    [self nsi_viewDidDisappear:animated];
//}

#pragma mark - Hierarchy

- (void)logHierarchy {
    NSString *viewControllerPath;
    if ([self parentViewController] == nil) {
        viewControllerPath = NSStringFromClass([self class]);
    }
    else if ([[self parentViewController] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *parentViewController = (UINavigationController *)[self parentViewController];
        viewControllerPath = NSStringFromClass([parentViewController class]);
        for (NSUInteger i = 0; i < parentViewController.viewControllers.count; i++) {
            viewControllerPath = [viewControllerPath stringByAppendingFormat:@"\n%@-> ", [self logWithLevel:i]];
            viewControllerPath = [viewControllerPath stringByAppendingString:NSStringFromClass([parentViewController.viewControllers[i] class])];
        }
    }
    else if ([[self parentViewController] isKindOfClass:[UITabBarController class]]) {
        viewControllerPath = NSStringFromClass([[self parentViewController] class]);
        viewControllerPath = [viewControllerPath stringByAppendingString:@"\n -> "];
        viewControllerPath = [viewControllerPath stringByAppendingString:NSStringFromClass([self class])];
    }
    else {
        viewControllerPath = NSStringFromClass([self class]);
    }
    if ([viewControllerPath isEqualToString:@"UICompatibilityInputViewController"]
        || [viewControllerPath isEqualToString:@"_UIRemoteInputViewController"]
        || [viewControllerPath isEqualToString:@"UIInputWindowController"]) {
        return;
    }
    
    SLog(@"\n-> %@\n", viewControllerPath);
}

- (NSString *)logWithLevel:(NSUInteger)level
{
    NSString *paddingItems = @"";
    for (NSUInteger i = 0; i<=level; i++)
    {
        paddingItems = [paddingItems stringByAppendingFormat:@"-"];
    }
    return paddingItems;
}

@end

#endif

