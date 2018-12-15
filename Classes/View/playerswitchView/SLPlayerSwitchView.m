//
//  SLPlayerSwitchView.m
//  ShowLive
//
//  Created by show gx on 2018/5/1.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPlayerSwitchView.h"
#import "NSMutableArray+SwitchRoom.h"
#import "SLLiveListModel.h"
//static CGFloat panBeginX = 0.0;//向下拖拽手势开始时的X，在拖拽开始时赋值，拖拽结束且没有退回页面时置0
//static CGFloat panBeginY = 0.0;//向下拖拽手势开始时的Y，在拖拽开始时赋值，拖拽结束且没有退回页面时置0

@interface SLPlayerSwitchView()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,assign)NSInteger    index;

@property(nonatomic,strong)NSMutableArray * switchArray;

@property(nonatomic,strong)NSMutableArray * subViewsArray;

@property(nonatomic,strong)UIPanGestureRecognizer *pan;

@property(nonatomic,strong)UIView     *showView;

@property (nonatomic,assign) BOOL doingPan;//正在拖拽

@property (nonatomic,assign) BOOL doingZoom;//正在缩放，此时不执行拖拽方法

@end

@implementation SLPlayerSwitchView

- (instancetype)initWithSwitchArray:(NSMutableArray*)switchArray
{
    self = [super init];
    
    if (self) {
        
        self.switchArray = switchArray;
      
    }
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (self.protocol&&[self.protocol respondsToSelector:@selector(touchBegin)]) {
        [self.protocol touchBegin];
    }
  
}
-(void)switchRoom
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    SLLiveListModel * listModel = self.switchArray[self.index];
    if (self.protocol&&[self.protocol respondsToSelector:@selector(switchRoom:liveModel:)]) {
        [self.protocol switchRoom:[NSMutableArray subArray:self.switchArray index:self.index] liveModel:listModel];
    }
}
-(void)addSubViews
{
    
    // scroollview 添加三个子视图
    for (NSInteger i = 0; i < 3; i ++ ){
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        CGFloat imageY = KScreenHeight*i;
        imageView.frame = CGRectMake(0, imageY,KScreenWidth, KScreenHeight);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setClipsToBounds:YES];
        imageView.backgroundColor = [UIColor clearColor];
        [self.subViewsArray addObject:imageView];
    }
    self.contentSize = CGSizeMake(0, KScreenHeight * 3);
    self.contentOffset = CGPointMake(0,KScreenHeight);
    
    [self setUpImageWith:self.index showCenterImage:YES];
}

-(void)setUpImageWith:(NSInteger )index showCenterImage:(BOOL)show
{
    for (NSInteger i = 0; i < self.subViewsArray.count; i ++) {
        
        UIImageView *imageView = self.subViewsArray[i];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setClipsToBounds:YES];
  
        NSInteger currentIndex;
        if (i==0) {
            currentIndex = index==0 ? self.switchArray.count-1 : index -1;
        }else if (i==1){
            currentIndex = index;
        }else{
            currentIndex = index==self.switchArray.count-1 ? 0 : index + 1;
        }
        
        //获取model
        SLLiveListModel *model = self.switchArray[currentIndex];
        NSURL * imageUrl = [NSURL URLWithString:model.cover];
        
        //切屏之后不重新加载showView的图片
        if (show || i != 1) {
            [imageView sd_setImageWithURL:imageUrl];
        }
        
       
    }
    
    //主需要将播放视图展示在i==1的界面即可
    self.currentView = self.subViewsArray[1];
    [self.currentView addGestureRecognizer:self.pan];
    
}

//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    NSLog(@" %f",scrollView.contentOffset.y);
}

#pragma mark UIScrollViewDelegate 此处解决了scrollerview的循环引用

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self performSelector:@selector(switchRoom) withObject:nil afterDelay:0.15];
    
    NSInteger index  = scrollView.contentOffset.y / KScreenHeight;
    
    if (index==1) return;
    
    for (NSInteger i = 0; i < self.subViewsArray.count; i ++ ) {
        UIView *subView = self.subViewsArray[i];
        if (index == i) {
            self.showView = subView;
            continue;
        }
        [subView removeFromSuperview];
    }
    [self.subViewsArray removeAllObjects];
    
    self.index = scrollView.contentOffset.y/KScreenHeight <1 ? --self.index :++self.index;
    if (self.index<0) {
        self.index = self.switchArray.count - 1;
    }else if (self.index>=self.switchArray.count){
        self.index = 0;
    }
    
    for (NSInteger i = 0; i < 3; i ++ ) {
        if (i == 1) {
            self.showView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight);
            [self.subViewsArray addObject:self.showView];
        }else{
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            CGFloat imageY = KScreenHeight*i;
            imageView.frame = CGRectMake(0, imageY,KScreenWidth , KScreenHeight);
            [imageView setClipsToBounds:YES];
            [scrollView addSubview:imageView];
            imageView.backgroundColor = [UIColor clearColor];
            [self.subViewsArray addObject:imageView];
        }
    }
    
    scrollView.contentOffset = CGPointMake(0, KScreenHeight);
    
    //重新添加控件
    [self setUpImageWith:self.index showCenterImage:NO];
    
    
    if (self.protocol&&[self.protocol respondsToSelector:@selector(turnPage)]) {
        
        [self.protocol turnPage];
    }
    
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{

    NSLog(@" %@",[touch.view  class]);
    NSArray * array = @[@"UITableViewCellContentView",@"UITableView",@"YYLabel",@"UIButton"];
    NSString * touchStr = NSStringFromClass([touch.view class]);

    if ([array containsObject:touchStr])
    {
        self.scrollEnabled = NO;
        return NO;
    }
    self.scrollEnabled = YES;
    return  YES;
}

/** 核心方法：拖拽开始 */
- (void)panAction:(UIPanGestureRecognizer*)panGesture {
   //  NSLog(@" pan");
}
-(UIPanGestureRecognizer*)pan
{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        _pan.delegate = self;
    }
    return _pan;
}

-(NSMutableArray*)subViewsArray
{
    if (!_subViewsArray) {
        _subViewsArray = [NSMutableArray array];
    }
    return _subViewsArray;
}


@end
