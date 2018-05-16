//
//  NSDate+AYDate.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AYDate)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)ay_day;
- (NSUInteger)ay_month;
- (NSUInteger)ay_year;
- (NSUInteger)ay_hour;
- (NSUInteger)ay_minute;
- (NSUInteger)ay_second;
+ (NSUInteger)ay_day:(NSDate *)date;
+ (NSUInteger)ay_month:(NSDate *)date;
+ (NSUInteger)ay_year:(NSDate *)date;
+ (NSUInteger)ay_hour:(NSDate *)date;
+ (NSUInteger)ay_minute:(NSDate *)date;
+ (NSUInteger)ay_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)ay_daysInYear;
+ (NSUInteger)ay_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)ay_isLeapYear;
+ (BOOL)ay_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)ay_weekOfYear;
+ (NSUInteger)ay_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)ay_formatYMD;
+ (NSString *)ay_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)ay_weeksOfMonth;
+ (NSUInteger)ay_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)ay_begindayOfMonth;
+ (NSDate *)ay_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)ay_lastdayOfMonth;
+ (NSDate *)ay_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)ay_dateAfterDay:(NSUInteger)day;
+ (NSDate *)ay_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)ay_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)ay_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)ay_offsetYears:(int)numYears;
+ (NSDate *)ay_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)ay_offsetMonths:(int)numMonths;
+ (NSDate *)ay_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)ay_offsetDays:(int)numDays;
+ (NSDate *)ay_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)ay_offsetHours:(int)hours;
+ (NSDate *)ay_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)ay_daysAgo;
+ (NSUInteger)ay_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)ay_weekday;
+ (NSInteger)ay_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)ay_dayFromWeekday;
+ (NSString *)ay_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)ay_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)ay_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)ay_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)ay_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)ay_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)ay_stringWithFormat:(NSString *)format;
+ (NSDate *)ay_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)ay_daysInMonth:(NSUInteger)month;
+ (NSUInteger)ay_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)ay_daysInMonth;
+ (NSUInteger)ay_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)ay_timeInfo;
+ (NSString *)ay_timeInfoWithDate:(NSDate *)date;
+ (NSString *)ay_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)ay_ymdFormat;
- (NSString *)ay_hmsFormat;
- (NSString *)ay_ymdHmsFormat;
+ (NSString *)ay_ymdFormat;
+ (NSString *)ay_hmsFormat;
+ (NSString *)ay_ymdHmsFormat;

@end
