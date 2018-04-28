
//
//  SLLiveMoreView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveMoreView.h"
#import "SLMoreCollectionViewCell.h"
#import "SLMoreCollectionReusableView.h"
#import "SLPushManager.h"
@interface SLLiveMoreView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * dataArray;
@property (nonatomic, assign) BOOL isSelect;

@end
@implementation SLLiveMoreView

- (void)dealloc
{
    NSLog(@"[gx] more view dealloc");
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void)show
{
    [super show];
    self.isSelect = NO;
}

-(void)hide
{
    [super hide];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

// 初始化子视图
- (void)initView
{
    [super initView];
    [self addSubview:self.collectionView];
}

- (void)modalViewDidAppare
{
    [super modalViewDidAppare];
    [self initData];
}

- (void)modalViewWillDisappare
{
    [super modalViewWillDisappare];
    
}

-(void)initData
{
    self.dataArray = @[@{@"image":@"live_more_carema",@"title":@"反转"},@{@"image":@"live_more_mirror",@"title":@"镜像"}];
    [self.collectionView reloadData];
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return (CGSize){kScreenWidth,42};
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        SLMoreCollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SLMoreCollectionReusableView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[SLMoreCollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 42)];
        }
        
        return headerView;
    }
    
    return nil;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上左下右
    return UIEdgeInsetsMake(16,13,13,16);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SLMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLMoreCollectionViewCell" forIndexPath:indexPath];
    
    cell.dict = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (self.isSelect == NO) {
        
        self.isSelect = YES;
        
        //在延时方法中将isSelect更改为false
        [self performSelector:@selector(repeatDelay) withObject:nil afterDelay:0.5f];
        
        switch (indexPath.row) {
            case 0:
            {
                [[SLPushManager shareInstance] switchCamera];
            }
            break;
            case 1:
            {
               
            }
            break;
            default:
            break;
        }
        
        
    }


}

- (void)repeatDelay{
    
    self.isSelect = NO;
    
}


#pragma mark - Getters and Setters

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        
        
        //普通集合视图布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat spacing =  (kScreenWidth-50*5)/6;
        layout.minimumLineSpacing = spacing;
        layout.minimumInteritemSpacing = spacing;
        layout.itemSize = CGSizeMake(50, 70);
        
        CGFloat height = 184+KTabbarSafeBottomMargin;
        CGRect rect = CGRectMake(0, 0,KScreenWidth,height);
        _collectionView =[[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];

        [_collectionView registerClass:[SLMoreCollectionViewCell class] forCellWithReuseIdentifier:@"SLMoreCollectionViewCell"];
        [_collectionView registerClass:[SLMoreCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SLMoreCollectionReusableView"];
        
        
        
    }
    return _collectionView;
}


@end
