//
//  NSDate+HExtension.h
//  testDemo
//
//  Created by wjr on 2018/2/2.
//  Copyright © 2018年 wjr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HExtension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为本月
 */
- (BOOL)isThisMonth;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
@end
