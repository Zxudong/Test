//
//  XDTabBar.m
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/29.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "XDTabBar.h"
#import "Header.h"


static UIButton *plusButton;


@implementation XDTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加主题更换通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ThemeChanged:) name:@"ThemeChanged" object:nil];
        
        NSString *colorString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemeColor"];
        if (colorString != nil) {
#pragma mark 按钮选中颜色
//            [self setTintColor:[Header toUIColorByStr:colorString]];
#pragma mark 设置tabbar背景色
            [self setBarTintColor:[Header toUIColorByStr:colorString]];
        }else{
            [self setTintColor:[UIColor orangeColor]];//默认颜色
            [self setBarTintColor:[UIColor orangeColor]];
        }
        
        
        
        [self addPlusButton];
    }
    return self;
}
//添加按钮
-(void)addPlusButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:@"tab_publish_nor"] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    plusButton = button;
    [self addSubview:button];
}
//点击事件
-(void)clickAction:(UIButton *)sender{
    
    if (self.Delegate && [self.Delegate respondsToSelector:@selector(didSelectedPlusButton:)]) {
        [self.Delegate didSelectedPlusButton:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width / 5;
    CGFloat height = 49;
    CGFloat x = (self.frame.size.width - width) / 2;
    CGFloat y = 0;
    //添加按钮的frame
    plusButton.frame = CGRectMake(x, y , width, height);
    
    NSInteger index = 0;
    // 判断是否为控制器按钮
    for (UIView *childView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([childView.class isSubclassOfClass:class]) {
            childView.x = index * width;
            childView.width = width;
            index++;
            if (index == 2) {
                index ++;
            }
        }
    }
}

#pragma mark -主题更换
-(void)ThemeChanged:(NSNotificationCenter *)sender{
    
    NSString *colorString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemeColor"];
    if (colorString != nil) {
#pragma mark 按钮选中颜色
//        [self setTintColor:[Header toUIColorByStr:colorString]];
#pragma mark 设置tabbar背景色
        [self setBarTintColor:[Header toUIColorByStr:colorString]];
    }
//    [self setBarTintColor:[UIColor clearColor]];
    
}


+ (instancetype)tabBar
{
    return [[self alloc] init];
}

@end
