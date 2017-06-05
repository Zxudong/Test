//
//  XDTabBarController.m
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/29.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "XDTabBarController.h"
#import "Header.h"

@interface XDTabBarController ()<DidSelectedPlusButtonDelegate>

@property(nonatomic,strong)ButtonSet *buttonView;
@property(nonatomic,strong) UIButton *cancelButton;

@end

@implementation XDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XDTabBar *tabBar = [XDTabBar tabBar];
    tabBar.Delegate = self;
    //设置自定义的tabbar
    [self setValue:tabBar forKey:@"tabBar"];
    
    
    [self addChildViewController:[HomeController new] image:@"tab_home_nor" selectedImage:@"tab_home_press" title:@"Home"];
    [self addChildViewController:[ClassifyController new] image:@"tab_classify_nor" selectedImage:@"tab_classify_press" title:@"Classfy"];
    [self addChildViewController:[CommunityController new] image:@"tab_community_nor" selectedImage:@"tab_community_press" title:@"Community"];
    [self addChildViewController:[MeController new] image:@"tab_me_nor" selectedImage:@"tab_me_press" title:@"Me"];
    
    // Do any additional setup after loading the view.
}

-(UIViewController *)addChildViewController:(UIViewController *)childController
                                      image:(NSString *)image
                              selectedImage:(NSString *)selectedImage
                                      title:(NSString *)title{
    //设置标题
    childController.title = title;
    //设置字体颜色
    NSMutableDictionary *attributeNormal = [NSMutableDictionary dictionary];
    attributeNormal[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [childController.tabBarItem setTitleTextAttributes:attributeNormal forState:(UIControlStateNormal)];
    
    NSMutableDictionary *attributeSelected = [NSMutableDictionary dictionary];
    attributeSelected[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [childController.tabBarItem setTitleTextAttributes:attributeSelected forState:(UIControlStateSelected)];
    
    
    //设置图片
    [childController.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
    [childController.tabBarItem setImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)]];
    
    
    XDNavigationController *nav = [[XDNavigationController alloc]initWithRootViewController:childController];
    
    
    [self addChildViewController:nav];
    return childController;
    
}

//点击tabbar 上的自定义按钮
-(void)didSelectedPlusButton:(XDTabBar *)tabbar{
    //添加自定义按钮视图
    NSArray *array = @[@"tab_community_press",@"tab_classify_press",@"tab_me_press",@"tab_home_press",@"tab_community_press"];
    _buttonView = [[ButtonSet alloc]initWithFrame:self.view.bounds];
    _buttonView.height -= 50;
    XDWeakSelf(self)
    [_buttonView addButtonSetWithDisplayWidth:self.view.frame.size.width/3 buttonSize:CGSizeMake(40, 40) imageArray:array andActionHandler:^(NSInteger index) {
        NSLog(@"%ld",index);
        
        [weakself.buttonView dismiss];
    }];
    
    _cancelButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _cancelButton.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    _cancelButton.backgroundColor = [UIColor whiteColor];
    [_cancelButton addTarget:self action:@selector(removeView:) forControlEvents:(UIControlEventTouchUpInside)];
    [_cancelButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
//    [self insertTransparentGradient];
    [self.view addSubview:_buttonView];
    [self.view addSubview:_cancelButton];
    //添加移除视图通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeCancelButton:) name:@"removeCancelButton" object:nil];
    //post点击plus按钮通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectedPlusButton" object:nil];
}

-(void)removeCancelButton:(NSNotificationCenter *)sender{
    if(_cancelButton) [_cancelButton removeFromSuperview];
}
-(void)removeView:(UIButton *)sender{
    if (_buttonView) [_buttonView dismiss];
    if (_cancelButton) [_cancelButton removeFromSuperview];
}


#pragma mark -透明度渐变
- (void) insertTransparentGradient {
    
    UIColor *colorOne = [UIColor colorWithRed:(255/255.0)  green:(255/255.0)  blue:(255/255.0)  alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithRed:(255/255.0)  green:(255/255.0)  blue:(255/255.0)  alpha:1.0];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    //crate gradient layer
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = _cancelButton.bounds;
    [_cancelButton.layer insertSublayer:headerLayer atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
