//
//  XDHelper.m
//  Utils
//
//  Created by 赵旭东 on 2016/12/15.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "XDHelper.h"

@implementation XDHelper




#pragma mark - 图片压缩
static float scale = 1.0;
+(NSData *)compactImage:(UIImage *)image{
    NSData * resultData= nil;
    NSData * data = UIImageJPEGRepresentation(image, scale);
    resultData = data;
    while (resultData.length > 1024 * 100 && scale > 0.1) {
        scale -= 0.05;
        UIImage * newImage = [UIImage imageWithData:data];
        NSData * newData = UIImageJPEGRepresentation(newImage, scale);
        resultData = newData;
    }
    scale = 1.0;
    return resultData;
}


#pragma mark - 二维码生成
+ (UIImage *)makeQRCodeForString:(NSString *)string{
    NSString *text = string;
    NSData *stringData = [text dataUsingEncoding: NSUTF8StringEncoding];
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    //二维码颜色
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    //上色，如果只要白底黑块的QRCode可以跳过这一步
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    //绘制
    CIImage *qrImage = colorFilter.outputImage;
    CGSize size = CGSizeMake(200, 200);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage     fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);//生成的QRCode就是上下颠倒的,需要翻转一下
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    //    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    
    return [UIImage imageWithCIImage:qrImage];
}

#pragma mark - 从图片中读取二维码
+ (NSString *)scQRReaderForImage:(UIImage *)qrimage{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [CIImage imageWithCGImage:qrimage.CGImage];
    NSArray *features = [detector featuresInImage:image];
    CIQRCodeFeature *feature = [features firstObject];
    NSString *result = feature.messageString;
    return result;
}


#pragma mark -JSON 格式字符串转字典

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil)  return nil;
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark -字典转JSON
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - 十六进制字符串转颜色
+(UIColor*)toUIColorByStr:(NSString*)colorStr{
    
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    
    range.location = 0;
    
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
            
                           green:((float) g / 255.0f)
            
                            blue:((float) b / 255.0f)
            
                           alpha:1.0f];
    
}

#pragma mark - 颜色转16进制字符串
+(NSString*)toStrByUIColor:(UIColor*)color{
    
    CGFloat r, g, b, a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    
    return [NSString stringWithFormat:@"%06x", rgb];
    
}
#pragma mark -是否是闰年
+(BOOL)isLeapYear:(NSInteger)year{
    NSAssert(!(year < 1), @"invalid year number");
    BOOL leap = FALSE;
    if ((0 == (year % 400))) {
        leap = TRUE;
    }
    else if((0 == (year%4)) && (0 != (year % 100))) {
        leap = TRUE;
    }
    return leap;
}
+ (NSInteger)numberOfDaysInMonth:(NSInteger)month
{
    return [XDHelper numberOfDaysInMonth:month year:[XDHelper getCurrentYear]];
}
#pragma mark -今年的年份
+ (NSInteger)getCurrentYear
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int year = dt->tm_year + 1900;
    return year;
}
#pragma mark -本月的月份
+ (NSInteger)getCurrentMonth
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int month = dt->tm_mon + 1;
    return month;
}
#pragma mark -今天的日
+ (NSInteger)getCurrentDay
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int day = dt->tm_mday;
    return day;
}
#pragma mark -根据传入的date求出月份
+ (NSInteger)getMonthWithDate:(NSDate*)date
{
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger month = comps.month;
    return month;
}
#pragma mark -根据传入的date求天数
+ (NSInteger)getDayWithDate:(NSDate*)date
{
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger day = comps.day;
    return day;
}
#pragma mark -根据传入的年月求出天数
+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger) year
{
    NSAssert(!(month < 1||month > 12), @"invalid month number");
    NSAssert(!(year < 1), @"invalid year number");
    month = month - 1;
    static int daysOfMonth[12] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    NSInteger days = daysOfMonth[month];
    /*
     * feb
     */
    if (month == 1) {
        if ([XDHelper isLeapYear:year]) {
            days = 29;
        }
        else {
            days = 28;
        }
    }
    return days;
}
+ (NSDate*)dateSinceNowWithInterval:(NSInteger)dayInterval{
    return [NSDate dateWithTimeIntervalSinceNow:dayInterval*24*60*60];
}
#pragma mark - 根据两个时间求时间间隔
+(NSInteger)numberOfDaysFrom:(NSString *)currentTime  withNextTime:(NSString *)nextTime{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate = [dateFormatter dateFromString:currentTime];
    NSString *subMonthStr = [nextTime substringToIndex:10];
    NSDate *toDate = [dateFormatter dateFromString:subMonthStr];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    NSRange range= {11,2};
    NSInteger inter = [[nextTime substringWithRange:range]integerValue];
    return dayComponents.day *24 + inter;
}
#pragma mark - 根据传入的时间和format返回string
+(NSString*)stringWithDate:(NSDate*) date withFormat:(NSString*)format{
    NSDateFormatter *datefor = [[NSDateFormatter alloc]init];
    [datefor setDateFormat:format];
    NSString *time  = [datefor stringFromDate:date];
    return time;
}
#pragma mark - 根君传入的时间字符串和format返回对应时间
+(NSDate*)dateWithTime:(NSString*)time Format:(NSString*)format{
    NSDateFormatter *mat = [[NSDateFormatter alloc]init];
    [mat setDateFormat:format];
    NSDate *date = [mat dateFromString:time];
    return date;
}



@end
