//
//  XDNavigationController.m
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/29.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "XDNavigationController.h"
#import "Header.h"

@interface XDNavigationController ()<UIGestureRecognizerDelegate>
{
    UINavigationBar *navBar;
}

@end

@implementation XDNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.navigationBar.translucent = NO;
        //设置主题颜色
        navBar = [[UINavigationBar alloc]init];
#pragma mark 设置背景颜色
        
        //添加主题更换通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ThemeChanged:) name:@"ThemeChanged" object:nil];
        
        NSString *colorString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemeColor"];
        if (colorString != nil) {
            navBar.barTintColor = [Header toUIColorByStr:colorString];
        }else{
            navBar.barTintColor = [UIColor orangeColor];//默认颜色
        }
        
        
#pragma mark 设置字体颜色
        
        NSDictionary *attribute = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
        navBar.titleTextAttributes = attribute;
        [self setValue:navBar forKey:@"navigationBar"];
        
    }
    return self;
}

#pragma mark -主题更换
-(void)ThemeChanged:(NSNotificationCenter *)sender{
    NSString *colorString =  [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemeColor"];
    if (colorString != nil) {
        navBar.barTintColor = [Header toUIColorByStr:colorString];
    }else{
        navBar.barTintColor = [UIColor clearColor];//默认颜色
    }
}

#pragma mark - 重写push事件
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //修改返回按钮
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithPic:@"push" Highlighted:@"s" Target:self Action:@selector(back) Size:((CGSize){12,22})];
    }
    [super pushViewController:viewController animated:YES];
}

-(void)back{
    [self popViewControllerAnimated:YES];
}





-(void)viewDidLoad{
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}




- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
