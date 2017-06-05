//
//  UIImage+Edit.h
//  Utils
//
//  Created by 赵旭东 on 2016/12/15.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Edit)

/**
 生成一个圆形图片

 @param name 图片名
 @return 结果
 */
+ (instancetype)circleImageNamed:(NSString *)name;


/**
 根据颜色生成一个纯色的图片

 @param color 目标颜色
 @return 对应的纯色图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color;

@end
