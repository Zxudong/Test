//
//  ThemeChangeController.m
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/29.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "ThemeChangeController.h"
#import "Header.h"
#import "XDThemeCell.h"

static NSString *ThemeChangeCell = @"ThemeChangeCell";
static NSString *imageCollectionCell = @"imageCollectionCell";
static NSString *CellForHeader = @"CellForHeader";


@interface ThemeChangeController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong) UICollectionViewFlowLayout *layout;

@end

@implementation ThemeChangeController

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//            NSString *colorString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemeColor"];
//            if (colorString) {//判断是否更换主题颜色
//                vi.backgroundColor = [Header toUIColorByStr:colorString];;
//            }else{
//                vi.backgroundColor = [UIColor orangeColor];//默认橙色
//            }
//    [self.view addSubview:vi];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"换肤";
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}


#pragma mark -懒加载

-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = (self.view.frame.size.width-80) / 3;
        _layout.itemSize = CGSizeMake(width, width);
        _layout.minimumLineSpacing = 20;
        _layout.sectionInset = UIEdgeInsetsMake(10, 0,10, 0);
        //(头)size
        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30);
    }
    return _layout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, self.view.frame.size.height-20) collectionViewLayout:self.layout];
        _collectionView.contentInset = UIEdgeInsetsMake(10, 0,10, 0);
        //注册系统cell 颜色显示
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ThemeChangeCell];
        //注册自定义cell  图片显示
        [_collectionView registerNib:[UINib nibWithNibName:@"XDThemeCell" bundle:nil] forCellWithReuseIdentifier:imageCollectionCell];
        //注册区头视图
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellForHeader];
        
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else{
        return 5;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ThemeChangeCell forIndexPath:indexPath];
        
        cell.backgroundColor = RANDOM_COLOR;
        cell.layer.cornerRadius = 5;
        return cell;
    }
    else{
        XDThemeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCollectionCell forIndexPath:indexPath];
        cell.itemImageView.image = [UIImage imageNamed:@"Q-1.jpg"];
        
        return cell;
        
    }

}
//区头视图

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = @[@"纯色主题",@"个性主题"];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CellForHeader forIndexPath:indexPath];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, header.frame.size.height)];
            label.text = arr[indexPath.section];
            [header addSubview:label];
            
            return header;
        }else{
            return nil;
        }
    

}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *string= [Header toStrByUIColor:cell.backgroundColor];
    // 取出cell
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"ThemeColor"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ThemeChanged" object:nil];
}


@end
