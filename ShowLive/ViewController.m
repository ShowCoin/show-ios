//
//  ViewController.m
//  ShowLive
//
//  Created by vning on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ViewController.h"
#import "ShowLoginAction.h"

@interface ViewController ()
@property (nonatomic,strong)ShowLoginAction * loginAction;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.loginAction ) {
        [self.loginAction cancel];
        self.loginAction = nil;
    }
    ShowLoginAction *action = [ShowLoginAction action];
    action.phone = @"130000000000";
    action.pwd =@"123456";
    action.finishedBlock = ^(id result) {
        //请求成功
        NSDictionary * response=(NSDictionary *)result;
        if ([response isKindOfClass:[NSDictionary class]])
        {
            //model转换或其他处理
        }
    };
    action.failedBlock = ^(NSError *error) {
    };
    [action start];
    self.loginAction = action;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
