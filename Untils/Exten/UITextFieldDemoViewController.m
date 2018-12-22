//
//  UITextFieldDemoViewController.m
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/3/29.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UITextFieldDemoViewController.h"
#import "UITextField+JKInputLimit.h"
@interface UITextFieldDemoViewController ()

@end

@implementation UITextFieldDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textField.jk_maxLength =  20;
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
