//
//  UITabBar+badge.h
//  TabbarTest
//
//  Created by 赵旭东 on 2017/1/5.
//  Copyright © 2017年 赵旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
