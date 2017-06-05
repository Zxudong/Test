//
//  ClassifyController.m
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/29.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "ClassifyController.h"
#import "Header.h"
#import "DDRichTextViewController.h"
@interface ClassifyController ()

@property(nonatomic,strong)AFHTTPSessionManager *manager;



@end

@implementation ClassifyController



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏小红点
    [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
    
    
    
    

    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    

    // Do any additional setup after loading the view.
}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"Wechat://name=zhaoxudong"] options:@{@"name":@"tanghaichao"} completionHandler:nil];
    DDRichTextViewController *vc = [[DDRichTextViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
