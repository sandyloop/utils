//
//  NSDate+HExtension.m
//  testDemo
//
//  Created by wjr on 2018/2/2.
//  Copyright © 2018年 wjr. All rights reserved.
//

#import "NSDate+HExtension.h"

@implementation NSDate (HExtension)


-(NSDateFormatter *)getDateFormatter:(NSString *)ftrStr{
    NSDateFormatter *dateFormatter = nil;
    if (ftrStr && ftrStr.length){
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return dateFormatter;
}
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为本月
 */
- (BOOL)isThisMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitMonth fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitMonth fromDate:[NSDate date]];
    return dateCmps.month == nowCmps.month;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday{
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [self getDateFormatter:@"yyyy-MM-dd"];
    //fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [self getDateFormatter:@"yyyy-MM-dd"];
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

@end
