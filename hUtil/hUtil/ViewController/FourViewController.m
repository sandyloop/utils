//
//  FourViewController.m
//  hUtil
//
//  Created by sandyloop on 2020/7/8.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import "FourViewController.h"
#import "FourView.h"

@interface FourViewController ()
@property(nonatomic,strong)FourView* fourView;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navbar.titleString = @"我的";
    [self.view addSubview:self.fourView];
}

#pragma mark -- 将导航栏隐藏
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];//隐藏导航栏
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//去除黑线
}

#pragma mark -- 将导航栏归还原样
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //显示导航栏
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //加上黑线
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(FourView*) fourView {
    if (!_fourView) {
        _fourView = [[FourView alloc] init];
        _fourView.frame = CGRectMake(0, 0, HSCREEN_WIDTH, HSCREEN_HEIGHT);
        _fourView.backgroundColor = [UIColor whiteColor];
    }
    return _fourView;
}


@end
