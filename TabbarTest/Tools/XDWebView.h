//
//  XDWebView.h
//  WKWebView
//
//  Created by 赵旭东 on 2017/2/9.
//  Copyright © 2017年 shineyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDWebView : UIView

/**
 进度条颜色(默认为红色)
 */
@property(nonatomic,strong) UIColor *progressColor;

- (instancetype)initWithFrame:(CGRect)frame
                      withUrl:(NSString *)urlStr;


@end
