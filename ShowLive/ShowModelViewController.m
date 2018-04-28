//
//  ShowModelViewController.m
//  ShowLive
//
//  Created by Mac on 2018/4/5.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowModelViewController.h"
//#import "AsyncOperation.h"
@interface ShowModelViewController ()
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, copy) void (^viewControllerReady)(void);

@end

@implementation ShowModelViewController

static NSMutableArray<ShowModelViewController*> *ModalViewControllers = nil;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ModalViewControllers = [NSMutableArray arrayWithCapacity:1];
    });
}

+ (ShowModelViewController*)presentViewController: (UIViewController*)viewController animated: (BOOL)animated completion: (void (^)(void))completion {
    ShowModelViewController *presentingViewController = [[ShowModelViewController alloc] initWithNibName:nil bundle:nil];
    
    // Set this up before making the window visible
    __weak ShowModelViewController *weakPresentingViewController = presentingViewController;
    presentingViewController.viewControllerReady = ^() {
        [weakPresentingViewController presentViewController:viewController animated:animated completion:completion];
    };
    
    // Create our temporary window for this modal view controller
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = presentingViewController;
    window.windowLevel = 1.1;
    [window makeKeyAndVisible];
    
    // Retain the window so it doesn't die
    presentingViewController.window = window;
    
    // Track this modal view controller for dismissAll
    [ModalViewControllers addObject:presentingViewController];
    
    return presentingViewController;
}

+ (void)dismissAll {
    [self dismissAllCompletionCallback:nil];
}

+ (void)dismissAllCompletionCallback:(void (^)(void))completionCallback {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
//    while ([ModalViewControllers count]) {
//        AsyncOperation *asyncOperation = [AsyncOperation asyncOperationWithSetup:^(AsyncOperation *asyncOperation) {}];
//        [operationQueue addOperation:asyncOperation];
//
//        [[ModalViewControllers lastObject] dismissViewControllerAnimated:YES completion:^() {
//            [asyncOperation done:nil];
//        }];
//    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
        [operationQueue waitUntilAllOperationsAreFinished];
        if (completionCallback) {
            dispatch_async(dispatch_get_main_queue(), ^() {
                completionCallback();
            });
        }
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_viewControllerReady) {
        _viewControllerReady();
        _viewControllerReady = nil;
    }
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [ModalViewControllers removeObject:self];
    
    __weak ShowModelViewController *weakSelf = self;
    void (^completionCallback)(void) = ^() {
        
        // Release our hold on the window so it can die in peace
        weakSelf.window = nil;
        
        if (completion) { completion(); }
    };
    
    // If we still have a presented view controller, dismiss it first (some things
    // like the UIActivityViewControll remove themselves for us).
    if (self.presentedViewController) {
        [super dismissViewControllerAnimated:flag completion:completionCallback];
        
    } else {
        completionCallback();
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
