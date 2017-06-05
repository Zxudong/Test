//
//  HomeController.m
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/29.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "HomeController.h"
#import "Header.h"
#import "XD_Tools.h"

#define GCDMain(block) dispatch_async(dispatch_get_main_queue(), block)



static NSInteger buttonCount = 10;
static NSInteger topListViewHeight = 50;
static NSInteger topButtonTag = 1300;

@interface HomeController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    RKNotificationHub *barHub;
    NSArray *topButtonTitleArray;
    NSInteger temIndex;
    NSInteger buttonTemIndex;
    CGFloat oldOffset;
}

@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UILabel *titleLable;

@property(nonatomic,strong) UIScrollView *topListView;
@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong) UIScrollView *mainScorllerView;



@end

@implementation HomeController





-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //小红点
    [self.tabBarController.tabBar showBadgeOnItemIndex:1];
    [self.tabBarItem setBadgeValue:@"2"];
    
    self.navigationController.navigationBar.hidden = YES;
    //添加主题更换通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ThemeChanged:) name:@"ThemeChanged" object:nil];
    
    [self.view addSubview:self.topListView];
    [self.view addSubview:self.navView];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    topButtonTitleArray = @[@"全部",@"视频",@"图片",@"段子",@"原创",@"网红",@"美女",@"冷知识",@"游戏",@"声音"];

    
    [self.view addSubview:self.mainScorllerView];
    
    
    // Do any additional setup after loading the view.
}




#pragma mark -mainScrollerView

-(UIScrollView *)mainScorllerView{
    if (!_mainScorllerView) {
        _mainScorllerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topListView.frame), SCREEN_WIDTH, SCREEN_HEIGHT- CGRectGetMaxY(self.topListView.frame))];

//            _mainScorllerView.backgroundColor = [UIColor greenColor];
        
        _mainScorllerView.contentSize = CGSizeMake(SCREEN_WIDTH * buttonCount, SCREEN_HEIGHT- CGRectGetMaxY(self.navView.frame));
        _mainScorllerView.bounces = NO;
        _mainScorllerView.pagingEnabled = YES;
        _mainScorllerView.showsVerticalScrollIndicator = NO;
        _mainScorllerView.showsHorizontalScrollIndicator = NO;
        _mainScorllerView.scrollsToTop = YES;
        _mainScorllerView.alwaysBounceVertical = NO;
        _mainScorllerView.delegate = self;
        
        for (int i = 0; i < buttonCount; i++) {
            UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, _mainScorllerView.height-44) style:(UITableViewStylePlain)];
            table.delegate = self;
            table.dataSource = self;
            table.bounces = YES;
            [_mainScorllerView addSubview:table];
        }
        
        
    }
    return _mainScorllerView;
}

#pragma mark -topListView
-(UIScrollView *)topListView{
    if (!_topListView) {
        _topListView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), SCREEN_WIDTH, topListViewHeight)];
        _topListView.contentSize = CGSizeMake(SCREEN_WIDTH/6*buttonCount, topListViewHeight);
        _topListView.showsVerticalScrollIndicator = NO;
        _topListView.showsHorizontalScrollIndicator = NO;
        
        
        NSString *colorString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemeColor"];
        if (colorString) {//判断是否更换主题颜色
            _topListView.backgroundColor = [Header toUIColorByStr:colorString];;
        }else{
            _topListView.backgroundColor = [UIColor orangeColor];//默认橙色
        }
    
        for (int i = 0; i < buttonCount ; i++) {
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            button.frame  = CGRectMake(0, 0, SCREEN_WIDTH/6, 20);
            button.center = CGPointMake(SCREEN_WIDTH/6*i + SCREEN_WIDTH/6/2,30);
            [button setTitle:topButtonTitleArray[i] forState:(UIControlStateNormal)];
            [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
            button.tag = topButtonTag + i;
            [_topListView addSubview:button];
            
        }
        
        [_topListView addSubview:self.maskView];
        
    }
    return _topListView;
}

-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, topListViewHeight-2, SCREEN_WIDTH/6, 2)];
        _maskView.backgroundColor = [UIColor whiteColor];
    }
    return _maskView;
}
 
#pragma mark -UIScrollViewDelegate
//结束减速执行的方法345678
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    if (temIndex > index &&( temIndex == 6 || temIndex == 5)) {
        [UIView animateWithDuration:0.5 animations:^{
            self.mainScorllerView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
            self.topListView.contentOffset = CGPointMake(0, 0);
            self.maskView.x =  SCREEN_WIDTH/6 * index;
        }];
        
    }else if (index == 5){
        [UIView animateWithDuration:0.5 animations:^{
            self.mainScorllerView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
            self.topListView.contentOffset = CGPointMake(SCREEN_WIDTH-SCREEN_WIDTH/3, 0);
            self.maskView.x =  SCREEN_WIDTH/6 * index;
        }];
    }else if (index == 4 && temIndex > 4){
        [UIView animateWithDuration:0.5 animations:^{
            self.mainScorllerView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
            self.topListView.contentOffset = CGPointMake(0, 0);
            self.maskView.x =  SCREEN_WIDTH/6 * index;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.mainScorllerView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
            self.maskView.x =  SCREEN_WIDTH/6 * index;
        }];
    }
    temIndex = index;

}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    if (scrollView.contentOffset.y > oldOffset) {
//            NSLog(@"==========%f",scrollView.contentOffset.y);
//            [UIView animateWithDuration:0.2 animations:^{
//                self.navView.y = -self.navView.height;
//                self.topListView.y = self.navView.y+self.navView.height;
//                self.mainScorllerView.y = CGRectGetMaxY(self.topListView.frame);
//                self.mainScorllerView.height += CGRectGetMaxY(self.topListView.frame);
//            }];
//            
//        NSLog(@"向上滑动");
//        
//    }else{
//            NSLog(@"--------------%f",scrollView.contentOffset.y);
//            [UIView animateWithDuration:0.2 animations:^{
//                self.navView.y = 0;
//                self.topListView.y = self.navView.y+self.navView.height;
//                self.mainScorllerView.y = CGRectGetMaxY(self.topListView.frame);
//                self.mainScorllerView.height = SCREEN_HEIGHT- CGRectGetMaxY(self.topListView.frame);
//            }];
//
//        NSLog(@"============向下滑动");
//    }
//    
//    oldOffset = scrollView.contentOffset.y;
    
//}


#pragma mark -点击事件

-(void)clickAction:(UIButton *)sender{
    NSInteger index = sender.tag - topButtonTag;
    
    if (buttonTemIndex > index &&( buttonTemIndex == 6 || buttonTemIndex == 5)) {
        [UIView animateWithDuration:0.5 animations:^{
             self.mainScorllerView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
            self.topListView.contentOffset = CGPointMake(0, 0);
            self.maskView.x =  SCREEN_WIDTH/6 * index;
        }];
        
    }else if (index == 5){
        [UIView animateWithDuration:0.5 animations:^{
             self.mainScorllerView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
            self.topListView.contentOffset = CGPointMake(SCREEN_WIDTH-SCREEN_WIDTH/3, 0);
            self.maskView.x =  SCREEN_WIDTH/6 * index;
        }];
    }else if (index == 4 && buttonTemIndex > 4){
        [UIView animateWithDuration:0.5 animations:^{
             self.mainScorllerView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
            self.topListView.contentOffset = CGPointMake(0, 0);
            self.maskView.x =  SCREEN_WIDTH/6 * index;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
             self.mainScorllerView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
            self.maskView.x =  SCREEN_WIDTH/6 * index;
        }];
    }
    buttonTemIndex = index;
}






















#pragma mark -nav
-(UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        NSString *colorString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemeColor"];
        if (colorString) {//判断是否更换主题颜色
            _navView.backgroundColor = [Header toUIColorByStr:colorString];;
        }else{
            _navView.backgroundColor = [UIColor orangeColor];//默认橙色
        }
        [_navView addSubview:self.titleLable];

    }
    return _navView;
}
#pragma mark -title
-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 27, 100, 30)];;
        _titleLable.centerX = self.view.centerX;
        _titleLable.text = @"百思不得其姐";
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.adjustsFontSizeToFitWidth = YES;
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = [UIFont fontWithName:@"Heiti SC" size:20];
    }
    return _titleLable;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"homeTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:Identifier];
    }
    cell.textLabel.text = @"测试测试测试";
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ThemeChangeController *VC = [ThemeChangeController new];
//    [self.navigationController pushViewController:VC animated:YES];
//}







#pragma mark -主题更换
-(void)ThemeChanged:(NSNotificationCenter *)sender{
    
    NSString *colorString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemeColor"];
    if (colorString) {//判断是否更换主题颜色
        self.navView.backgroundColor = [Header toUIColorByStr:colorString];
        self.topListView.backgroundColor = [Header toUIColorByStr:colorString];
    }else{
        self.navView.backgroundColor = [UIColor orangeColor];//默认橙色
        self.topListView.backgroundColor = [UIColor orangeColor];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
