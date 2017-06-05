//
//  ButtonSet.m
//  Layer_Test
//
//  Created by 赵旭东 on 2017/1/1.
//  Copyright © 2017年 赵旭东. All rights reserved.
//

#import "ButtonSet.h"
#import "XD_Tools.h"

static NSInteger ButtonSetTagBegin = 1000;

static UIButton *button;
static NSMutableArray *buttonSet;

typedef void(^clickAction)(NSInteger index);
static clickAction actionBlock;

@implementation ButtonSet


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
//        self.alpha = 0.1;
        [self insertTransparentGradient];
    }
    return self;
}


+(instancetype)share{
    static ButtonSet *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[ButtonSet alloc]initWithFrame:[UIScreen mainScreen].bounds];
    });
    return share;
}


-(void)addButtonSetWithDisplayWidth:(CGFloat)radius buttonSize:(CGSize)buttonSize imageArray:(NSArray *)imageArray andActionHandler:(void(^)(NSInteger index))actionHandler{
    
    CGFloat buttonCount = imageArray.count;
    buttonSet = [NSMutableArray arrayWithCapacity:buttonCount];
    
    for (int i = 0;  i < buttonCount; i++) {
        button = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        button.backgroundColor = RANDOM_COLOR;
        button.tag = ButtonSetTagBegin+i;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[i]]] forState:(UIControlStateNormal)];
        actionBlock = actionHandler;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        CGFloat width = buttonSize.width;
        CGFloat height = buttonSize.height;
        
        CGFloat centerX =  ((i * (radius*2/buttonCount)) + width) + (self.center.x - radius);
        //-radius/1.5  控制y的 高度
        CGFloat centerY = - (radius/1.5*sinf(M_PI/(buttonCount-1)*i) + height) + self.frame.size.height;
        
        //对中心点左右两边做处理
        if (i > 0 && i < (buttonCount-1)/2) {
            centerX -= width/2;
            centerY += height/(buttonCount-1);
        }
        if (i > (buttonCount-1)/2 && i < buttonCount-1) {
            centerX += width/2;
            centerY += height/(buttonCount-1);
        }
        
        //发射点
        button.frame = CGRectMake(SCREEN_WIDTH/2,SCREEN_HEIGHT - 44/2 , 0, 0);
        
        //show animation
        [UIView beginAnimations:@"buttonset" context:nil];
        [UIView setAnimationDuration:0.5];
        button.frame = CGRectMake(0, 0, width, height);
        button.center = CGPointMake(centerX, centerY);
        [UIView commitAnimations];
        //添加到数组
        [buttonSet addObject:button];
        
        [self addSubview:button];
    }
}
///button action
-(void)clickAction:(UIButton *)action{
    NSInteger btnTag = action.tag - ButtonSetTagBegin;
    actionBlock(btnTag);
}



///dismiss

-(void)dismiss{
    //post视图移除后的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeCancelButton" object:nil];
    
    for (UIButton *btn in buttonSet) {
        [UIView beginAnimations:@"hiddenButtonSet" context:nil];
        [UIView setAnimationDuration:0.5];
        //聚合点
        btn.frame = CGRectMake(SCREEN_WIDTH/2,SCREEN_HEIGHT - 44/2 , 0, 0);
        [UIView commitAnimations];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}


#pragma mark -透明度渐变
- (void) insertTransparentGradient {
    
    UIColor *colorOne = [UIColor colorWithRed:(239/255.0)  green:(239/255.0)  blue:(239/255.0)  alpha:0.99];
    UIColor *colorTwo = [UIColor colorWithRed:(239/255.0)  green:(239/255.0)  blue:(239/255.0)  alpha:0.99];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.99];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.99];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    //crate gradient layer
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = self.bounds;
    [self.layer insertSublayer:headerLayer atIndex:0];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
