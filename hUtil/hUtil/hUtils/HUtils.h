//
//  HUtils.h
//  testDemo
//
//  Created by wjr on 2018/2/2.
//  Copyright © 2018年 wjr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)
#define IS_IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10)
#define IS_IOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11)

@interface HUtils : NSObject

/**
 *  校验手机号码的有效性
 *
 *  @param mobileNum 手机号码
 *
 *  @return 是否有效
 */
+(BOOL)validateMobile:(NSString *)mobileNum;
/**
 *  判断密码是否是由6-18位数字和字母组合
 *
 *  @param password 密码字符串
 *
 *  @return 是否有效
 */
+ (BOOL)checkPassword:(NSString *) password;

/**
 *  判断有效是否有效
 *
 *  @param email 邮箱
 *
 *  @return 是否邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email;
/**
 *  判空字符串是否是各种空值
 *
 *  @param str 字符串
 *
 *  @return 是否是空值
 */
+(BOOL)isNull:(NSString *)str;

/**
 *  动态计算字符串高度
 *
 *  @param text   string 字符串
 *  @param fount  字号
 *  @param width 宽度
 *
 *  @return 字符串高度
 */
+ (CGFloat)getHeightWithText:(NSString*)text labelFount:(UIFont*)fount andWidth:(CGFloat)width;

/**
 将数组或字典转化成json
 
 @param objc <#objc description#>
 @return <#return value description#>
 */
+ (NSString *)transformObjc:(id)objc;

//根据关键字保存到NSUserDefaults对应的设置信息
+ (void)setInfo:(id)value forKey:(NSString *)key;

//擦除NSUserDefaults关键字对应的设置信息
+ (void)removeInfoForKey:(NSString *)key;

//获取bundleID
+ (NSString*)BundleIdentifier;

//获取当前最顶层的ViewController
+(UIViewController *)topViewController;

//计算文件大小
+(NSString *)GetFileSizeFromString:(NSString *)fileSize;

//计算时间
+(NSString *)formattingDate:(NSDate*)date;

+(NSString *)formattingDateWithoutHour:(NSDate*)date;

+(NSString*)getCurrentTime;

//获取文件修改时间
+(NSString*)getFileModificationTime:(NSString*)filepath;

//内存使用情况
+ (double)usedMemory;

//判断是否有中文
+(BOOL)containChinese:(NSString *)str;

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
