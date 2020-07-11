//
//  ToastHelper.m
//  hUtil
//
//  Created by ygf on 2020/7/10.
//  Copyright © 2020 wjr. All rights reserved.
//

#import "ToastHelper.h"
#import "HToast.h"


@implementation ToastHelper

DEFINE_SINGLETON_IMPLEMENTATION(ToastHelper)


- (void)setUp {
}
/**
 弹出警告提示框
 
 @param message 提示信息
 @param promptType 类型
 */
+ (void)showPromptWithMessage:(NSString *)message withPromptType:(ToastType)promptType {
    if (![HUtils isNull:message]) {
        [[HToast shareInstance] showTopToast:message withType:promptType];
    }
}

@end
