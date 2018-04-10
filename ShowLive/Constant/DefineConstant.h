//
//  DefineConstant.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#ifndef DefineConstant_h
#define DefineConstant_h
#pragma mark -
#pragma mark 打印日志
//DEBUG  模式下打印日志,当前行

#ifndef __OPTIMIZE__
#define NSLog(fmt, ...) \
NSLog(@"%s\n%@\n", __FUNCTION__, [NSString stringWithFormat:fmt, ##__VA_ARGS__])
#else
#define NSLog(...)
#endif

//Layout 布局类宏命令
#define KScreenRect [UIScreen mainScreen].bounds
#define kMainScreenHeight   ([UIScreen mainScreen].bounds).size.height //屏幕的高度
#define kMainScreenWidth    ([UIScreen mainScreen].bounds).size.width //屏幕的宽度
#define kMainScreenFrame    CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight) //屏幕frame
#define WIDTH_VIEW(view) CGRectGetWidth(view.frame)
#define HEIGHT_VIEW(view) CGRectGetHeight(view.frame)
#define VIEW_MAXX(view) CGRectGetMaxX(view.frame)
#define VIEW_MAXY(view) CGRectGetMaxY(view.frame)


#define KNewUser                        @"isnewuser"

//适配 利器宏命令
#define Proportion ([UIScreen mainScreen].bounds.size.width/320)

#define kTabBarHeight                        (49.0f + KBottomHeight)
#define kNaviBarHeight                       (__IphoneX__ ? 88 : 64)
#define KBottomHeight                        (__IphoneX__ ? 34 : 0)
#define KTopHeight                           (__IphoneX__ ? 24 : 0 )
#define __IphoneX__                          (kScreenHeight == 812.0)
#define kHeightFor4InchScreen                568.0f
#define kHeightFor3p5InchScreen              480.0f
#define kStatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define kRect(x, y, w, h)    CGRectMake(x, y, w, h)
#define kSize(w, h)                          CGSizeMake(w, h)
#define kPoint(x, y)                         CGPointMake(x, y)
#define kSinglePixel (1.0/[UIScreen mainScreen].scale)

#define kSeparatorCellHeight 10.0f // 分割cell的高度
#define kMainWindow   [UIApplication sharedApplication].keyWindow  //PageMgr.getCurrentWindow
#define kScreenScale [UIScreen mainScreen].scale


//字体
#define KTitleFont   @"STHeitiSC-Medium"
#define KContentFont @"Helvetica"
#define KHeitiFont   @"Heiti SC"

//资源进行管理，为后期做国际化处理 不要删掉，否则会报错
#define KRESOURCESSTRING(a) [[ShowResourcesService shared]stringForKey:a]
#define KRESOURCESSIMAGE(a) [[ShowResourcesService shared]imageForkey:a]
//颜色
/// 通过RGBA设置颜色，使用0x格式，如：RGBAAllColor(0xAABBCC, 0.5);
#define RGBAAllColor(rgb, a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0  \
green:((float)((rgb & 0xFF00) >> 8))/255.0     \
blue:((float)(rgb & 0xFF))/255.0              \
alpha:(a)/1.0]

/// 通过RGB设置颜色，使用0x格式，如：RGBAAllColor(0xAABBCC);
#define RGBAllColor(rgb) RGBAAllColor(rgb, 1.0)
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define GXRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
/*网宿上传域名*/
#define WSHTTPURL @"http://video-test.hifun.mobi"
//随机色
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/** APP名称 */
#define  kAppName   @"ShowLive"
/** 货币名称 */
#define  kMoneyName   @"Show钻"
/** 货币名称 */
#define  kEarningsName   @"Show币"
/** 项目默认背景颜色 */
#define kDefaultBackgroundColor     RGBACOLOR(241.f, 241.f, 241.f, 1.f)
#define kDefaultBackgroundColorAlpha(a)     RGBACOLOR(241.f, 241.f, 241.f, a)

#define kTableviewItemSelectColor     RGBACOLOR(251.f, 252.f, 255.f, 1.f)

#pragma mark - 新标题类颜色
/*******************/
/**   新配色 宏定义 **/
/// 主题黑
#define kthemeBlackColor        HexRGBAlpha(0x333333, 1)
/// 主题黄
#define kThemeYellowColor       HexRGBAlpha(0xd5ae8f, 1)
/// 主题白
#define kThemeWhiteColor        HexRGBAlpha(0xffffff, 1)
/// 钱包字体灰
#define kTextGrayColor          HexRGBAlpha(0xb7b7b7, 1)
//分割线颜色
#define kSeparationColor        HexRGBAlpha(0xf7f7f7, 1)
//灰色底颜色
#define kGrayBGColor            HexRGBAlpha(0xe8e8e8, 1)

//灰色系
#define kGrayWith999999         HexRGBAlpha(0x999999, 1)
#define kGrayWithaaaaaa         HexRGBAlpha(0xaaaaaa, 1)
#define kGrayWithf4f4f4         HexRGBAlpha(0xf4f4f4, 1)

/*******************/

//des解密key
#define DESKEY              @"%#`=I=Q*f^khuo90LKSS..;'193VE&^H??][zmus"

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]) || ([(_ref)isEqualToString:@"(null)"]))
#define ISNIL(variable) (variable==nil)
//是不是NULL类型
#define IS_NULL_CLASS(variable)    ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNull class]])
//字典数据是否有效
#define IS_DICTIONARY_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSDictionary class]])&&([((NSDictionary *)variable) count]>0))
//数组数据是否有效
#define IS_ARRAY_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSArray class]]))
//数字类型是否有效
#define IS_NUMBER_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNumber class]]))
//字符串是否有效
#define IS_EXIST_STR(str) ((nil != (str)) &&([(str) isKindOfClass:[NSString class]]) && (((NSString *)(str)).length > 0))

#pragma mark -
#pragma mark 设备系统版本、尺寸、字体、颜色 相关配置
//判断程序的版本
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0)
#define IOS_9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)
#define IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0f)

//iOS 10新版本号写法
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//格式转化
#define Int2String(para)  [NSString stringWithFormat:@"%i", (int)para]
#define Float12String(float)  [NSString stringWithFormat:@"%.1f", float]
#define Float22String(float)  [NSString stringWithFormat:@"%.2f", float]
#define Long2String(long)  [[NSNumber numberWithLongLong:long] stringValue]
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define NSStringFromValue(value) [NSString stringWithFormat:@"%@", value]
#define NSURLFromString(str) [NSURL URLWithString:str]



#define TEXT_SPACING_FOR_LINE           4.5f    //文本行间距

/**********  系统通用宏  **********/

#define LOGIN_NAVIGATIONCONTROLLER ((AppDelegate *)[UIApplication sharedApplication].delegate).loginNavigationController
#define MAIN_NAVIGATIONCONTROLLER ((AppDelegate *)[UIApplication sharedApplication].delegate).mainNavigationController

//设备
#define IS_IPHONE_5_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

enum {
    FrameTypeX = 0,                         //x
    FrameTypeY = 1,                         //y
    FrameTypeWidth = 2,                     //width
    FrameTypeHeight = 3                     //height
};
typedef NSUInteger FrameType;

#define Proportion375 (kMainScreenWidth/375)

#define SCREEN_MAX_LENGTH (MAX(kMainScreenWidth, kMainScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(kMainScreenWidth, kMainScreenHeight))
//析构
#define RELEASE_MEMORY(__POINTER)   { if((__POINTER) != nil) { __POINTER = nil;  __POINTER = 0;} }//初始化
#define DEFAULTS [NSUserDefaults standardUserDefaults]
#define HOTSPOT_STATUSBAR_HEIGHT            20
#define APP_STATUSBAR_HEIGHT                (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define IS_HOTSPOT_CONNECTED                (APP_STATUSBAR_HEIGHT==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?YES:NO)

#define  SHARETEXT @"我下载了ShowLive，我和我的小伙伴都惊呆了！(他提到了你)"

//未知服务器错误的通用提示
static NSString *const KM_NET_ERROR = @"网络连接不稳定，请重试";
static NSString *const SECTION_SYSTEM_DEFAULT = @"欢迎来到ShowLive，我们等你好久啦！在这里你可以寻找到自己喜欢的帅哥美女，赶紧去体验一下吧:)";

//#warning 旧的方式,准备废弃
/**
 *  强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 *  调用方式: `@weakify_old(object)`实现弱引用转换，`@strongify_old(object)`实现强引用转换
 *
 *  示例：
 *  @weakify_old(object)
 *  [obj block:^{
 *      @strongify_old(object)
 *      strong_object = something;
 *  }];
 */
#ifndef    weakify_old
#if __has_feature(objc_arc)
#define weakify_old(object)    autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify_old(object)    autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#endif
#ifndef    strongify_old
#if __has_feature(objc_arc)
#define strongify_old(object) try{} @finally{} __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify_old(object) try{} @finally{} __typeof__(object) strong##_##object = block##_##object;
#endif
#endif



#define Str(s) (s==nil ? @"" : s)
#define StrNull(f) (f==nil || ![f isKindOfClass:[NSString class]] || ([f isKindOfClass:[NSString class]] && [f isEqualToString:@""]))
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,eky) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

#define dispatch_safe_main(block) if ([NSThread isMainThread]) {block();}else{dispatch_async(dispatch_get_main_queue(),block);}
#define dispatch_sub_thread(block) if ([NSThread isMainThread]) {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block);}else{block();}

#define appdelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)
typedef void(^SuccessBlock) (BOOL isLastPage);
typedef void(^FailBlock) (NSString* failDesc);

#define kGrayTextColor HexRGBAlpha(0x979797, 1)
#define kDarkTextColor HexRGBAlpha(0x383157, 1)
#define kGrayLineColor HexRGBAlpha(0xf4f4f4, 1)

#pragma mark - 主线程block
/**
 * 用法：dispatch_block_t block = ^{...};
 *      dispatch_main_sync_safe(block);
 * 注意：不要连写成dispatch_main_sync_safe(^{...});，否则无法断点调试
 */
#ifndef dispatch_main_sync_safe
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
}\
else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}
#endif

/* 增加async版本*/
#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

#pragma mark - 坐标快捷
#define HScale  kScreenHeight / 667.0
#define WScale  kScreenWidth / 375.0
#define kScreenScale [UIScreen mainScreen].scale
#define kScreenRect ([UIScreen mainScreen].bounds)
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

static inline CGRect CGRectWithWidthScale(CGFloat x,CGFloat y,CGFloat w,CGFloat h)
{
    return (CGRect){(CGFloat)(x*WScale), (CGFloat)(y*WScale), (CGFloat)(w*WScale) , (CGFloat)(h*WScale)};
}

#pragma mark - 文件夹
#define QCDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define QCLibraryDirectory [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define QCLibraryCacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define Color(x) [UIColor colorWithHexString:x]

#define IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0  ? 1 : 0)
#define IOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0  ? 1 : 0)

#define angle2Radian(angle) ((angle)/180.0*M_PI)

#define WSELF_DEFINE __weak typeof(self) wself = self;

//视频录制宏
#define kMoviePath @"kMoviePath"
#define kMovieTime @"kMovieTime"
#define kMovieSpeed @"kMovieSpeed"
#define kMovieIndex @"kMovieIndex"

/// 分段视频临时存储路径
#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
/// 合成视频本地存储路径
#define kVideoPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

// 常用
#define USER_DEFAULT   [NSUserDefaults standardUserDefaults]
#define NOTIFICATION_CENTER [NSNotificationCenter defaultCenter]
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

// 常用 color
#define BlackColor [UIColor blackColor]
#define WhiteColor [UIColor whiteColor]
#define ClearColor [UIColor clearColor]
#define BlackColorAlpha(_alpha) [UIColor colorWithRed:0 green:0 blue:0 alpha:_alpha]
#define WhiteColorAlpha(_alpha) [UIColor colorWithRed:1 green:1 blue:1 alpha:_alpha]

#pragma mark - 有关字符串比较常用的一些方法
// // // // // // // // //
/// 是否是有效的字符串，包括空串、类型、空白字符等的判定
static inline BOOL isStrValid(NSString *value)
{
    return ( ( value ) &&
            ( [value isKindOfClass:[NSString class]] ) &&
            ( ![@"" isEqualToString:value] ) &&
            ( value.length > 0 ) &&
            ( ![value isKindOfClass:[NSNull class]] ) &&
            ( ![@"(null)" isEqualToString:value] ) &&
            ( [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0 )
            );
}

/// 安全字符串，如果字符串无效，返回:@"0"
static inline NSString *SafeNumberString(NSString *value)
{
    return isStrValid(value) ? value : @"0";
}

/// 安全字符串，如果字符串无效，返回:@""
static inline NSString *SafeEmptyString(NSString *value)
{
    return isStrValid(value) ? value : @"";
}

#endif /* DefineConstant_h */
