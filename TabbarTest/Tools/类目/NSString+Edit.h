//
//  NSString+Edit.h
//  Utils
//
//  Created by 赵旭东 on 2016/12/14.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Edit)

/**
 数字转繁体中文
 */
+ (NSString *)transformArabicNumToChinese:(NSInteger)arabicNum;
/**
 *  中文转拼音
 */
- (NSString *)transformToPinyin;

/**
 *  @brief 根据字数的不同,返回UILabel中的text文字需要占用多少Size
 *  @param size 约束的尺寸
 *  @param font 文本字体
 *  @return 文本的实际尺寸
 */
- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param width 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际高度
 */
- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param height 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font;

@end
