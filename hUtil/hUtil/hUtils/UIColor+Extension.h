//
//  UIColor+Extension.h
//  hUtil
//
//  Created by sandyloop on 2020/7/8.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor*)colorWithHexString:(NSString*)color;
@end

NS_ASSUME_NONNULL_END
