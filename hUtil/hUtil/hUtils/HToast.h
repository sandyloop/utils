//
//  HToast.h
//  hUtil
//
//  Created by ygf on 2020/7/10.
//  Copyright © 2020 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface HToastView : UIView

@end

@interface HToast : NSObject

+(instancetype)shareInstance;


/**
 显示Toast

 @param message 提示文本内容
 @param type ToastType
 */
-(void)showTopToast:(NSString *)message withType:(ToastType)type;

/**
 清除Toast
 */
-(void)clearToast;
@end

NS_ASSUME_NONNULL_END
