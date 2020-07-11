//
//  SecondViewController.m
//  hUtil
//
//  Created by sandyloop on 2020/7/8.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navbar.titleString = @"发现";
//    [[self rdv_tabBarItem] setBadgeValue:@"3"];
//    [[self rdv_tabBarItem] setBadgeBackgroundColor:[UIColor colorWithHexString:@"#3CB371"]];
//    [self rdv_tabBarItem].badgePositionAdjustment = UIOffsetMake(-3, 8);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [ToastHelper showPromptWithMessage:@"Discover" withPromptType:ToastType_Toast];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
