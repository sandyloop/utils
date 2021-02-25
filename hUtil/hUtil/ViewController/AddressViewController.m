//
//  AddressViewController.m
//  hUtil
//
//  Created by ygf on 2021/2/25.
//  Copyright © 2021 wjr. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()
@property(nonatomic,strong)UIButton* addressBtn;
@property(nonatomic,strong)UILabel* addressLab;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.addressBtn];
    
    [[self.addressBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

-(UIButton*) addressBtn {
    if (!_addressBtn) {
        _addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(HSCREEN_WIDTH/2-100*HSCALAE, 100, 100*HSCALAE, 50*HSCALAE)];
        [_addressBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_addressBtn setTitle:@"选择地址" forState:UIControlStateNormal];
        [_addressBtn.layer setMasksToBounds:YES];
        [_addressBtn.layer setCornerRadius:4.0];
    }
    return _addressBtn;
}

@end
