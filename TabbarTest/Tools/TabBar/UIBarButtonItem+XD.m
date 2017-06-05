//
//  UIBarButtonItem+XD.m
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/30.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "UIBarButtonItem+XD.h"

@implementation UIBarButtonItem (XD)

+ (UIBarButtonItem *)itemWithPic:(NSString *)pic Highlighted:(NSString *)highlightedPic Target:(id)target Action:(SEL)action Size:(CGSize)size
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:pic] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedPic] forState:UIControlStateHighlighted];
    
    btn.bounds = CGRectMake(0, 0, size.width, size.height);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (UIBarButtonItem *)itemWithTitle:(NSString *)title Target:(id)target Action:(SEL)action
{
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    titleBtn.bounds = (CGRect){0,0,50,40};
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // [titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [titleBtn setTitle:title forState:UIControlStateNormal];
    
    [titleBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:titleBtn];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title Target:(id)target Action:(SEL)action Size:(CGSize)size
{
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    titleBtn.bounds = (CGRect){0,0,size};
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [titleBtn setTitle:title forState:UIControlStateNormal];
    
    [titleBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:titleBtn];
    
}

@end
