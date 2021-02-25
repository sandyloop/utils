//
//  WorkView.m
//  hUtil
//
//  Created by ygf on 2020/7/9.
//  Copyright © 2020 wjr. All rights reserved.
//

#import "WorkView.h"
#import "JJCollectionViewRoundFlowLayout.h"
#import "WorkCollectionViewCell.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface WorkView()<UICollectionViewDelegate,UICollectionViewDataSource,JJCollectionViewDelegateRoundFlowLayout>
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)JJCollectionViewRoundFlowLayout *layout;

@end

@implementation WorkView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WorkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([WorkCollectionViewCell class])] forIndexPath:indexPath];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self fingerPrint];
    }
}

/*
* 返回头视图
*/
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionReusableView *header = nil;
//    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BlankView" forIndexPath:indexPath];
//        UIView* blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HSCREEN_WIDTH, 50*HSCALAE)];
//        blankView.backgroundColor = [UIColor clearColor];
//        [header addSubview:blankView];
//        return header;
//    }
//    return header;
//}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(HSCREEN_WIDTH, 50*HSCALAE);
//}


- (JJCollectionViewRoundConfigModel *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout configModelForSectionAtIndex:(NSInteger)section{
    JJCollectionViewRoundConfigModel *model = [[JJCollectionViewRoundConfigModel alloc]init];
    if (@available(iOS 13.0, *)) {
        model.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor whiteColor];
        }];
        
    } else {
        // Fallback on earlier versions
        model.backgroundColor = [UIColor whiteColor];
    }
    model.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
    model.shadowOffset = CGSizeMake(0,2);
    model.shadowOpacity = 1;
    model.shadowRadius = 7;
    model.cornerRadius = 10;
    return model;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout borderEdgeInsertsForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 24*HSCALAE, 5, 24*HSCALAE);
}


#pragma mark-- lazy load
-(UICollectionView*) collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30*HSCALAE, HSCREEN_WIDTH, HSCREEN_HEIGHT-HTABBAR_HEIGHT) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[WorkCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([WorkCollectionViewCell class])]];
//        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"BlankView"];
    }
    return _collectionView;
}

- (JJCollectionViewRoundFlowLayout *)layout {
    if (!_layout) {
        _layout = [[JJCollectionViewRoundFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake((HSCREEN_WIDTH-48*HSCALAE)/4, ceil(204*HSCALAE));
        _layout.minimumInteritemSpacing = 0;
        _layout.minimumLineSpacing = 0;
        _layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _layout.isCalculateHeader = NO;
        _layout.isCalculateFooter = NO;
    }
    return _layout;
}


#pragma mark-- /* 指纹解锁 */
- (void)fingerPrint{
    LAContext *context = [LAContext new];
    
    //这个属性是设置指纹输入失败之后的弹出框的选项
    context.localizedFallbackTitle = @"验证密码登录";
    context.localizedCancelTitle = @"取消";
//    __weak typeof(self) WeakSelf = self;
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请在此状态下验证你的TouchID的指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功 刷新主界面");
                //这里需要开启线程,否则跳转会有问题
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"验证成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                });
            }else{
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"手机切换到桌面 或者 系统取消授权，如其他APP切入");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"3次指纹登录失败,即为授权失败");
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        NSLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
//                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        break;
                    }
                }
            }
        }];
    }else{
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                //身份验证无法启动，TouchID没有注册的手指。
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                //认证无法启动，因为密码没有设置在设备。
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                //TouchID不可用
                NSLog(@"TouchID not available");
                break;
            }
        }
    }
}

@end
