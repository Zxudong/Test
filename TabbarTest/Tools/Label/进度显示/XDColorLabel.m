
//
//  XDColorLabel.m
//  UIViewAnimation
//
//  Created by 赵旭东 on 2017/1/22.
//  Copyright © 2017年 Addict. All rights reserved.
//

#import "XDColorLabel.h"

@implementation XDColorLabel

- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    
    [super drawRect:rect];
    // 设置颜色
    [self.currentColor set];
    rect.size.width *= self.progress;
    
    // 图形混合模式
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    //    UIRectFill(rect);
    //    UIRectFrame(rect);
    //    UIRectFrameUsingBlendMode(rect, kCGBlendModeOverlay);
}

- (UIColor *)currentColor {
    
    if (_currentColor == nil) {
        _currentColor = [UIColor greenColor];
    }
    return _currentColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
