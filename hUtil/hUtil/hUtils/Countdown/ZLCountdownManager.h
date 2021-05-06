//
//  ZLCountdownManager.h
//  ZLSuperClass_Example
//
//  Created by 赵磊 on 2021/2/22.
//  Copyright © 2021 itzhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLCountdownManager : NSObject

///定时器
@property (nonatomic,strong,nullable) NSTimer *timer;
///正在倒计时
@property (nonatomic,unsafe_unretained) BOOL isOnCountingDown;
///最大值-计数
@property (nonatomic,unsafe_unretained) NSInteger maxNumber;
///最小值-计数(如果计数比最小值小，则视为完成计数)
@property (nonatomic,unsafe_unretained) NSInteger minNumber;
///多少时间执行一次（默认1.0）
@property (nonatomic,unsafe_unretained) CGFloat spaceTime;
///计数每次减少的值(默认1)
@property (nonatomic,unsafe_unretained) NSInteger lessNumber;
///循环
@property (nonatomic,copy) void (^run)(NSInteger number);
///将要开始
@property (nonatomic,copy) void (^willStart)(void);
///将要终止
@property (nonatomic,copy) void (^willStop)(void);

///开启、重新开启一个定时器（内存地址会发生改变）
- (void)startCountingDown;

//关闭定时器（销毁）
- (void)stopCountingDown;

@end

NS_ASSUME_NONNULL_END
