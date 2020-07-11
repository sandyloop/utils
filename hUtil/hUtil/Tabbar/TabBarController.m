//
//  TabBarController.m
//  hUtil
//
//  Created by ygf on 2020/7/9.
//  Copyright © 2020 wjr. All rights reserved.
//

#import "TabBarController.h"
#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"

@interface TabBarController()<RDVTabBarControllerDelegate>

@end

@implementation TabBarController

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self enterTabBarController];
}


- (void)enterTabBarController {
    [self setupViewControllers];
}

//- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    NSLog(@"viewController = %@",[viewController class]);
//}

//***********************************************************************************
- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {

    NSLog(@"点击了第%ld个tabbar",(long)index);
    if (index < 0 || index >= [[self viewControllers] count]) {
        return;
    }

    if ([self selectedViewController] == [self viewControllers][index]) {
        if (index == 2)  index = 0;
    }


    [self setSelectedIndex:index];

    if ([[self delegate] respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [[self delegate] tabBarController:self didSelectViewController:[self viewControllers][index]];
    }
}

//***********************************************************************************

- (BOOL)tabBar:(RDVTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index {
    if ([[self delegate] respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        if (![[self delegate] tabBarController:self shouldSelectViewController:[self viewControllers][index]]) {
            return NO;
        }
    }
    if ([self selectedViewController] == [self viewControllers][index]) {
        if (index != 2) {
            return NO;
        }
    }
    return YES;
}



- (void)setupViewControllers {
    UIViewController *firstViewController = [[FirstViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[SecondViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[ThirdViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    UIViewController *fourViewController = [[FourViewController alloc] init];
    UIViewController *fourNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:fourViewController];
    
    [self setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController,fourNavigationController]];
    self.delegate = self;
    [self customizeTabBarForController];
}


- (void)customizeTabBarForController {
    NSArray *tabBarItemImagesGary = @[@"ckzlGray", @"myGray", @"ckzlGray", @"myGray"];
    NSArray *tabBarItemImagesRed = @[@"ckzlRed", @"myRed", @"ckzlRed", @"myRed"];
    NSArray *titleArray = @[@"首页", @"发现", @"消息", @"我的"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                      [tabBarItemImagesRed objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImagesGary objectAtIndex:index]]];
        item.title = [NSString stringWithFormat:@"%@",[titleArray objectAtIndex:index]];
        
        NSDictionary *textAttributes = nil;
        textAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:11],
                           NSForegroundColorAttributeName: [UIColor colorWithHexString:@"DAA520"],};
        item.selectedTitleAttributes = textAttributes;
        
        NSDictionary *unTextAttributes = nil;
        unTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:11],
                           NSForegroundColorAttributeName: [UIColor colorWithHexString:@"666666"],};
        item.unselectedTitleAttributes = unTextAttributes;
        
        item.titlePositionAdjustment = UIOffsetMake(0, 8);
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        if (index == 1) {
            [item setBadgeValue:@"3"];
            [item setBadgeBackgroundColor:[UIColor colorWithHexString:@"#3CB371"]];
            item.badgePositionAdjustment = UIOffsetMake(-3, 8);
        }
        index++;
        
    }
}


- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;
    textAttributes = @{
                       NSFontAttributeName: [UIFont boldSystemFontOfSize:11],
                       NSForegroundColorAttributeName: [UIColor blackColor],
                       };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

@end
