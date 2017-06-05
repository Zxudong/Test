
//
//  WKWeb.m
//  Utils
//
//  Created by 赵旭东 on 2016/12/27.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "WKWeb.h"
#import <WebKit/WebKit.h>
#import "Header.h"

@interface WKWeb ()

/**
 进度条动画层
 */
@property(nonatomic,strong)CALayer *progresslayer;

/**
 WKWebView
 */
@property (nonatomic,strong)WKWebView *web;

@property (nonatomic,strong)WKWeb *mainWeb;


@end

@implementation WKWeb


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addProgressView];//进度框
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.web  removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.web];;//WKWebView

}






























#pragma mark -进度条
-(void)addProgressView{
    [self.web addObserver:self forKeyPath:@"estimatedProgress" options:(NSKeyValueObservingOptionNew) context:nil];
    UIView *progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
    progressView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progressView];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [progressView.layer addSublayer:layer];
    self.progresslayer = layer;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        
        self.progresslayer.frame = CGRectMake(0, 0, SCREEN_WIDTH*[change[@"new"] floatValue], 3);
        
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
        
    }else{
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        
    }
    
}


#pragma mark -懒加载
-(WKWebView *)web{
    if (!_web) {
        _web = [[WKWebView alloc]initWithFrame:self.view.bounds];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
        [_web loadRequest:request];
    }
    return _web;
}

-(WKWeb *)mainWeb{
    if (!_mainWeb) {
        _mainWeb = [WKWeb new];
    }
    return _mainWeb;
}
















@end
