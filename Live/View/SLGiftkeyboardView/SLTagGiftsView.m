//
//  SLTagGiftsView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLTagGiftsView.h"
#import "SLGiftButtonView.h"
#import "SLGiftListManager.h"
@interface SLTagGiftsView ()<UIScrollViewDelegate,SLGiftButtonViewDelegeate>
{
    //礼物列表列数
    int verCount;
    //礼物列表行数
    int horCount;
    //礼物页数
    int page;
}

/**
 礼物list */
@property (nonatomic, strong) NSMutableArray *giftListArray;

/**
 礼物列表可滚动视图*/
@property (nonatomic, strong) UIScrollView *giftsScrollView;

/**
 页码标示*/
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong)SLGiftButtonView*defaultButton;

@property (nonatomic, copy) NSString *dataTagKey;


@end
@implementation SLTagGiftsView

- (void)dealloc{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"[gx] SLTagGifts dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) {
        
        [self initDataWithTagKey:@"normal"];
        [self creatSubVeiws];
        [self addNoti];
    }
    return self;
}

- (void)refreshUI:(SLGiftListModel *)model {
    
    [self removeSubviews];
    
    if ([_giftListArray containsObject:model]) {
        
        [_giftListArray removeObject:model];
    }
    
    [self creatSubVeiws];
    
}

- (void)addNoti{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setDefaultGiftBtn)
                                                 name:SLSetDefaultGiftbutton object:nil];
}


- (void)setDefaultGiftBtn{
    
    [self selectedGift:_defaultButton];
}

- (void)initDataWithTagKey:(NSString *)key
{
    verCount = 2;
    horCount = 4;

    _giftListArray = [SLGiftListManager shareInstance].giftList;
    page = (int)ceilf(_giftListArray.count / 8.0);
    
}

- (void)creatSubVeiws
{
    [self creatScrollView];
    [self creatPageControl];
    [self creatGiftBtns];

    
}

- (void)creatScrollView
{
    float giftScrollViewHeight = 164;
    
    _giftsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                                      self.bounds.size.width,
                                                                      giftScrollViewHeight)];
    
    _giftsScrollView.pagingEnabled = YES;
    _giftsScrollView.delegate      = self;
    _giftsScrollView.contentSize   = CGSizeMake(kScreenWidth * page, _giftsScrollView.height);
    _giftsScrollView.showsHorizontalScrollIndicator = NO;
    _giftsScrollView.bounces         = NO;
    _giftsScrollView.backgroundColor = [UIColor clearColor];
    _giftsScrollView.pagingEnabled   = YES;
    
    [self addSubview:_giftsScrollView];
    
}

- (void)creatPageControl
{
    __weak SLTagGiftsView *weakSelf = self;
    // 页码指示器
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages            = page;
    _pageControl.currentPage              = 0;
    _pageControl.autoresizesSubviews      = NO;
    [_pageControl sizeThatFits:CGSizeMake(kScreenWidth, 4)];
    _pageControl.transform                = CGAffineTransformMakeScale(0.9, 0.9);
    _pageControl.hidesForSinglePage       = YES;
    _pageControl.currentPageIndicatorTintColor = WhiteColor;
    _pageControl.pageIndicatorTintColor   = [WhiteColor colorWithAlphaComponent:0.3];
    _pageControl.userInteractionEnabled   = NO;
    
    [self addSubview:_pageControl];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.size.mas_equalTo(CGSizeMake(weakSelf.width, 4));
        
        make.left.mas_equalTo(0);
        
        make.top.mas_equalTo(174);
        
    }];
}

#pragma mark 逐个添加具体的礼物

- (void)creatGiftBtns
{
    float buttomWidth   = 76;
    float buttomHeight  = 76;
    
    float verSpace = _giftsScrollView.height - 6 - 76*verCount;
    float horSpace = (self.width - 22 - 76*horCount)/3;
    
    // 遍历礼物列表
    NSEnumerator *giftListArrayenumerator = [_giftListArray objectEnumerator];
    
    
    for (int i = 0; i < page; i++ )
    { // 共几页
        for (int j = 0; j < verCount; j++)
        { //一页两行
            for (int k = 0; k < horCount; k++)
            { //一行四个
                
                @autoreleasepool
                {
                    
                    SLGiftListModel *giftModel = [giftListArrayenumerator nextObject];
                    
                    SLGiftButtonView *bt = [[SLGiftButtonView alloc] initWithFrame:CGRectMake(11 + (buttomWidth + horSpace) * k + i * _giftsScrollView.width,
                                                                                              3 + (buttomHeight + verSpace) * j,
                                                                                              buttomWidth,
                                                                                              buttomHeight)
                                                                         infoModel:giftModel];
                    
                    bt.delegate = self;
                    bt.tag =  giftModel.id;
                    if (i == 0 && j == 0 && k == 2) {
                        
                        _defaultButton = bt;
                    }
                    
                    [_giftsScrollView addSubview:bt];
                }
                
            }
        }
    }
}



- (void)removeSubviews {
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
}

#pragma mark -- giftViewDelegate

- (void)selectedGift:(SLGiftButtonView*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedGift:)])
    {
        [self.delegate selectedGift:sender];
    }
}

#pragma mark -- scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _giftsScrollView.contentOffset.x / (kScreenWidth);
}


@end
