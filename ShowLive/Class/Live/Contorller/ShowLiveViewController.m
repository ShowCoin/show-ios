//
//  ShowLiveViewController.m
//  ShowLive
//
//  Created by Mac on 2018/4/7.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowLiveViewController.h"

@interface ShowLiveViewController ()

@end

@implementation ShowLiveViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationBarView setNavigationBarHidden:YES animted:NO] ;
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
