//
//  CommunityController.m
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/29.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "CommunityController.h"
#import "Header.h"

@interface CommunityController ()

@end

@implementation CommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"id"] = @"123";
    para[@"msg"] = @"new";
    
    [[HttpManager shareManager]postDataWithURL:@"" parameters:para success:^(id responseObject) {
        NSLog(@"result=======%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"error===========%@",error);
    }];
    
    
    [[HttpManager shareManager]getNetWorkStatus];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
