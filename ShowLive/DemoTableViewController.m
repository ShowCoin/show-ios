//
//  DemoTableViewController.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "DemoTableViewController.h"
#import "ShowLoginAction.h"
@interface DemoTableViewController ()

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, self.navigationBarView.height, kScreenWidth, kScreenHeight-self.navigationBarView.height);
    [self.navigationBarView setNavigationTitle:@"示例的页面"];
    [self.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftNone];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.dataSource = @[@[@1,@2,@3,@4,@5]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldPullToRefresh{
    return YES ;
}
- (BOOL)shouldInfiniteScrolling{
    return YES ;
}

- (ShowAction *)requestaction{
    return [ShowLoginAction action];
}

-(UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    cell.textLabel.text = [NSString stringWithFormat:@"%@",object];
    
}

- (CGFloat)configureCellHeightWithTableViewCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath withObject:(id)object{return 30.0f;}



- (void)requestWithPage:(NSInteger)page perPage:(NSInteger)perpage paramters:(NSDictionary *)paramters SuccessBlock:(void(^)(BOOL sucess))successBlock FaildBlock:(void(^)(NSError *error))faildBlock{
    NSMutableDictionary *requestParamters = [NSMutableDictionary dictionaryWithCapacity:0];
    [requestParamters addEntriesFromDictionary:paramters];
    [requestParamters setValue:@(self.page) forKey:@"page"];
    [requestParamters setValue:@(self.perpage) forKey:@"perpage"];
    
//    //例子后期改
//    ShowAction *action = [self requestaction];
//    action.finishedBlock = ^(id result) {
//        successBlock(YES);
//        //请求成功
//        NSDictionary * response=(NSDictionary *)result;
//        if ([response isKindOfClass:[NSDictionary class]])
//        {
//            [self parseSucessData:response];
//            //model转换或其他处理
//        }
//    };
//    action.failedBlock = ^(NSError *error) {
//        self.error = error ;
//        faildBlock(error);
//    };
//    [action start];
     successBlock(YES);
     [self parseSucessData:nil];
   // self.error = [NSError errorWithDomain:@"hahah" code:20 userInfo:@{@"message":@"出错了"}];
}


- (void)parseSucessData:(id)data{
    NSArray *array = @[self.dataSource[0],self.dataSource[0]];
    self.dataSource = [NSMutableArray arrayWithArray:array];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
