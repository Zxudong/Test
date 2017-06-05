//
//  NSDate+Edit.h
//  Utils
//
//  Created by 赵旭东 on 2016/12/15.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Edit)

#pragma mark - 日期属性
@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component
@property (nonatomic, readonly) NSInteger day; ///< Day component
@property (nonatomic, readonly) NSInteger hour; ///< Hour component
@property (nonatomic, readonly) NSInteger minute; ///< Minute component
@property (nonatomic, readonly) NSInteger second; ///< Second component
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL isLeapMonth; ///< 是否闰月
@property (nonatomic, readonly) BOOL isLeapYear; ///< 是否闰年

#pragma mark - 日期修改
/**
 从这个日期加上N年

 @param years 需要添加的年数
 @return 修改后的date
 */
- (NSDate *)dateByAddingYears:(NSInteger)years;
/**
 从这个日期加上N月

 @param months 需要添加的月数
 @return 修改后的date
 */
- (NSDate *)dateByAddingMonths:(NSInteger)months;
/**
 从这个日期加上N周

 @param weeks 需要添加的周数
 @return 修改后的date
 */
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
/**
 从这个日期加上N天

 @param days 需要添加的天数
 @return 修改后的date
 */
- (NSDate *)dateByAddingDays:(NSInteger)days;
/**
 从这个日期加上N小时

 @param hours 需要添加的小时数
 @return 修改后的date
 */
- (NSDate *)dateByAddingHours:(NSInteger)hours;
/**
 从这个日期加上N分钟

 @param minutes 需要添加的分钟数
 @return 修改后的date
 */
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
/**
 从这个日期加上N秒

 @param seconds 需要添加的秒数
 @return 修改后的date
 */
- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;

/**
 时间戳

 @return 当前日期的时间戳
 */
+(NSString *)timestampWithCurrentDate;

/**
 获取当前时间

 @return 当前时间
 */
+(NSDate *)currentDate;





/**
 将日期格式化成字符串

 @param format 格式，例如 @"yyyy-MM-dd HH:mm:ss"
 @return 格式化后的日期
 */
- (NSString *)stringWithFormat:(NSString *)format;

@end
