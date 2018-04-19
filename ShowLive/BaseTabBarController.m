//
//  BaseTabBarController.m
//  Shell
//
//  Created by sunjiaqi on 16/5/10.
//  Copyright © 2016年 show. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseViewController.h"
#import "UserCenterViewController.h"
#import "ShowHomeViewController.h"
#import "ShowLiveViewController.h"

#define __default_bar_count 3


typedef NS_ENUM(NSInteger,UIBarButtonItemType) {
    UIBarButtonItemType_Text  = 1 ,
    UIBarButtonItemType_Button  = 2,
};
@interface KMBarItem : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *normalImage;
@property (nonatomic,copy) NSString *selectImage;

+(instancetype)item:(NSString *)title normalImage:(NSString *)normalImage selectImage:(NSString *)selectImage;
@end


@implementation KMBarItem

+(instancetype)item:(NSString *)title normalImage:(NSString *)normalImage selectImage:(NSString *)selectImage{
    KMBarItem *item = [[KMBarItem alloc] init];
    item.title = title;
    item.normalImage = normalImage;
    item.selectImage = selectImage;
    return item;
}
@end

@class KMBarItemView;

@protocol KMBarItemViewDelegate <NSObject>
-(void)barItemView:(KMBarItemView *)view didClickBarButton:(KMBarItem *)item;
@end

@interface KMBarItemView : UIButton

@property (nonatomic, weak) id<KMBarItemViewDelegate> delegate;
@property(nonatomic,strong) KMBarItem *item;
@property(nonatomic,strong) UIButton *iconButton;
@property(nonatomic,strong) UILabel * descLabel;
@property(nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,strong)UIButton *centernBtn ;
@property(nonatomic,assign) UIBarButtonItemType type ;
@end

@implementation KMBarItemView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.userInteractionEnabled = YES;
        [self addSubview:self.iconButton];
        [self addSubview:self.descLabel];
        [self addSubview:self.bottomLineView];
        [self addSubview:self.centernBtn];
        self.bottomLineView.backgroundColor=[UIColor clearColor];
        [self addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setType:(UIBarButtonItemType)type{
    if(type == UIBarButtonItemType_Text){
        self.centernBtn.hidden = YES ;
        self.descLabel.hidden = NO ;
        self.bottomLineView.hidden = NO ;
    }else if (type == UIBarButtonItemType_Button){
        self.centernBtn.hidden = NO ;
        self.descLabel.hidden = YES ;
        self.bottomLineView.hidden = YES ;
    }
    _type = type ;
}

-(UIButton *)iconButton{
    if (!_iconButton) {
        UIButton *button = [[UIButton alloc] init];
        button.imageView.clipsToBounds = NO;
        button.userInteractionEnabled = NO;
        _iconButton = button;
    }
    return _iconButton;
}
- (UIButton *)centernBtn{
    if(!_centernBtn){
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"tab_shootting"] forState:UIControlStateNormal];
        button.imageView.clipsToBounds = NO;
        button.userInteractionEnabled = NO;
        [button addShadow];
        _centernBtn = button;
    }
    return _centernBtn ;
}
-(UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = Font_Regular(13);
        [label addShadow];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        _descLabel = label;
    }
    return _descLabel;
}
-(UILabel *)bottomLineView{
    if (!_bottomLineView) {
        UILabel *label = [[UILabel alloc] init];
        _bottomLineView = label;
    }
    return _bottomLineView;
}

-(void)didClickButton{
    if ([self.delegate respondsToSelector:@selector(barItemView:didClickBarButton:)]) {
        [self.delegate barItemView:self didClickBarButton:self.item];
    }
}

-(void)setItem:(KMBarItem *)item
{
    _item = item;
    [self.iconButton setImage:[UIImage imageNamed:self.item.normalImage] forState:UIControlStateNormal];
    [self.iconButton setImage:[UIImage imageNamed:self.item.selectImage] forState:UIControlStateSelected];
    self.descLabel.text = item.title;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.descLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 18);
    self.descLabel.centerY = self.centerY ;
    self.centernBtn.frame = CGRectMake(0, 0, self.width, self.height);
    self.bottomLineView.frame = CGRectMake(self.width/2 -10, 0, 20, 2);
    self.bottomLineView.bottom = self.bottom;
    self.centernBtn.centerY = self.centerY;
//    self.bottomLineView.centerX = self.centerX;
}
@end

@interface BaseTabBarController() <KMBarItemViewDelegate>

@property (nonatomic, strong) UIView *barView;
@property (nonatomic, strong) UILabel *messageUnreadLabel;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;

@property (nonatomic, strong) UIView * msgRedPointView; //消息按钮旁边的未读按钮
@property (nonatomic, strong) UIImageView * mineRedPointView; //个人按钮旁边的未读按钮
@property (nonatomic, strong) UserCenterViewController * UserCenterVc;

@property (nonatomic, assign) NSInteger ViewControllerCount;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSMutableArray <KMBarItem *> *barItemArray;
@end

@implementation BaseTabBarController

+(instancetype)shareTabBarController{
    static id __obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __obj = [[self alloc] init];
    });
    return __obj;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = kTabBarHeight;
    tabFrame.origin.y = kScreenHeight - kTabBarHeight;
    self.tabBar.frame = tabFrame;
    self.barView.frame = (CGRect){0,0,kScreenWidth,kTabBarHeight};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    self.selectedIndex =0;
    [self setTabBarSelectedIndex:BaseTabBarControllerIndexTypeHome];
    [self addObserver];
    [self updateUnreadMessageStatus];
    [self uploadRedBag];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self.tabBar bringSubviewToFront:self.barView];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
-(void)setupView{
    self.delegate = self;
    [[UITabBar appearance] setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
    //背景图片为透明色
    [[UITabBar appearance] setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]]];
    self.tabBar.backgroundColor = [UIColor clearColor];
    self.tabBar.translucent = YES;
    self.tabBar.barStyle= UIBarStyleDefault;
    self.tabBar.shadowImage =  [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(self.tabBar.width, self.tabBar.height)] ; // [UIImage new];
    [self.tabBar addSubview:self.barView];
    
    ShowHomeViewController    *baseViewController = [[ShowHomeViewController alloc]init];
    [baseViewController.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftNone];
    
    BaseViewController    *baseViewController1 = [[BaseViewController alloc]init];
    baseViewController1.view.backgroundColor = [UIColor grayColor];
    [baseViewController1.navigationBarView setNavigationLeftBarStyle:NavigationBarLeftNone];

    
    KMBarItemView *homeView = [self setupBarItem:[KMBarItem item:STRING_TABBAR_HOME_15 normalImage:nil selectImage:nil] viewController:baseViewController type:UIBarButtonItemType_Text];
    KMBarItemView *centerView = [self setupBarItem:[KMBarItem item:@"" normalImage:nil selectImage:nil] viewController:baseViewController1 type:UIBarButtonItemType_Button];
    KMBarItemView *meView = [self setupBarItem:[KMBarItem item:STRING_TABBAR_ACCOUNT_12 normalImage:nil selectImage:nil] viewController:self.UserCenterVc type:UIBarButtonItemType_Text];

    [self.barView addSubview:homeView];
    [self.barView addSubview:centerView];
    [self.barView addSubview:meView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, 0, kScreenWidth, 1);
    lineView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.2];
    [self.barView addSubview:lineView];
}

-(void)setTabBarSelectedIndex:(BaseTabBarControllerIndexType)index{
    
    KMBarItemView *view = (KMBarItemView *)self.barView.subviews[index];
    view.iconButton.selected = YES;
    view.descLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    view.descLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
    view.bottomLineView.backgroundColor = [UIColor whiteColor] ;

    if(index != self.selectedIndex && self.selectedIndex <= __default_bar_count-1){
        KMBarItemView *preView = (KMBarItemView *)self.barView.subviews[self.selectedIndex];
        preView.descLabel.textColor = [UIColor whiteColor];
        preView.bottomLineView.backgroundColor = [UIColor clearColor] ;
        preView.descLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightMedium];
    }
    self.selectedIndex = index;
}

-(KMBarItemView *)setupBarItem:(KMBarItem *)item viewController:(BaseViewController *)controller type:(UIBarButtonItemType)type{
    int index = (int)self.barItemArray.count;
    CGFloat width = kScreenWidth / __default_bar_count;
    
    KMBarItemView *view = [[KMBarItemView alloc] init];
    view.frame = (CGRect){index *width ,0, width, kTabBarHeight};
    view.item = item;
    view.delegate = self;
    view.type = type ;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
    [self.barItemArray addObject:item];
    return view;
}

-(void)barItemView:(KMBarItemView *)view didClickBarButton:(KMBarItem *)item{
    int selectindex = (int)[self.barItemArray indexOfObject:item];
    NSLog(@"selectindex = %d",selectindex);
    if (selectindex == 0) {
        self.barView.backgroundColor = [UIColor clearColor];
        [[UITabBar appearance] setBarTintColor:[UIColor clearColor]];
    }else if(selectindex==1){
        return;
    } else{
        self.barView.backgroundColor = kthemeBlackColor;
    }

    [self setTabBarSelectedIndex:selectindex];
    
    if(selectindex != self.selectedIndex)[self dot:selectindex];
}

-(void)addObserver{

}

-(void)login{
    [self updateUnreadMessageStatus];
}

-(void)logout{

}

- (void)uploadRedBag {
}

-(void)showcircleRedPointView:(NSNotification *)not{
    NSInteger count = [not.object integerValue];
}

#pragma mark - 打点
-(void)dot:(BaseTabBarControllerIndexType)index{
}

-(void)showOrderRedDocWithCount:(NSInteger)count
{
    if (count < 0) {
        return;
    }
    
    dispatch_block_t block = ^{
        
        self.messageUnreadLabel.hidden = (count==0);
        self.msgRedPointView.hidden = ((count > 0) || (self.slMsgUnreadCount < 1));

        NSString *str = count > 99 ? @"99+" : [NSString stringWithFormat:@"%ld",count];
        self.messageUnreadLabel.text = str;
        [self.messageUnreadLabel sizeToFit];
        self.messageUnreadLabel.width += 10;
        self.messageUnreadLabel.width = self.messageUnreadLabel.width >18 ? self.messageUnreadLabel.width:18;
        self.messageUnreadLabel.height = 18;
    };
    dispatch_main_sync_safe(block);
}

//获取未读消息状态（若有未读显示红点）
-(void)updateUnreadMessageStatus
{
    
}

-(UIView *)barView{
    if (!_barView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        view.userInteractionEnabled = YES;
        _barView = view;
    }
    return _barView;
}

-(UILabel *)messageUnreadLabel{
    if (!_messageUnreadLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0,0,18,18}];
        label.textColor = [UIColor whiteColor];
        label.font = Font_Regular(11);
        label.backgroundColor = RGBCOLOR(247, 76, 49);
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        
        label.layer.borderColor = Color(@"ffffff").CGColor;
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = label.frame.size.height /2.0;
        label.clipsToBounds = YES;
        
        _messageUnreadLabel = label;
    }
    return _messageUnreadLabel;
}


-(UIImageView *)mineRedPointView
{
    if (!_mineRedPointView) {
        _mineRedPointView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 9, 9)];
        _mineRedPointView.image = [UIImage imageNamed:@"mine_redIcon"];
        _mineRedPointView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _mineRedPointView;
}


-(UserCenterViewController*)UserCenterVc
{
    if (!_UserCenterVc) {
        _UserCenterVc = [[UserCenterViewController alloc]init];
    }
    return _UserCenterVc;
}



-(NSMutableArray<KMBarItem *> *)barItemArray{
    if (!_barItemArray) {
        _barItemArray = [NSMutableArray array];
    }
    return _barItemArray;
}

-(NSArray *)tabBarTopController{
    return @[@"KMMessageViewController",@"KMFriendCircleController",@"KMHomePageTopViewController",@"KMMeCenterViewController"];
}
@end
