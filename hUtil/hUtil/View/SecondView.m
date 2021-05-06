//
//  SecondView.m
//  hUtil
//
//  Created by ygf on 2020/7/21.
//  Copyright © 2020 wjr. All rights reserved.
//

#import "SecondView.h"
#import "LMJHorizontalScrollText.h"
#import "UIImage+WebP.h"

@interface SecondView()
@property(nonatomic,strong)LMJHorizontalScrollText* horizontalScrollText;
@property(nonatomic,strong)UIImageView* imgView;

@end

@implementation SecondView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.horizontalScrollText];
        [self addSubview:self.imgView];
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



-(UIImageView*) imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 300, 400)];
        NSString *path = @"https://qiniuimage.hulianjun.com/default/alert.webp";
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:path]];
        UIImage *img = [UIImage sd_imageWithWebPData:data];
        _imgView.image = img;
    }
    return _imgView;
}

@end
