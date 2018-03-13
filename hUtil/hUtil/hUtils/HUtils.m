//
//  HUtils.m
//  testDemo
//
//  Created by wjr on 2018/2/2.
//  Copyright © 2018年 wjr. All rights reserved.
//

#import "HUtils.h"
#import "NSDate+HExtension.h"
//usedMemory使用的头文件
#include <sys/sysctl.h>
#include <mach/mach.h>

@implementation HUtils


/**
 *  校验手机号码的有效性
 *
 *  @param mobileNum 手机号码
 *
 *  @return 是否有效
 */
+(BOOL)validateMobile:(NSString *)mobileNum
{
    /**
      * 手机号码:
        * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
        * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
        * 联通号段: 130,131,132,155,156,185,186,145,176,1709
        * 电信号段: 133,153,180,181,189,177,1700
     *//*updated at 2015-8-24*/
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     12         */
    NSString * CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,155,156,185,186,145,176,1709
     17         */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     20         * 中国电信：China Telecom
     21         * 133,153,180,181,189,177,1700
     22         */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  判断密码是否是由6-18位数字和字母组合
 *
 *  @param password 密码字符串
 *
 *  @return 是否有效
 */
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}
/**
 *  判断有效是否有效
 *
 *  @param email 邮箱
 *
 *  @return 是否邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  判空字符串是否是各种空值
 *
 *  @param str 字符串
 *
 *  @return 是否是空值
 */
+(BOOL)isNull:(NSString *)str
{
    // 判断是否为空串
    if ([str isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([str isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (str==nil){
        return YES;
    }
    else if ([str isEqualToString:@""] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"]){
        return YES;
    }
    
    return NO;
}

/**
 *  动态计算字符串高度
 *
 *  @param text   string 字符串
 *  @param fount  字号
 *  @param weight 宽度
 *
 *  @return 字符串高度
 */
+ (CGFloat)getHeightWithText:(NSString*)text labelFount:(UIFont*)fount andWidth:(CGFloat)width{
    CGFloat height = 0;
    CGSize size = CGSizeMake(width,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: fount};
    CGSize labelsize = [text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    height = labelsize.height;
    return height;
}

/**
 将数组或字典转化成json
 
 @param objc <#objc description#>
 @return <#return value description#>
 */
+ (NSString *)transformObjc:(id)objc {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objc options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

//根据关键字保存对应的设置信息
+ (void)setInfo:(id)value forKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}


//擦除关键字对应的设置信息
+(void)removeInfoForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

//获取bundleID
+(NSString*)BundleIdentifier{
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    return  [dic objectForKey:@"CFBundleIdentifier"];
}


+(UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+(UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}


#pragma mark - 计算文件大小
+(NSString *)GetFileSizeFromString:(NSString *)fileSize{
    if (!fileSize) {
        return @"";
    }
    float  size = [fileSize floatValue];
    if (size == 0.0 ){
        return @"";
    }
    if (size >= 1024*1024*1024){
        return [NSString stringWithFormat:@"%.2fGB",size/(1024*1024*1024)];
    }
    else if (size >= 1024*1024){
        return [NSString stringWithFormat:@"%.2fMB",size/(1024*1024)];
    }
    else if (size >= 1024){
        return [NSString stringWithFormat:@"%.2fKB",size/1024];
    }
    else{
        return [NSString stringWithFormat:@"%luB",(unsigned long)roundf(size)];
    }
    return @"";
}

//64编码
+(NSString *)encode:(NSString *)string{
    //先将string转换成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;
}

//64解码
+(NSString *)dencode:(NSString *)base64String{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}


+(NSString *)formattingDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *lastDay=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24]];
    
    if ([dateString rangeOfString:currentDateStr].location!=NSNotFound){
        return [[dateString componentsSeparatedByString:@" "] objectAtIndex:1];
    }
    else if ([dateString rangeOfString:lastDay].location!=NSNotFound){
        NSString *hourString=[[dateString componentsSeparatedByString:@" "] objectAtIndex:1];
        return [NSString stringWithFormat:@"%@ %@",@"昨天",hourString];
    }
    else{
        return dateString;
    }
}



+(NSString *)formattingDateWithoutHour:(NSDate*)date{
    if ([date isThisYear]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        return dateString;
    }
    else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        return dateString;
    }
}


+(NSString*)getCurrentTime{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd HH:mm:ss:SSS"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

+(NSString*)getFileModificationTime:(NSString*)filepath{
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filepath error:nil];
    NSString *time = nil;
    if (fileAttributes != nil){
        //文件修改日期
        NSDate *fileModDate = [fileAttributes objectForKey:NSFileModificationDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        time = [dateFormatter stringFromDate:fileModDate];
    }
    return time;
}


#pragma mark - 内存
+(double)usedMemory{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

//判断是否有中文
+(BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}


+ (UIColor *) hexStringToColor: (NSString *) stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearss
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
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




@end
