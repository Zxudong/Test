//
//  UIBarButtonItem+XD.h
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/30.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XD)

#pragma mark - 自定义UIBarButtonItem
+ (UIBarButtonItem *)itemWithPic:(NSString *)pic Highlighted:(NSString *)highlightedPic Target:(id)target Action:(SEL)action Size:(CGSize)size;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title Target:(id)target Action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title Target:(id)target Action:(SEL)action Size:(CGSize)size;

@end
