//
//  Header.h
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/29.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeController.h"
#import "ClassifyController.h"
#import "CommunityController.h"
#import "MeController.h"
#import "XDTabBar.h"
#import "XDTabBarController.h"
#import "XDNavigationController.h"
#import "ThemeChangeController.h"
#import "UIView+Edit.h"
#import "XDViewController.h"
#import "UIBarButtonItem+XD.h"
#import "XD_Tools.h"
#import "SDCycleScrollView.h"





@interface Header : NSObject


/**
 十六进制字符串转颜色

 @param colorStr 16进制颜色字符串
 @return 对应的颜色
 */
+(UIColor*)toUIColorByStr:(NSString*)colorStr;


/**
 颜色转16进制字符串

 @param color 颜色
 @return 对应的16进制颜色字符串
 */
+(NSString*)toStrByUIColor:(UIColor*)color;


@end
