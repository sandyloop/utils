//
//  ZLCountdownManager.m
//  ZLSuperClass_Example
//
//  Created by 赵磊 on 2021/2/22.
//  Copyright © 2021 itzhaolei. All rights reserved.
//

#import "ZLCountdownManager.h"

@interface ZLCountdownManager ()

///当前数值
@property (nonatomic,unsafe_unretained) NSInteger number;

@end

@implementation ZLCountdownManager

- (instancetype)init {
    if (self = [super init]) {
        self.spaceTime = 1.0;
        self.lessNumber = 1;
    }
    return self;
}

#pragma mark - Set
- (void)setMaxNumber:(NSInteger)maxNumber {
    _maxNumber = maxNumber;
    self.number = maxNumber;
}

///开启、重新开启一个定时器（内存地址会发生改变）
- (void)startCountingDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (self.willStart) {
        self.willStart();
    }
    __weak typeof(self)weakSelf = self;
    self.isOnCountingDown = YES;
    if (self.number == self.minNumber) {
        self.number = self.maxNumber;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.spaceTime target:weakSelf selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}

//关闭定时器
- (void)stopCountingDown {
    if (self.willStop) {
        self.willStop();
    }
    [self.timer invalidate];
    self.timer = nil;
    self.isOnCountingDown = NO;
    NSLog(@"*****  定时器已释放  *****");
}

- (void)timerAction {
    if (self.number <= self.minNumber) {
        [self stopCountingDown];
        return;
    }
    if (self.run) {
        self.run(self.number);
    }
    self.number -= self.lessNumber;
}

@end
