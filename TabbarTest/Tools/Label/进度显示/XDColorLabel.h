//
//  XDColorLabel.h
//  UIViewAnimation
//
//  Created by 赵旭东 on 2017/1/22.
//  Copyright © 2017年 Addict. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDColorLabel : UILabel

/** 进度 */
@property (nonatomic,assign) CGFloat progress;

/** 颜色 */
@property (nonatomic,strong) UIColor *currentColor;

@end
