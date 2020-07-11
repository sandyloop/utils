//
//  FirstViewController.m
//  hUtil
//
//  Created by sandyloop on 2020/7/8.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import "FirstViewController.h"
#import "JJCollectionViewRoundFlowLayout.h"
#import "WorkCollectionViewCell.h"
#import "WorkView.h"


@interface FirstViewController ()
@property(nonatomic,strong)WorkView* workView;

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navbar.titleString = @"首页";
    
    [self.view addSubview:self.workView];
}


-(WorkView*) workView{
    if (!_workView) {
        _workView = [[WorkView alloc] init];
        _workView.frame = CGRectMake(0, HNAVBAR_HEIGHT, HSCREEN_WIDTH, HSCREEN_HEIGHT-HTABBAR_HEIGHT);
        _workView.backgroundColor = [UIColor whiteColor];
    }
    return _workView;
}


@end
