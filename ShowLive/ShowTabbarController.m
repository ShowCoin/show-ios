//
//  ShowTabbarController.m
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/3/29.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowTabbarController.h"
#import "KMUnReadOfficialMessagesAction.h"
#import "KMMessageViewController.h"
#import "KMMeCenterViewController.h"
#import "KMFriendCircleController.h"
#import "KMHomePageTopViewController.h"
#import "KMBaseNavigationController.h"

#define __default_bar_count 4
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
@property(nonatomic,strong)UILabel * descLabel;

@end

@implementation KMBarItemView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.userInteractionEnabled = YES;
        [self addSubview:self.iconButton];
        [self addSubview:self.descLabel];
        self.backgroundColor=[UIColor clearColor];
        [self addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
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

-(UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = Font_Regular(10);
        label.textColor = Color(@"9A9A9A");
        label.textAlignment = NSTextAlignmentCenter;
        _descLabel = label;
    }
    return _descLabel;
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
    self.iconButton.frame = (CGRect){0,7,25,25};
    self.iconButton.centerX = self.bounds.size.width/2.0;
    self.descLabel.frame = (CGRect){0,CGRectGetMaxY(self.iconButton.frame)+2,self.bounds.size.width,12};
}
@end

@interface BaseTabBarController() <KMBarItemViewDelegate>

@property (nonatomic, strong) KMHomePageTopViewController  * homePageVc;
@property(nonatomic,  strong) KMFriendCircleController       * circleVc;
@property (nonatomic, strong) KMMeCenterViewController * UserCenterVc;
@property (nonatomic, strong) KMMessageViewController * messageVc;

@property (nonatomic, strong) UIView *barView;
@property (nonatomic, strong) UILabel *messageUnreadLabel;
@property (nonatomic, strong) UIView * circleRedPointView;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;

@property (nonatomic, strong) UIView * msgRedPointView; //消息按钮旁边的未读按钮
@property (nonatomic, strong) UIImageView * mineRedPointView; //个人按钮旁边的未读按钮

@property (nonatomic, assign) NSInteger ViewControllerCount;

@property (nonatomic, strong) KMUnReadOfficialMessagesAction *unReadOfficialMessagesAction;
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
    self.barView.frame = (CGRect){0,0,kScreenWidth,49};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setTabBarSelectedIndex:BaseTabBarControllerIndexTypeHome];
    [self addObserver];
    [self updateUnreadMessageStatus];
    [self uploadRedBag];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (PageMgr.currentRootIndex == RootIndexTab || ( PageMgr.isRootScrolling && PageMgr.currentRootIndex !=RootIndexTab)) {
        if (!([PageMgr hasNoNextControllerInCurrentTab])) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
    }
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
    self.tabBar.translucent = YES;
    self.tabBar.barStyle= UIBarStyleDefault;
    self.tabBar.shadowImage = [UIImage new];
    [self.tabBar addSubview:self.barView];
    
    
    KMBarItemView *homeView = [self setupBarItem:[KMBarItem item:@"首页" normalImage:@"tab3" selectImage:@"tab3_s"] viewController:self.homePageVc];
    KMBarItemView *circleView = [self setupBarItem:[KMBarItem item:@"动态" normalImage:@"tab2" selectImage:@"tab2_s"] viewController:self.circleVc];
    KMBarItemView *chatView = [self setupBarItem:[KMBarItem item:@"聊天" normalImage:@"tab1" selectImage:@"tab1_s"] viewController:self.messageVc];
    KMBarItemView *meView = [self setupBarItem:[KMBarItem item:@"我" normalImage:@"tab4" selectImage:@"tab4_s"] viewController:self.UserCenterVc];
    
    CGFloat x = circleView.iconButton.imageView.image.size.width - self.circleRedPointView.frame.size.width /2.0;
    self.circleRedPointView.frame = (CGRect){x,0,self.circleRedPointView.frame.size};
    
    x = chatView.iconButton.imageView.image.size.width - self.msgRedPointView.frame.size.width /2.0;
    self.msgRedPointView.frame = (CGRect){x,0,self.msgRedPointView.frame.size};
    
    x = chatView.iconButton.imageView.image.size.width - self.messageUnreadLabel.frame.size.width /2.0;
    self.messageUnreadLabel.frame = (CGRect){x,-2,self.messageUnreadLabel.frame.size};
    
    x = meView.iconButton.imageView.image.size.width - self.mineRedPointView.frame.size.width /2.0;
    self.mineRedPointView.frame = (CGRect){x-2,-2,self.mineRedPointView.frame.size};
    
    [circleView.iconButton.imageView addSubview:self.circleRedPointView];
    //    [chatView.iconButton.imageView addSubview:self.msgRedPointView];
    [chatView.iconButton.imageView addSubview:self.messageUnreadLabel];
    [meView.iconButton.imageView addSubview:self.mineRedPointView];
    
    [self.barView addSubview:homeView];
    [self.barView addSubview:circleView];
    [self.barView addSubview:chatView];
    [self.barView addSubview:meView];
}

-(void)setTabBarSelectedIndex:(BaseTabBarControllerIndexType)index{
    KMBarItemView *view = (KMBarItemView *)self.barView.subviews[index];
    view.iconButton.selected = YES;
    view.descLabel.textColor = Color(@"333333");
    
    if(index != self.selectedIndex && self.selectedIndex <= __default_bar_count){
        KMBarItemView *preView = (KMBarItemView *)self.barView.subviews[self.selectedIndex];
        preView.iconButton.selected = NO;
        preView.descLabel.textColor = Color(@"9A9A9A");
    }
    
    //    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //    pulse.duration = 0.15;
    //    pulse.repeatCount= 1;
    //    pulse.autoreverses= YES;
    //    pulse.fromValue= [NSNumber numberWithFloat:1];
    //    pulse.toValue= [NSNumber numberWithFloat:0.8];
    //    pulse.removedOnCompletion = NO;
    //    pulse.fillMode = kCAFillModeForwards;
    //    [[view layer] addAnimation:pulse forKey:nil];
    
    self.selectedIndex = index;
}

-(KMBarItemView *)setupBarItem:(KMBarItem *)item viewController:(BaseViewController *)controller{
    int index = (int)self.barItemArray.count;
    CGFloat width = kScreenWidth / __default_bar_count;
    
    KMBarItemView *view = [[KMBarItemView alloc] init];
    view.frame = (CGRect){index *width ,0, width, 49};
    view.item = item;
    view.delegate = self;
    
    KMBaseNavigationController *nav = [[KMBaseNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
    [self.barItemArray addObject:item];
    return view;
}

-(void)barItemView:(KMBarItemView *)view didClickBarButton:(KMBarItem *)item{
    int selectindex = (int)[self.barItemArray indexOfObject:item];
    if (selectindex == 0) {
        self.msgRedPointView.hidden = YES;
    }else  if (selectindex == 1) {
        //        self.circleRedPointView.hidden = YES;
    }
    
    if (selectindex == 0 && self.selectedIndex == 0) {//首页重复点击
        [self.homePageVc singleTapAction];
    }else if (selectindex == 1 && self.selectedIndex == 1) {
        [self.circleVc  singleTapAction];
    }else if (selectindex == 2 && self.selectedIndex == 2) {
        [self.messageVc  doubleTapAction];
    }
    
    [self setTabBarSelectedIndex:selectindex];
    
    if(selectindex != self.selectedIndex)[self dot:selectindex];
}

-(void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showcircleRedPointView:) name:BK_FollowPageRedPoint object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadRedBag) name:@"kNotificationUploadRedBag" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:BK_LOGINSUSSCES object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:kNotificationLogout object:nil];
}

-(void)login{
    [self updateUnreadMessageStatus];
}

-(void)logout{
    self.circleRedPointView.hidden = YES;
}

- (void)uploadRedBag {
    if (isStrValid([KMSystemConfig sharedConfig].taskURL)) {
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYYMMdd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        if (![[UserDefaultsUtils valueWithKey:@"loginDate"] isEqualToString:dateString]) {
            self.mineRedPointView.hidden = NO;
        }else {
            if ([[UserDefaultsUtils valueWithKey:@"showedMineRed"] boolValue]) {
                self.mineRedPointView.hidden = YES;
            }else {
                self.mineRedPointView.hidden = NO;
            }
        }
    }else {
        self.mineRedPointView.hidden = YES;
    }
}

-(void)showcircleRedPointView:(NSNotification *)not{
    NSInteger count = [not.object integerValue];
    self.circleRedPointView.hidden = count == 0;
}

#pragma mark - 打点
-(void)dot:(BaseTabBarControllerIndexType)index{
    switch (index) {
        case 0:
            [ReportManager reportEvent:kReport_list andSubEvent:kReport_list_click];
            break;
        case 1:
            [ReportManager reportEvent:kReport_follow andSubEvent:kReport_follow_click];
            break;
        case 2:
            [ReportManager reportEvent:kReport_news andSubEvent:kReport_news_click];
            break;
        case 3:
            [ReportManager reportEvent:kReport_me andSubEvent:kReport_me_click];
            break;
        default:
            break;
    }
}

-(void)showOrderRedDocWithCount:(NSInteger)count
{
    if (count < 0) {
        return;
    }
    
    dispatch_block_t block = ^{
        
        self.messageUnreadLabel.hidden = (count==0);
        self.msgRedPointView.hidden = ((count > 0) || (self.seeuMsgUnreadCount < 1));
        
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
    if (UserProfile.isTourist) {
        return;
    }
    __weak typeof(self) weaks = self;
    KMUnReadOfficialMessagesAction *action = [KMUnReadOfficialMessagesAction action];
    action.type = @"2";
    action.finishedBlock = ^(NSDictionary * result) {
        //官方未读
        NSInteger count = [result[@"pri_unread"] integerValue];
        weaks.circleRedPointView.hidden = count == 0;
        weaks.seeuMsgUnreadCount = result[@"pub_unread"] ? [result[@"pub_unread"] intValue] : 0;
    };
    [action start];
    self.unReadOfficialMessagesAction = action;
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

-(UIView *)circleRedPointView{
    if (!_circleRedPointView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0, 9, 9)];
        view.layer.cornerRadius = 4.5;
        view.backgroundColor = kThemeRedColor;
        view.hidden = YES;
        _circleRedPointView = view;
    }
    return _circleRedPointView;
}

-(UIView *)msgRedPointView
{
    if (!_msgRedPointView) {
        _msgRedPointView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 9, 9)];
        _msgRedPointView.layer.cornerRadius = 4.5;
        _msgRedPointView.backgroundColor = kThemeRedColor;
    }
    return _msgRedPointView;
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

-(KMMessageViewController *)messageVc
{
    if (!_messageVc) {
        _messageVc = [KMMessageViewController new];
    }
    return _messageVc;
}

-(KMFriendCircleController *)circleVc
{
    if(!_circleVc)
    {
        _circleVc = [KMFriendCircleController viewController];
        
    }
    return _circleVc;
}

-(KMHomePageTopViewController*)homePageVc
{
    if(!_homePageVc)
    {
        _homePageVc = [KMHomePageTopViewController viewController];
    }
    return _homePageVc;
}

-(KMMeCenterViewController*)UserCenterVc
{
    if (!_UserCenterVc) {
        _UserCenterVc = [KMMeCenterViewController viewController];
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
