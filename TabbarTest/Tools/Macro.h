//
//  Macro.h
//  Utils
//
//  Created by 赵旭东 on 2016/12/14.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

#ifndef Macro_h
#define Macro_h

//-------------------获取设备大小-------------------------
/*获取屏幕 宽度、高度*/
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//-------------------获取设备大小-------------------------

//-------------------打印日志-------------------------
/*DEBUG  模式下打印日志,当前行*/
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
/*重写NSLog,Debug模式下打印日志和当前行数*/
#if DEBUG
#else
#define NSLog(FORMAT, ...) nil
#endif
/*DEBUG  模式下打印日志,当前行 并弹出一个警告*/
#ifdef DEBUG
#   define ULog(fmt, ...)  {UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__] preferredStyle:(UIAlertControllerStyleAlert)];UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];[alertVC addAction:action];[[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertVC animated:YES completion:nil];}
#else
#   define ULog(...)
#endif
//-------------------打印日志-------------------------

//----------------------系统----------------------------

/*获取系统版本*/
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
/*APP版本号*/
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/*获取当前语言*/
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
/*判断当前iPhone类型*/
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
/*判断手机大小*/
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
/*UUID*/
#define UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

//----------------------系统----------------------------

//----------------------图片----------------------------
/*读取本地图片*/
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]];
/*获取图片资源*/
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
//----------------------图片----------------------------


//----------------------颜色类---------------------------

/*rgb颜色转换（16进制->10进制）*/
#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f];
/*带有RGBA的颜色设置*/
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
/*获取RGB颜色*/
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]  
/*随机颜色*/
#define RANDOM_COLOR  RGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

/*清除背景色*/
#define CLEARCOLOR [UIColor clearColor]
//----------------------颜色类---------------------------

//----------------------其他----------------------------
/*由角度获取弧度*/
#define degreesToRadian(x) (M_PI * (x) / 180.0)
/*由弧度获取角度*/
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

/*弱引用,强引用*/
#define XDWeakSelf(type)  __weak typeof(type) weak##type = type;
#define XDStrongSelf(type)  __strong typeof(type) type = weak##type;
/*设置 view 圆角和边框*/
#define XDViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/*获取temp*/
#define XDPathTemp NSTemporaryDirectory()
/*获取沙盒 Document*/
#define XDPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/*获取沙盒 Cache*/
#define XDPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
/*GCD - 在Main线程上运行*/
#define XDDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
/*GCD - 开启异步线程*/
#define XDDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);
/*延时处理*/
#define XDDISPATCH_AFTER(delaytime,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((float)delaytime * NSEC_PER_SEC)), dispatch_get_main_queue(),block)
///NSUserDefaults
/*保存value到对应的key*/
#define XDsetValueForKey(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];[[NSUserDefaults standardUserDefaults] synchronize]
/*根据key值获取value*/
#define XDgetValueForKey(key) [[NSUserDefaults standardUserDefaults]valueForKey:key]
/*保存bool到对应的key*/
#define XDsetBoolForKey(Bool,key) [[NSUserDefaults standardUserDefaults]setBool:Bool forKey:key];[[NSUserDefaults standardUserDefaults] synchronize]
/*根据key值获取bool*/
#define XDgetBoolForKey(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]
/*删除对应key的value*/
#define XDremoveObjectForKey(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]


/*字符串是否为空*/
#define XDStringIsEmpty(string) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define XDArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define XDDictIsEmpty(dic) ([dic isKindOfClass:[NSNull class]] || dic == nil || dic.allKeys.count == 0)
//是否是空对象
#define XDObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//检查对象是否为null
#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

///一些缩写
#define kApplication  [UIApplication sharedApplication]
#define kKeyWindow   [UIApplication sharedApplication].keyWindow
#define kAppDelegate  [UIApplication sharedApplication].delegate
#define kUserDefaults  [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]



//----------------------其他----------------------------
///播放提示音
#define XDPlaySounds(resource,type) SystemSoundID sourceID;NSString *soundFile = [[NSBundle mainBundle] pathForResource:resource ofType:type];AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:soundFile], &sourceID);AudioServicesPlaySystemSound(sourceID);














//
///**
// *     便捷定义@property属性
// */
//
//
///** copy */
//
////NSString
//#define cString_(name) \
//zzn_copy_property(NSString*,name)
////NSArray
//#define cArray_(name) \
//zzn_copy_property(NSArray*,name)
////NSDictionary
//#define cDictionary_(name) \
//zzn_copy_property(NSDictionary*,name)
////NSNumber,它没用对应的不可变类，其实用copy或strong没有区别
//#define cNumber_(name) \
//zzn_copy_property(NSNumber*,name)
////NSData
//#define cData_(name) \
//zzn_copy_property(NSData*,name)
////NSSet
//#define cSet_(name) \
//zzn_copy_property(NSSet*,name)
////NSIndexSet
//#define cIndexSet_(name) \
//zzn_copy_property(NSIndexSet*,name)
//
////代码块，名称和传参，没有传参就不填
//#define Block_(name,...) \
//zzn_set_block(void,name,__VA_ARGS__)
////有返回值的代码块
//#define BlockReturn_(name,returnClass,...) \
//zzn_set_block(returnClass,name,__VA_ARGS__)
//
//
//
//
//
//
///** strong */
//
////NSMutableString
//#define sString_(name,...) \
//zzn_strong_property(NSMutableString*,name,__VA_ARGS__)
////NSMutableArray
//#define sArray_(name,...) \
//zzn_strong_property(NSMutableArray*,name,__VA_ARGS__)
////NSMutableDictionary
//#define sDictionary_(name,...) \
//zzn_strong_property(NSMutableDictionary*,name,__VA_ARGS__)
////NSMutableData
//#define sData_(name,...) \
//zzn_strong_property(NSMutableData*,name,__VA_ARGS__)
////NSMutableSet
//#define sSet_(name,...) \
//zzn_strong_property(NSMutableSet*,name,__VA_ARGS__)
////NSMutableIndexSet
//#define sIndexSet_(name,...) \
//zzn_strong_property(NSMutableIndexSet*,name,__VA_ARGS__)
//
////UIImage
//#define Image_(name) \
//zzn_strong_property(UIImage*,name)
////UIColor
//#define Color_(name) \
//zzn_strong_property(UIColor*,name)
////id
//#define id_(name,...) \
//zzn_strong_property(id,name,__VA_ARGS__)
//
////UIView
//#define View_(name,...) \
//zzn_strong_property(UIView*,name,__VA_ARGS__)
////UIImageView
//#define ImageView_(name,...) \
//zzn_strong_property(UIImageView*,name,__VA_ARGS__)
////UILabel
//#define Label_(name,...) \
//zzn_strong_property(UILabel*,name,__VA_ARGS__)
////UIButton
//#define Button_(name,...) \
//zzn_strong_property(UIButton*,name,__VA_ARGS__)
////UITableView
//#define TableView_(name,...) \
//zzn_strong_property(UITableView*,name,__VA_ARGS__)
////UICollectionView
//#define CollectionView_(name,...) \
//zzn_strong_property(UICollectionView*,name,__VA_ARGS__)
////UISegmentedControl
//#define SegmentedControl_(name,...) \
//zzn_strong_property(UISegmentedControl*,name,__VA_ARGS__)
////UITextField
//#define TextField_(name,...) \
//zzn_strong_property(UITextField*,name,__VA_ARGS__)
////UISlider
//#define Slider_(name,...) \
//zzn_strong_property(UISlider*,name,__VA_ARGS__)
////UISwitch
//#define Switch_(name,...) \
//zzn_strong_property(UISwitch*,name,__VA_ARGS__)
////UIActivityIndicatorView
//#define ActivityIndicatorView_(name,...) \
//zzn_strong_property(UIActivityIndicatorView*,name,__VA_ARGS__)
////UIProgressView
//#define ProgressView_(name,...) \
//zzn_strong_property(UIProgressView*,name,__VA_ARGS__)
////UIPageControl
//#define PageControl_(name,...) \
//zzn_strong_property(UIPageControl*,name,__VA_ARGS__)
////UIStepper
//#define Stepper_(name,...) \
//zzn_strong_property(UIStepper*,name,__VA_ARGS__)
////UITextView
//#define TextView_(name,...) \
//zzn_strong_property(UITextView*,name,__VA_ARGS__)
////UIScrollView
//#define ScrollView_(name,...) \
//zzn_strong_property(UIScrollView*,name,__VA_ARGS__)
////UIDatePicker
//#define DatePicker_(name,...) \
//zzn_strong_property(UIDatePicker*,name,__VA_ARGS__)
////UIPickerView
//#define PickerView_(name,...) \
//zzn_strong_property(UIPickerView*,name,__VA_ARGS__)
////UIWebView
//#define WebView_(name,...) \
//zzn_strong_property(UIWebView*,name,__VA_ARGS__)
////自定义类
//#define DIYObj_(class,name,...) \
//zzn_strong_property(class*,name,__VA_ARGS__)
//
//
//
//
//
///** assign */
//
////int
//#define int_(name,...) \
//zzn_assign_property(int,name,__VA_ARGS__)
////float
//#define float_(name,...) \
//zzn_assign_property(float,name,__VA_ARGS__)
////double
//#define double_(name,...) \
//zzn_assign_property(double,name,__VA_ARGS__)
////CGFloat
//#define CGFloat_(name,...) \
//zzn_assign_property(CGFloat,name,__VA_ARGS__)
////NSInteger
//#define NSInteger_(name,...) \
//zzn_assign_property(NSInteger,name,__VA_ARGS__)
////NSUInteger
//#define NSUInteger_(name,...) \
//zzn_assign_property(NSUInteger,name,__VA_ARGS__)
////BOOL
//#define BOOL_(name,...) \
//zzn_assign_property(BOOL,name,__VA_ARGS__)
////CGRect
//#define CGRect_(name,...) \
//zzn_assign_property(CGRect,name,__VA_ARGS__)
////CGSize
//#define CGSize_(name,...) \
//zzn_assign_property(CGSize,name,__VA_ARGS__)
////CGPoint
//#define CGPoint_(name,...) \
//zzn_assign_property(CGPoint,name,__VA_ARGS__)
////CGAffineTransform
//#define CGAffineTransform_(name,...) \
//zzn_assign_property(CGAffineTransform,name,__VA_ARGS__)
////NSTimeInterval
//#define NSTimeInterval_(name,...) \
//zzn_assign_property(NSTimeInterval,name,__VA_ARGS__)
////Class
//#define Class_(name) \
//zzn_assign_property(Class,name)
//
//
//
//
///** weak */
//
////UIImageView
//#define weakImageView_(name,...) \
//zzn_weak_property(UIImageView*,name,__VA_ARGS__)
////UIView
//#define weakView_(name,...) \
//zzn_weak_property(UIView*,name,__VA_ARGS__)
////UILabel
//#define weakLabel_(name,...) \
//zzn_weak_property(UILabel*,name,__VA_ARGS__)
////UIButton
//#define weakButton_(name,...) \
//zzn_weak_property(UIButton*,name,__VA_ARGS__)
////UITableView
//#define weakTableView_(name,...) \
//zzn_weak_property(UITableView*,name,__VA_ARGS__)
////UICollectionView
//#define weakCollectionView_(name,...) \
//zzn_weak_property(UICollectionView*,name,__VA_ARGS__)
////UISegmentedControl
//#define weakSegmentedControl_(name,...) \
//zzn_weak_property(UISegmentedControl*,name,__VA_ARGS__)
////UITextField
//#define weakTextField_(name,...) \
//zzn_weak_property(UITextField*,name,__VA_ARGS__)
////UISlider
//#define weakSlider_(name,...) \
//zzn_weak_property(UISlider*,name,__VA_ARGS__)
////UISwitch
//#define weakSwitch_(name,...) \
//zzn_weak_property(UISwitch*,name,__VA_ARGS__)
////UIActivityIndicatorView
//#define weakActivityIndicatorView_(name,...) \
//zzn_weak_property(UIActivityIndicatorView*,name,__VA_ARGS__)
////UIProgressView
//#define weakProgressView_(name,...) \
//zzn_weak_property(UIProgressView*,name,__VA_ARGS__)
////UIPageControl
//#define weakPageControl_(name,...) \
//zzn_weak_property(UIPageControl*,name,__VA_ARGS__)
////UIStepper
//#define weakStepper_(name,...) \
//zzn_weak_property(UIStepper*,name,__VA_ARGS__)
////UITextView
//#define weakTextView_(name,...) \
//zzn_weak_property(UITextView*,name,__VA_ARGS__)
////UIScrollView
//#define weakScrollView_(name,...) \
//zzn_weak_property(UIScrollView*,name,__VA_ARGS__)
////UIDatePicker
//#define weakDatePicker_(name,...) \
//zzn_weak_property(UIDatePicker*,name,__VA_ARGS__)
////UIPickerView
//#define weakPickerView_(name,...) \
//zzn_weak_property(UIPickerView*,name,__VA_ARGS__)
////UIWebView
//#define weakWebView_(name,...) \
//zzn_weak_property(UIWebView*,name,__VA_ARGS__)
////自定义类
//#define weakDIYObj_(class,name,...) \
//zzn_weak_property(class*,name,__VA_ARGS__)
//
////delegate
//#define Delegate_(class,name) \
//zzn_weak_property(id<class>,name)
//
//
///** base */
//
////copy && DIY
//#define zzn_copy_property(class,var,...) \
//zzn_set_property(class,var,copy,__VA_ARGS__)
////strong && DIY
//#define zzn_strong_property(class,var,...) \
//zzn_set_property(class,var,strong,__VA_ARGS__)
////weak && DIY
//#define zzn_weak_property(class,var,...) \
//zzn_set_property(class,var,weak,__VA_ARGS__)
////assign && DIY
//#define zzn_assign_property(class,var,...) \
//zzn_set_property(class,var,assign,__VA_ARGS__)
////DIY
//#define zzn_diy_property(class,var,...) \
//zzn_set_property(class,var,__VA_ARGS__)
////block
//#define zzn_set_block(class,name,...) \
//zzn_set_property(class,(^name)(__VA_ARGS__),copy)
//
////baseMacro
//#define zzn_set_property(class,var,...) \
//@property (nonatomic, __VA_ARGS__) class var;



















#endif /* Macro_h */
