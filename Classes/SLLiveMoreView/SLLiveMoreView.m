
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
#import "SLPushManager+Carema.h"
#import "SLPushManager+Publisher.h"
@interface SLLiveMoreView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIButton * closeButton;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * dataArray;
@property (nonatomic, assign) BOOL isSelect;

@property(nonatomic,assign)BOOL frontDevice;
@property(nonatomic,assign)BOOL lightOpen;
@property(nonatomic,assign)BOOL mute;


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

    self.frontDevice = [self caremaFront];
    self.lightOpen = NO;

    

}

-(void)hide
{
    [super hide];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

// 初始化子视图
- (void)initView
{
    _mute = NO;
    [super initView];
    [self addEffect:UIBlurEffectStyleDark];
    [self addSubview:self.collectionView];
    [self addSubview:self.closeButton];

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
    
    self.dataArray = @[@{@"image":@"live_more_message",@"title":@"私信"},@{@"image":@"live_more_carema",@"title":@"反转"},[self getThirdDict],[self getMuteDict]];
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

-(void)moreViewClose
{
    NSLog(@"[gx] more view close ");
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上左下右
    CGFloat spacing = (kScreenWidth-50*4)/5;
    return UIEdgeInsetsMake(16,spacing,13,spacing);
    
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
                
                [self hide];
              
                if (self.protocol) {
                    [self.protocol moreViewClickMessage];
                }
            }
                break;
            case 1:
            {
                self.frontDevice = !self.frontDevice;
                [self updateFrontDevice:self.frontDevice];
                [[SLPushManager shareInstance] switchCamera];

            }
            break;
            case 2:
            {
                if (self.frontDevice==NO) {
                    self.lightOpen = !self.lightOpen;
                    [self updateLightOpen:self.lightOpen];
                    [[SLPushManager shareInstance] light];
              
                }else
                {
                     [[SLPushManager shareInstance] mirror];
                }
                
            }
            break;
                case 3:
            {
                
                [self streamrMute];
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

-(void)streamrMute
{
    self.mute = !self.mute;
    [[SLPushManager shareInstance] setMute:_mute];
    [self updateData];
    
}

-(void)updateLightOpen:(BOOL)lightOpen
{
    [self updateData];
}


-(void)updateFrontDevice:(BOOL)frontDevice
{
    if (self.lightOpen==YES&&frontDevice==YES) {
        [[SLPushManager shareInstance] light];
    }

    [self updateData];
}

-(void)updateData
{
    self.dataArray = @[@{@"image":@"live_more_message",@"title":@"私信"},@{@"image":@"live_more_carema",@"title":@"反转"},[self updateThirdDict:self.frontDevice],[self getMuteDict]];
    [self.collectionView reloadData];
}


#pragma mark - Getters and Setters

-(UIButton*)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(KScreenWidth-42, 0, 42, 42);
        [_closeButton setImage:[UIImage imageNamed:@"live_more_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        //普通集合视图布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat spacing = (kScreenWidth-50*4)/5;
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
        _collectionView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];

        [_collectionView registerClass:[SLMoreCollectionViewCell class] forCellWithReuseIdentifier:@"SLMoreCollectionViewCell"];
        [_collectionView registerClass:[SLMoreCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SLMoreCollectionReusableView"];

    }
    return _collectionView;
}

-(NSDictionary*)getMuteDict
{
    return (self.mute==NO)?@{@"image":@"live_more_mute",@"title":@"静音开"}:@{@"image":@"live_more_unmute",@"title":@"静音关"};
}

-(NSDictionary*)updateThirdDict:(BOOL)front
{
     return (front)?@{@"image":@"live_more_mirror",@"title":@"镜像"}:[self lightDict:self.lightOpen];
}

-(NSDictionary*)getThirdDict
{
    return ([self caremaFront])?@{@"image":@"live_more_mirror",@"title":@"镜像"}:[self lightDict:self.lightOpen];
}

-(NSDictionary*)lightDict:(BOOL)open
{
    return (open==YES)?@{@"image":@"live_light_close",@"title":@"闪光灯关"}:@{@"image":@"live_light_open",@"title":@"闪光灯开"};
}


-(BOOL)caremaFront
{
    return [SLPushManager shareInstance].currentCameraDevcie==[SLPushManager shareInstance].frontCameraDevcie;
}


@end
