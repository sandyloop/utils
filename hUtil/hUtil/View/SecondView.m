//
//  SecondView.m
//  hUtil
//
//  Created by ygf on 2020/7/21.
//  Copyright © 2020 wjr. All rights reserved.
//

#import "SecondView.h"
#import "LMJHorizontalScrollText.h"


@interface SecondView()
@property(nonatomic,strong)LMJHorizontalScrollText* horizontalScrollText;
@end

@implementation SecondView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.horizontalScrollText];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(LMJHorizontalScrollText*) horizontalScrollText{
    if (!_horizontalScrollText) {
        _horizontalScrollText = [[LMJHorizontalScrollText alloc] init];
        _horizontalScrollText.frame = CGRectMake(30*HSCALAE, HNAVBAR_HEIGHT, 200, 40);
        _horizontalScrollText.textFont = HFONTBOLDSIZE(30);
        _horizontalScrollText.moveDirection = LMJTextScrollMoveRight;
        _horizontalScrollText.speed = 0.03f;
        _horizontalScrollText.moveMode = LMJTextScrollFromOutside;
        _horizontalScrollText.text = @"从控件内开始连续滚动";
        _horizontalScrollText.backgroundColor = HEXCOLOR(@"342789");
    }
    return _horizontalScrollText;
}

@end
