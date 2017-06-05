//
//  CheckDataTool.h
//  Utils
//
//  Created by 赵旭东 on 2016/12/14.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckDataTool : NSObject

/**
 邮箱验证

 *  @param email 邮箱
 *  @return YES:正确  NO:失败
 */
+ (BOOL) checkForEmail:(NSString *)email;

/**
 手机号验证
 
 *  @param mobilePhone 手机号
 *  @return YES:正确  NO:失败
 */
+(BOOL)checkForMobilePhoneNo:(NSString *)mobilePhone;

/**
 电话号验证
 *
 *  @param phone 电话号
 *  @return 结果
 */
+(BOOL)checkForPhoneNo:(NSString *)phone;

/**
 身份证号验证(15位 或 18位)
 
 *  @param idCard 身份证号
 *  @return YES:正确  NO:失败
 */
+(BOOL)checkForIdCard:(NSString *)idCard;


/**
 由数字和26个英文字母组成的字符串
 *
 *  @param data 数据
 *  @return 结果
 */
+ (BOOL) checkForNumberAndCase:(NSString *)data;


/**
 校验只能输入26位小写字母
 
 *  @param data 数据
 *  @return 结果
 */
+ (BOOL) checkForLowerCase:(NSString *)data;

/**
 校验只能输入26位大写字母
 
 *  @param data 数据
 *  @return 结果
 */
+ (BOOL) checkForUpperCase:(NSString *)data;

/**
 *  校验只能输入由26个小写英文字母组成的字符串
 *
 *  @param data 字符串
 *
 *  @return 结果
 */
+ (BOOL) checkForLowerAndUpperCase:(NSString *)data;

/**
 是否含有特殊字符(%&’,;=?$\等)
 
 *  @param data 数据
 *  @return 结果
 */
+ (BOOL) checkForSpecialChar:(NSString *)data;


/**
 校验只能输入数字
 
 *  @param number 数字
 *  @return 结果
 */
+ (BOOL) checkForNumber:(NSString *)number;

/**
 校验只能输入n位的数字
 
 *  @param length n位
 *  @param number 数字
 *  @return 结果
 */
+ (BOOL) checkForNumberWithLength:(NSString *)length number:(NSString *)number;

/**
 校验只能输入中文

 @param str 字符串
 @return 结果
 */
+ (BOOL)checkForeChinese:(NSString *)str;

/**
 车牌号验证

 @param CarNumber 车牌号
 @return 结果
 */
+ (BOOL) checkCarNumber:(NSString *) CarNumber;

/**
 正则匹配银行卡号是否正确

 @param bankNumber 银行卡号
 @return 结果
 */
+ (BOOL) checkBankNumber:(NSString *) bankNumber;

/**
 检验url

 @param urlString url字符串
 @return 结果
 */
+(BOOL) checkForURL:(NSString *)urlString;

/**
 判断字符串中是否含有表情
 
 @param string 传入的字符串
 @return 返回YES即含有表情
 */
+ (BOOL)checkStringContainsEmoji:(NSString *)string;








@end
