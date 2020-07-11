//
//  BaseViewController.h
//  hUtil
//
//  Created by sandyloop on 2020/7/9.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

/**
 自定义导航栏
 */
@property (nonatomic,strong) CustomerNavigationBar *navbar;

@end

NS_ASSUME_NONNULL_END
