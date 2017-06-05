//
//  ADController.m
//  TabbarTest
//
//  Created by 赵旭东 on 2017/1/6.
//  Copyright © 2017年 赵旭东. All rights reserved.
//

#import "ADController.h"
#import "Header.h"
#import <StoreKit/StoreKit.h>



static NSURLRequest *request;
static UIButton *button;

@interface ADController ()<UIWebViewDelegate,SKStoreProductViewControllerDelegate>

@property(nonatomic,strong) UIWebView *webView;

@end

@implementation ADController

- (void)viewDidLoad {
    [super viewDidLoad];
    request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/dan-dong-shi-gong-ji-jin/id1180885681?mt=8"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithPic:@"push" Highlighted:@"s" Target:self Action:@selector(dismissView) Size:((CGSize){12,22})];
    //    [self.view addSubview:self.webView];
    
    
    
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    //设置代理请求为当前控制器本身
    storeProductViewContorller.delegate = self;
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters:
     //appId唯一的
     @{SKStoreProductParameterITunesItemIdentifier : @"1180885681"} completionBlock:^(BOOL result, NSError *error) {
         //block回调
         if(error){
             NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
         }else{
             //模态弹出appstore
             [self presentViewController:storeProductViewContorller animated:YES completion:^{
                 
             }];
         }
     }];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
        [_webView loadRequest:request];
    }
    return _webView;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [button removeFromSuperview];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:@"重新加载" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [button setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    button.center = self.view.center;
    [button addTarget:self action:@selector(loadAgain) forControlEvents:(UIControlEventTouchUpInside)];
    [self.webView addSubview:button];
}

-(void)loadAgain{
    if (button) {
        [button removeFromSuperview];
        [self.webView loadRequest:request];
    }
}




-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];
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
