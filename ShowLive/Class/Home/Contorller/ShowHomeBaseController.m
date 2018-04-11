//
//  ShowHomeBaseController.m
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowHomeBaseController.h"
#import "ShowHomeSamallCell.h"
#import "ShowHomeMiddleCell.h"
#import "ShowHomeLargeCell.h"
#import "NewReusableView.h"

@interface ShowHomeBaseController ()
@property(nonatomic,assign)CGFloat cellWith;
@end

@implementation ShowHomeBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setHidden:YES];
    self.viewTag =  HomeViewType_Hot;
//    self.viewCount = HomeViewLines_Two;
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
    [self.view addSubview:self.mainCollectionView];
}
-(UICollectionView*)mainCollectionView{
    if (!_mainCollectionView) {
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
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight) collectionViewLayout:flowlayout];
        if (@available(iOS 11.0, *)) {
            _mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _mainCollectionView.alwaysBounceHorizontal = NO;
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.scrollEnabled = YES;
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        //        _mainCollectionView.contentInset = UIEdgeInsetsMake(KNaviBarHeight, 0, KTabbarSafeBottomMargin, 0);
        if (_viewCount == HomeViewLines_One) {
            [_mainCollectionView registerClass:[ShowHomeLargeCell class] forCellWithReuseIdentifier:@"ShowHomeLargeCell"];
            _mainCollectionView.pagingEnabled = YES;
        }else if (_viewCount == HomeViewLines_Two){
            [_mainCollectionView registerClass:[ShowHomeMiddleCell class] forCellWithReuseIdentifier:@"ShowHomeMiddleCell"];
//            [_mainCollectionView registerClass:[NewReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

        }else if (_viewCount == HomeViewLines_Three){
            [_mainCollectionView registerClass:[ShowHomeSamallCell class] forCellWithReuseIdentifier:@"ShowHomeSamallCell"];
//            [_mainCollectionView registerClass:[NewReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        }
        
    }
    return _mainCollectionView;
}
#pragma mark - ********************** collectionViewdelegate **********************

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_viewCount == HomeViewLines_One) {
        ShowHomeLargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowHomeLargeCell" forIndexPath:indexPath];
        return cell;
    }else if (_viewCount == HomeViewLines_Two){
        ShowHomeMiddleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowHomeMiddleCell" forIndexPath:indexPath];
        return cell;
    }else if (_viewCount == HomeViewLines_Three){
        ShowHomeSamallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowHomeSamallCell" forIndexPath:indexPath];
        return cell;
    }
    ShowHomeLargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowHomeLargeCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
  
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
