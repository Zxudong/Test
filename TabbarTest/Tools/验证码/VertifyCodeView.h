//
//  VertifyCodeView.h
//  Utils
//
//  Created by 赵旭东 on 2016/12/14.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VertifyCodeView : UIView

@property (nonatomic, retain) NSArray *changeArray;
@property (nonatomic, retain) NSMutableString *changeString;
/**
 *  重置验证码
 */
-(void)changeCode;
@end
