//
//  XDViewController.m
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/30.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "XDViewController.h"
#import "XD_Tools.h"

@interface XDViewController ()


@end

@implementation XDViewController






-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //接收点击自定义按钮事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickPlusButton:) name:@"didSelectedPlusButton" object:nil];
}

-(void)clickPlusButton:(NSNotificationCenter *)sender{
    NSLog(@"主控制器");
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
