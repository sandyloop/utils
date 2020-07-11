//
//  HMacros.h
//  hUtil
//
//  Created by sandyloop on 2020/7/9.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#ifndef HMacros_h
#define HMacros_h

#define HiPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//安全区域高度
#define HSAFEAREA_HEIGHT (HiPhoneX?34:0)
//屏幕宽高
#define HSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define HSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HNAVBAR_HEIGHT (HiPhoneX?88*HSCALAE+44:64)
#define HTABBAR_HEIGHT (HiPhoneX?68*HSCALAE+49:49)

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//设计切图计算比例
#define HSCALAE HSCREEN_WIDTH/375.0/2.0

#define HFONTSIZE(f) [UIFont fontWithName:@"WeChat-Sans-Std-Bold" size:(f)*HSCALAE]
#define HFONTBOLDSIZE(f) [UIFont fontWithName:@"WeChat-Sans-Std-Bold" size:(f)*HSCALAE]

#define HEXCOLOR(c) [UIColor colorWithHexString:(c)]

#define KWeakObj(o) __weak typeof(o) o##Weak = o;
#define KStrongObj(o) __strong typeof(o) o = o##Weak;
#define WS(weakSelf)        __weak __typeof(&*self)weakSelf = self;
#define KWeakSelf __weak __typeof(self)weakSelf = self


//-------------------单例化一个类-------------------------//
#define DEFINE_SINGLETON_INTERFACE(className) \
+ (className *)shared##className;


#define DEFINE_SINGLETON_IMPLEMENTATION(className) \
static className *shared##className = nil; \
static dispatch_once_t pred; \
\
+ (className *)shared##className { \
dispatch_once(&pred, ^{ \
shared##className = [[super allocWithZone:NULL] init]; \
if ([shared##className respondsToSelector:@selector(setUp)]) {\
[shared##className setUp];\
}\
}); \
return shared##className; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
return [self shared##className];\
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return self; \
}
//-------------------单例化一个类-------------------------//


/**
 Toast类型

 - ToastType_Toast: 普通Toast
 - ToastType_Success: 带成功图标的Toast
 - ToastType_Error: 带失败图标的Toast
 - ToastType_TopToast: 顶部显示Toast
 */
typedef NS_ENUM(NSInteger , ToastType) {
    ToastType_Toast = 0,
    ToastType_Success = 1,
    ToastType_Error = 2,
    ToastType_TopToast = 3,
    ToastType_Del = 4,
};

#endif /* HMacros_h */
