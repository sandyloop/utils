//
//  SecondViewController.m
//  hUtil
//
//  Created by sandyloop on 2020/7/8.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondView.h"


@interface SecondViewController ()
@property(nonatomic,strong)SecondView* secondView;
@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navbar.titleString = @"发现";
//    [[self rdv_tabBarItem] setBadgeValue:@"3"];
//    [[self rdv_tabBarItem] setBadgeBackgroundColor:[UIColor colorWithHexString:@"#3CB371"]];
//    [self rdv_tabBarItem].badgePositionAdjustment = UIOffsetMake(-3, 8);
    [self.view addSubview:self.secondView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [ToastHelper showPromptWithMessage:@"Discover" withPromptType:ToastType_Toast];
}



-(SecondView*) secondView{
    if (!_secondView) {
        _secondView = [[SecondView alloc] init];
        _secondView.frame = CGRectMake(0, HNAVBAR_HEIGHT, HSCREEN_WIDTH, HSCREEN_HEIGHT-HTABBAR_HEIGHT);
        _secondView.backgroundColor = [UIColor whiteColor];
    }
    return _secondView;
}



@end
