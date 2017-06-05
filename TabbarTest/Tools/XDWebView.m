//
//  XDWebView.m
//  WKWebView
//
//  Created by 赵旭东 on 2017/2/9.
//  Copyright © 2017年 shineyue. All rights reserved.
//

#import "XDWebView.h"
#import "Macro.h"
#import <WebKit/WebKit.h>


static UIColor *progresscolor;

@interface XDWebView()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end


@implementation XDWebView


- (instancetype)initWithFrame:(CGRect)frame
                      withUrl:(NSString *)urlStr{
    if (self = [super initWithFrame:frame]) {
        [self setAttribute];
        
        [self addWebViewWithUrl:urlStr];
        
    }
    
    return self;
}

//设置基础属性
-(void)setAttribute{
    progresscolor = [UIColor redColor];//进度条默认颜色
    self.backgroundColor = [UIColor clearColor];
}


-(void)addWebViewWithUrl:(NSString *)url{
    if (url.length > 0) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self.webView loadRequest:request];
        [self addSubview:self.webView];
        [self addSubview:self.progressView];
    }
}




-(void)setProgressColor:(UIColor *)progressColor{
    progresscolor = progressColor;
    self.progressView.progressTintColor = progresscolor;
}


#pragma mark -懒加载
-(WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 设置偏好设置
        config.preferences = [[WKPreferences alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        // 默认认为YES
        config.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        //  // web内容处理池
        config.processPool = [[WKProcessPool alloc] init];
        // 通过JS与webview内容交互
        config.userContentController = [[WKUserContentController alloc] init];
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        
        _webView.backgroundColor = [UIColor clearColor];
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    return _webView;
}

//进度条
- (UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView  = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 10)];
        [_progressView setAlpha:1.0f];
        _progressView.progressTintColor = progresscolor;
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}
#pragma mark -others

// 设置progressView进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual: @"estimatedProgress"] && object == _webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if(_webView.estimatedProgress >= 1.0f)  {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}





@end
