//
//  WorkCollectionViewCell.m
//  hUtil
//
//  Created by sandyloop on 2020/7/9.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import "WorkCollectionViewCell.h"
//#import "FLAnimatedImageView.h"

@interface WorkCollectionViewCell()
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UIImageView* iconImgView;
@property(nonatomic,strong)UILabel* iconLab;
@end


@implementation WorkCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.iconImgView];
        [self.bgView addSubview:self.iconLab];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints {
    
    WS(weakSelf)
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];
    
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40*HSCALAE);
        make.centerX.equalTo(weakSelf.bgView);
        make.width.height.mas_equalTo(64*HSCALAE);
    }];
    
    [self.iconLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.iconImgView.mas_bottom).mas_offset(16*HSCALAE);
        make.width.mas_equalTo(170*HSCALAE);
        make.height.mas_equalTo(34*HSCALAE);
    }];
    [super updateConstraints];
}


#pragma mark 控件初始化懒加载

- (UIView*) bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}


- (UIImageView*) iconImgView{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.image = [UIImage imageNamed:@"liveicon"];
//        NSString * str = @"https://www.baidu.com/img/dong_54209c0ff3da32eecc31f340c08a18f6.gif";
//        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    }
    return _iconImgView;
}

- (UILabel*) iconLab{
    if (!_iconLab) {
        _iconLab = [[UILabel alloc] init];
        _iconLab.font = [UIFont fontWithName:@"WeChat-Sans-Std-Bold" size:24*HSCALAE];
        _iconLab.textColor = HEXCOLOR(@"#666666");
        _iconLab.textAlignment = NSTextAlignmentCenter;
        _iconLab.text = @"消息";
    }
    return _iconLab;
}

@end
