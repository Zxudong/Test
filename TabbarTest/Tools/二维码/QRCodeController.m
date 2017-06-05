//
//  QRCodeController.m
//  Utils
//
//  Created by 赵旭东 on 2016/12/27.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "QRCodeController.h"
#import "Header.h"
#import "QRService.h"
#import "WKWeb.h"

@interface QRCodeController ()


@property (nonatomic,strong)UIView *maskView;

//扫描区域
@property (nonatomic, strong) UIView *scanWindow;
//扫描动画
@property (nonatomic,strong)UIImageView *scanAnimationView;

//占位提示框
@property (nonatomic,strong)UILabel *placeholderLabel;

@end

@implementation QRCodeController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.maskView addSubview:self.placeholderLabel];
    
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view.layer removeAnimationForKey:@"scanAnimation"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    
    if (self.placeholderLabel) {
        [self.placeholderLabel removeFromSuperview];
    }
    //添加扫描区域
    [self startScaning];
    //添加挡板
    [self.view addSubview:self.maskView];
    //功能模块
    [self addMainView];
    //边角修饰
    [self addCorner];
    //扫描动画
    [self resumeAnimation];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //应用从后台进入前台处理
    [kNotificationCenter addObserver:self selector:@selector(resumeAnimation) name:@"QRCodeAnmation" object:nil];
    
    
}

#pragma mark -扫描部分及回调
- (void)startScaning{
    [self.view.layer insertSublayer:[[QRService shared] scanQRImage:self.scanWindow.bounds viewSize:self.view.frame result:^(NSString *aQRCode) {
        WKWeb *webView = [WKWeb new];
        if ([CheckDataTool checkForURL:aQRCode]) {
            webView.url = aQRCode;
            [self.navigationController pushViewController:webView animated:YES];
        }else{
            ULog(@"错误的地址");
        }
        
        
    }] atIndex:0];
}

#pragma mark -懒加载

#pragma mark -扫描图层
- (UIView *)scanWindow{
    if (_scanWindow == nil) {
        _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, SCREEN_WIDTH - 60)];
        _scanWindow.center = self.maskView.center;
        _scanWindow.clipsToBounds = YES;
        [self.view addSubview:_scanWindow];
    }
    return _scanWindow;
}


#pragma mark -扫描动画层
-(UIImageView *)scanAnimationView{
    if (!_scanAnimationView) {
        _scanAnimationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_net"]];
        _scanAnimationView.frame = CGRectMake(0, -SCREEN_WIDTH + 60, SCREEN_WIDTH - 60, SCREEN_WIDTH - 60);
        [self.scanWindow addSubview:_scanAnimationView];
    }
    return _scanAnimationView;
}


#pragma mark -挡板
- (UIView *)maskView{
    if (_maskView == nil) {
        
        _maskView = [[UIView alloc] init];
        _maskView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
        _maskView.layer.borderWidth = 94;
        _maskView.bounds = CGRectMake(0, 0, SCREEN_WIDTH + 96 + 30 , SCREEN_WIDTH + 96 + 30);
        _maskView.centerX = self.view.centerX;
        _maskView.y = 64;
    }
    return _maskView;
}
#pragma mark -展位显示框
-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 30)];
        label.text = @"正在准备...";
        label.textColor = [UIColor orangeColor];
        label.centerX = SCREEN_WIDTH / 2 + 80;
        label.centerY = self.maskView.centerY - 64;
        label.textAlignment = NSTextAlignmentCenter;
        _placeholderLabel = label;
    }
    return _placeholderLabel;
}


#pragma mark -扫描动画
-(void)resumeAnimation{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.byValue = @(self.scanAnimationView.height);
    animation.duration = 1.0;
    animation.repeatCount = MAXFLOAT;
    [self.scanAnimationView.layer addAnimation:animation forKey:@"scanAnimation"];
}


/*添加交互*/
-(void)addMainView{
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.maskView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.maskView.frame))];
    vi.backgroundColor = [UIColor redColor];
    [self.view addSubview:vi];
}
-(void)addCorner{
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    image1.image = [UIImage imageNamed:@"scan_1"];
    [self.scanWindow addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.scanWindow.width-20, 0, 20, 20)];
    image2.image = [UIImage imageNamed:@"scan_2"];
    [self.scanWindow addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.scanWindow.height-20, 20, 20)];
    image3.image = [UIImage imageNamed:@"scan_3"];
    [self.scanWindow addSubview:image3];
    
    UIImageView *image4 = [[UIImageView alloc]initWithFrame:CGRectMake(self.scanWindow.width-20, self.scanWindow.height-20, 20, 20)];
    image4.image = [UIImage imageNamed:@"scan_4"];
    [self.scanWindow addSubview:image4];
}















@end
