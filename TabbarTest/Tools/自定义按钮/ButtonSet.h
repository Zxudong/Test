//
//  ButtonSet.h
//  Layer_Test
//
//  Created by 赵旭东 on 2017/1/1.
//  Copyright © 2017年 赵旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonSet : UIView



+(instancetype)share;



/**
 添加目标按钮视图

 @param radius button视图所占宽度
 @param buttonSize button的size
 @param imageArray button的背景图片
 @param actionHandler 点击事件回调
 */
-(void)addButtonSetWithDisplayWidth:(CGFloat)radius buttonSize:(CGSize)buttonSize imageArray:(NSArray *)imageArray andActionHandler:(void(^)(NSInteger index))actionHandler;


/**
 移除视图
 */
-(void)dismiss;


@end
