//
//  ShowHomeBaseController.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeBaseController.h"
#import "NewReusableView.h"
#import "ShowAction.h"

#import "SLHomeHotViewAction.h"
#import "SLShowConcernAction.h"
#import "SLLiveListModel.h"


@interface ShowHomeBaseController ()
@property(nonatomic,assign)CGFloat cellWith;
@property(nonatomic,assign)NSInteger indexRow;

@end

@implementation ShowHomeBaseController
@dynamic mainCollectionView;

- (instancetype)initWithViewCount:(HomeViewLines)viewCount homeViewType:(HomeViewType)homeViewType{
    if(self = [super init]){
        self.viewCount = viewCount ;
        self.viewTag = homeViewType ;
        self.indexRow = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setHidden:YES];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    
}

-(void)loadView{
    [super loadView];
    UICollectionViewFlowLayout *flowlayout;
    flowlayout = [[UICollectionViewFlowLayout alloc] init];
    if (_viewCount == HomeViewLines_One) {
        flowlayout.itemSize = CGSizeMake(kMainScreenWidth, kMainScreenHeight);
        flowlayout.minimumLineSpacing = 0;
    }else if (_viewCount == HomeViewLines_Two){
        flowlayout.itemSize = CGSizeMake(_cellWith, _cellWith /10 * 16);
        flowlayout.minimumLineSpacing = 1*Proportion375;
    }else if (_viewCount == HomeViewLines_Three){
        flowlayout.itemSize = CGSizeMake(_cellWith, _cellWith /3 * 4);
        flowlayout.minimumLineSpacing = 1*Proportion375;
    }else{
        flowlayout.itemSize = CGSizeMake(0, 0);
        flowlayout.minimumLineSpacing = 0;
    }
    flowlayout.minimumInteritemSpacing = 0;
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight) collectionViewLayout:flowlayout];
    if (@available(iOS 11.0, *)) {
        self.mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.mainCollectionView.alwaysBounceHorizontal = NO;
//    self.mainCollectionView.alwaysBounceVertical = NO;
    self.mainCollectionView.backgroundColor = [UIColor blackColor];
    self.mainCollectionView.scrollEnabled = YES;
    self.mainCollectionView.showsHorizontalScrollIndicator = NO;
    self.mainCollectionView.showsVerticalScrollIndicator = NO;
//                self.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, KTabbarSafeBottomMargin, 0);
    if (_viewCount == HomeViewLines_One) {
        [self.mainCollectionView registerClass:[ShowHomeLargeCell class] forCellWithReuseIdentifier:@"ShowHomeLargeCell"];
        self.mainCollectionView.pagingEnabled = YES;
    }else if (_viewCount == HomeViewLines_Two){
        [self.mainCollectionView registerClass:[ShowHomeMiddleCell class] forCellWithReuseIdentifier:@"ShowHomeMiddleCell"];
        //            [_mainCollectionView registerClass:[NewReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
    }else if (_viewCount == HomeViewLines_Three){
        [self.mainCollectionView registerClass:[ShowHomeSamallCell class] forCellWithReuseIdentifier:@"ShowHomeSamallCell"];
        //            [_mainCollectionView registerClass:[NewReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    [self.view addSubview:self.mainCollectionView];

}

-(void)setViewCount:(HomeViewLines)viewCount
{
    _viewCount = viewCount;
    switch (_viewCount) {
        case HomeViewLines_One:
            _cellWith = kMainScreenWidth;
            break;
        case HomeViewLines_Two:
            _cellWith = (kMainScreenWidth -1)/2;
            break;
        case HomeViewLines_Three:
            _cellWith = (kMainScreenWidth -2)/3;
            break;
            
        default:
            break;
    }
    [self Views];
    
}
-(void)Views{
    [self createAction];
}


-(UICollectionView *)createColletionView{
    return  nil ;
}

- (ShowAction *)action {
    return   nil ;
}

#pragma mark - ********************** collectionViewdelegate **********************

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_viewCount == HomeViewLines_One) {
        ShowHomeLargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowHomeLargeCell" forIndexPath:indexPath];
        cell.dataModel = [self.dataSource objectAtIndex:indexPath.row];
        cell.delegate = self;
        return cell;
    }else if (_viewCount == HomeViewLines_Two){
        ShowHomeMiddleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowHomeMiddleCell" forIndexPath:indexPath];
        cell.dataModel = [self.dataSource objectAtIndex:indexPath.row];
        return cell;
    }else if (_viewCount == HomeViewLines_Three){
        ShowHomeSamallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowHomeSamallCell" forIndexPath:indexPath];
        cell.dataModel = [self.dataSource objectAtIndex:indexPath.row];
        return cell;
    }
    ShowHomeLargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowHomeLargeCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    [PageMgr pushToLiveRoomControllerWithData:[self.dataSource objectAtIndex:indexPath.row]];
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (_viewCount == HomeViewLines_One) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            NewReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"forIndexPath:indexPath];
            return headerView;
            
        }
    }else if (_viewCount == HomeViewLines_Two){
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            NewReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"forIndexPath:indexPath];
            return headerView;
            
        }
    }else if (_viewCount == HomeViewLines_Three){
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            NewReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"forIndexPath:indexPath];
            return headerView;
            
        }
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (_viewCount == HomeViewLines_One) {
        return CGSizeMake(KScreenWidth, 0*Proportion375);

    }else if (_viewCount == HomeViewLines_Two){
        return CGSizeMake(KScreenWidth, 0*Proportion375);

    }else if (_viewCount == HomeViewLines_Three){
        return CGSizeMake(KScreenWidth, 0*Proportion375);

    }
    return CGSizeMake(KScreenWidth, 0);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获取当前显示的cell的下标
    NSIndexPath *firstIndexPath = [[self.mainCollectionView indexPathsForVisibleItems] firstObject];
    // 赋值给记录当前坐标的变量
    self.indexRow = firstIndexPath.row;
    // 更新底部的数据
    // ...
}

#pragma mark - ********************** actions **********************
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)parserModelWithResult:(id)result{
    self.page = [[result objectForKey:@"next_cursor"] integerValue];
    NSMutableArray * dataArr = [[NSMutableArray alloc]init];
    dataArr = [SLLiveListModel mj_objectArrayWithKeyValuesArray:[result objectForKey:@"list"]];
    if (dataArr.count) {
        NSMutableArray * modelArr = [[NSMutableArray alloc]init];
        if (!self.isRefresh) {
            [modelArr addObjectsFromArray:self.dataSource];
        }
        [modelArr addObjectsFromArray:dataArr];
        self.dataSource = modelArr;
        
    }

}

#pragma  子类需要重新定义
- (ShowAction *)createAction {
    if (_viewTag == HomeViewType_New) {
        SLHomeHotViewAction * action = [SLHomeHotViewAction action];
        action.sort = @"create_time";
        action.count = [NSString stringWithFormat:@"%ld",self.perpage];
        action.cursor =[NSString stringWithFormat:@"%ld",self.page];
        return   action ;

    }else if (_viewTag== HomeViewType_Hot){
        SLHomeHotViewAction * action = [SLHomeHotViewAction action];
        action.sort = @"top";
        action.count = [NSString stringWithFormat:@"%ld",self.perpage];
        action.cursor =[NSString stringWithFormat:@"%ld",self.page];
        return   action ;
    }else if (_viewTag == HomeViewType_Concer){
//        SLShowConcernAction * action = [SLShowConcernAction action];
//        action.count = [NSString stringWithFormat:@"%ld",self.perpage];
//        action.cursor =[NSString stringWithFormat:@"%ld",self.page];
//        return   action ;
        SLHomeHotViewAction * action = [SLHomeHotViewAction action];
        action.sort = @"top";
        action.count = [NSString stringWithFormat:@"%ld",self.perpage];
        action.cursor =[NSString stringWithFormat:@"%ld",self.page];
        return   action ;
    }

    return nil;
}

- (UIImage *)emptyDataImage{
    return nil;
}

-(NSString *)emptyDataTitle{
    return @"暂时没有数据";
}

-(NSString *)emptyDataDesc{
    return @"";
}

#pragma mark - ********************** delegates **********************
-(void)LargeCellConcernActionDelegateWithModel:(SLLiveListModel *)model
{
    [self.dataSource replaceObjectAtIndex:self.indexRow withObject:model];
    [self.mainCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.indexRow inSection:0]]];
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
