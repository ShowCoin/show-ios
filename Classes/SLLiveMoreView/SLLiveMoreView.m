
//
//  SLLiveMoreView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveMoreView.h"
#import "SLMoreCollectionViewCell.h"
#import "SLPushManager.h"
#import "SLPushManager+Carema.h"
#import "SLPushManager+Publisher.h"
#import "SLToolView.h"
#import "SLLMFlowLayout.h"

CGFloat const kSLLiveMoreViewH = 100 * 2 + 44;

@interface SLLiveMoreView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

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
    [self initData];
    [self addEffect:UIBlurEffectStyleDark];
    
    SLTitleView *t = [SLTitleView new];
    t.frame = CGRectMake(0, 0, KScreenWidth, kTitleViewH);
    t.titleLabel.text = @"更多";
    [self addSubview:t];
    
    CGRect frame = CGRectMake(0, kTitleViewH, KScreenWidth, kSLLiveMoreViewH);
    // SLLMFlowLayout
    SLLMFlowLayout *layout = [[SLLMFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [_collectionView registerClass:[SLMoreCollectionViewCell class] forCellWithReuseIdentifier:kSLMoreCollectionViewCellID];
    [self addSubview:self.collectionView];
}

-(void)initData
{
    SLLMModel *model1 = [SLLMModel sl_create:SLLMTypeMessage];
    SLLMModel *model2 = [SLLMModel sl_create:SLLMTypeFront];
    SLLMModel *model3 = [SLLMModel sl_create:SLLMTypeMirror];
    SLLMModel *model4 = [SLLMModel sl_create:SLLMTypeMute];
    SLLMModel *model5 = [SLLMModel sl_create:SLLMTypeShoot];
    
    if ([self caremaFront]==NO) {
        model2.select = YES;
        model3.title = @"闪光灯开";
        model3.image = @"live_light_open";
        model3.selectTitle = @"闪光灯关";
        model3.selectImage = @"live_light_close";
        model3.select = NO;
    }
    
    self.dataArray = @[model1, model2, model3, model4, model5];
    [self.collectionView reloadData];
}

-(void)moreViewClose
{
    NSLog(@"[gx] more view close ");
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SLMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSLMoreCollectionViewCellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // just do every click and change image
    SLLMModel *model = self.dataArray[indexPath.row];
    
    if (model.type == SLLMTypeMessage) {
        [self hide];
        if (self.protocol) {
            [self.protocol moreViewClickMessage];
        }
    } else if (model.type == SLLMTypeFront) {

        model.select = !model.select;
        [[SLPushManager shareInstance] switchCamera];
        
        SLLMModel *mModel = self.dataArray[SLLMTypeMirror];
        if (model.select == YES) {
            mModel.title = @"闪光灯开";
            mModel.image = @"live_light_open";
            mModel.selectTitle = @"闪光灯关";
            mModel.selectImage = @"live_light_close";
            mModel.select = NO;
        } else {
            mModel.title = @"镜像";
            mModel.image = @"live_more_mirror";
            mModel.selectTitle = @"";
            mModel.selectImage = @"";
            mModel.select = NO;
        }
        [collectionView reloadData];
        
    } else if (model.type == SLLMTypeMirror) {
        SLLMModel *frontModel = self.dataArray[SLLMTypeFront];
        
        if (frontModel.select == YES) {
            model.select = !model.select;
            [[SLPushManager shareInstance] light];
            [collectionView reloadData];
        } else {
            [[SLPushManager shareInstance] mirror];
        }
        
    } else if (model.type == SLLMTypeMute) {
        model.select = !model.select;
        [[SLPushManager shareInstance] setMute:model.select];
        [collectionView reloadData];
    } else if (model.type == SLLMTypeShoot) {
        [self hide];
        [self.protocol moreViewScreenShoot];
    }
}

- (BOOL)caremaFront
{
    return [SLPushManager shareInstance].currentCameraDevcie==[SLPushManager shareInstance].frontCameraDevcie;
}

@end
