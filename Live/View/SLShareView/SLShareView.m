//
//  SLShareView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//


#import "SLShareView.h"
#import "SLShareViewCollectionViewCell.h"
#import "SLShareCollectionReusableView.h"

@interface SLShareView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * dataArray;
@end
@implementation SLShareView

- (void)dealloc
{
    NSLog(@"[gx] dealloc shareview");
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
    self.dataArray = @[@{@"image":@"share_timeline",@"title":@"朋友圈"},@{@"image":@"share_wechat",@"title":@"微信"},@{@"image":@"share_qq",@"title":@"QQ"},@{@"image":@"share_qzone",@"title":@"QQ空间"},@{@"image":@"share_weibo",@"title":@"微博"},@{@"image":@"share_copy",@"title":@"复制链接"}];
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
        SLShareCollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SLShareCollectionReusableView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[SLShareCollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 42)];
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
    
    
    SLShareViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLShareViewCollectionViewCell" forIndexPath:indexPath];

    cell.dict = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

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
        
        CGFloat height = 236+KTabbarSafeBottomMargin;
        CGRect rect = CGRectMake(0, 0,KScreenWidth,height);
        _collectionView =[[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SLShareViewCollectionViewCell class] forCellWithReuseIdentifier:@"SLShareViewCollectionViewCell"];
        [_collectionView registerClass:[SLShareCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SLShareCollectionReusableView"];
   
        
        
    }
    return _collectionView;
}


@end
