//
//  BaseViewController.m
//  hUtil
//
//  Created by sandyloop on 2020/7/9.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//
//    BaseViewController *viewController = [super allocWithZone:zone];
//
//    @weakify(viewController)
//
//    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
//
//        @strongify(viewController)
//        [viewController uc_addSubviews];
//        [viewController uc_bindViewModel];
//    }];
//
//    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
//
//        @strongify(viewController)
//        [viewController uc_layoutNavigation];
//        [viewController uc_getNewData];
//    }];
//
//    return viewController;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hideNavigationBar:YES animated:YES];
    [self.view addSubview:self.navbar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {
//            NSLog(@"深色模式");
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
        } else if (mode == UIUserInterfaceStyleLight) {
//            NSLog(@"浅色模式");
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        } else {
            NSLog(@"未知模式");
        }
    } else {
        // Fallback on earlier versions
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}

#pragma mark - layzLoad
- (CustomerNavigationBar *)navbar {
    if (!_navbar) {
        _navbar = [[CustomerNavigationBar alloc] initWithFrame:CGRectMake(0, 0, HSCREEN_WIDTH, HNAVBAR_HEIGHT)];
        KWeakObj(self);
        _navbar.backBlock = ^(void) {
            KStrongObj(self);
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navbar;
}

@end
