//
//  SLShareView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLShareView.h"
#import "SLShareViewCollectionViewCell.h"
@interface SLShareView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectionView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end
@implementation SLShareView

- (void)dealloc
{
    NSLog(@"[gx] SLShareViewdealloc");
}
// 初始化子视图
- (void)initView
{
    [super initView];
    [self addSubview:self.collectionView];
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上左下右
    return UIEdgeInsetsMake(16,13,13,16);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SLShareViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLShareViewCollectionViewCell" forIndexPath:indexPath];

    
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
        
        CGFloat height = 184+KTabbarSafeBottomMargin;
        CGRect rect = CGRectMake(0, KScreenHeight- height,KScreenWidth,height);
        _collectionView =[[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[SLShareViewCollectionViewCell class] forCellWithReuseIdentifier:@"SLShareViewCollectionViewCell"];
        
        
    }
    return _collectionView;
}

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
