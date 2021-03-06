//
//  UITabBar+badge.m
//  TabbarTest
//
//  Created by 赵旭东 on 2017/1/5.
//  Copyright © 2017年 赵旭东. All rights reserved.
//

#import "UITabBar+badge.h"

static NSInteger tabBarItemNumber = 5;
static CGFloat badgeWidth = 10;
static NSInteger badgeTag = 1100;

@implementation UITabBar (badge)

//显示小红点
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = badgeTag + index;
    badgeView.layer.cornerRadius = badgeWidth/2;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    

    
    //确定小红点的位置
    float percentX = (index +0.6) / tabBarItemNumber;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, badgeWidth, badgeWidth);//圆形大小为10
    [self addSubview:badgeView];
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == badgeTag+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
