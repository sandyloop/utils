//
//  CustomerNavigationBar.h
//  hUtil
//
//  Created by sandyloop on 2020/7/9.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerNavigationBar : UIView

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIView *navbarLineView;

@property(nonatomic,strong)NSString *titleString;
@property(copy)void(^backBlock)(void);
@end

NS_ASSUME_NONNULL_END
