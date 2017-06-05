//
//  UIView+Edit.h
//  Utils
//
//  Created by 赵旭东 on 2016/12/15.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Edit)

@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat centerX;
@property (nonatomic,assign)CGFloat centerY;

/**
 *  快速根据xib创建View
 */
+ (instancetype)viewFromXib;

@end
