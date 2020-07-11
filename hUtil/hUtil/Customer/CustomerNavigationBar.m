//
//  CustomerNavigationBar.m
//  hUtil
//
//  Created by sandyloop on 2020/7/9.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import "CustomerNavigationBar.h"

@interface CustomerNavigationBar()
@property(nonatomic,strong)UIImageView *backgroudView;
@end

@implementation CustomerNavigationBar

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backgroudView];
        [self addSubview:self.navbarLineView];
        [self addSubview:self.titleLabel];
        //默认返回
        [self addSubview:self.backButton];
    }
    return self;
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    self.titleLabel.text = _titleString;
}

- (void)onClickWithNavbarButtonAction:(UIButton*)sender {
    switch (sender.tag) {
        case 100:
            if (self.backBlock) {
                self.backBlock();
            }
            break;
        default:
            break;
    }
    
}


#pragma mark - layzLoad

- (UIImageView *)backgroudView {
    if (!_backgroudView) {
        _backgroudView = [[UIImageView alloc] initWithFrame:self.bounds];
        //设置背景图片
//        _backgroudView.image = [UIImage imageNamed:@"nav_whitebg"];//ic_nav_bg
        _backgroudView.backgroundColor = [UIColor colorWithHexString:@"DC143C"];
    }
    return _backgroudView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, self.qm_height-44, self.qm_width-88, 44)];
        _titleLabel.textColor = [UIColor colorWithHexString:@"4B0082"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:HFONTBOLDSIZE(36)];
    }
    return _titleLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        _backButton.tag = 100;
        _backButton.frame = CGRectMake(0, self.qm_height-44, 44, 44);
        [_backButton setImage:[UIImage imageNamed:@"ic_nav_back"] forState:UIControlStateNormal];
        [_backButton setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
        [_backButton addTarget:self action:@selector(onClickWithNavbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


@end
