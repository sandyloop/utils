//
//  ToastHelper.h
//  hUtil
//
//  Created by ygf on 2020/7/10.
//  Copyright © 2020 wjr. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToastHelper : NSObject
DEFINE_SINGLETON_INTERFACE(ToastHelper)

/**
 弹出警告提示框
 
 @param message 提示信息
 @param promptType 类型
 */
+ (void)showPromptWithMessage:(NSString *)message withPromptType:(ToastType)promptType;

@end

NS_ASSUME_NONNULL_END
