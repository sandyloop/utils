//
//  HToast.m
//  hUtil
//
//  Created by ygf on 2020/7/10.
//  Copyright © 2020 wjr. All rights reserved.
//

#import "HToast.h"


#define Toast_Duration_Normal 2.0f //默认逗留时长


static const CGFloat Normal_Size_Width = 260.0f;

#pragma mark - HToastView

@interface HToastView()
@property (strong,nonatomic) UILabel *textLabel;
@property (strong,nonatomic) UIImageView *tipsImageView;
@end

@implementation HToastView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


/**
 显示Toast

 @param message 提示文本
 */
-(void)setTextMessage:(NSString *)message{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    self.textLabel.text = message;
    CGRect rect =[self.textLabel.text  boundingRectWithSize:CGSizeMake(Normal_Size_Width, MAXFLOAT)
                                                    options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:@{NSFontAttributeName:self.textLabel.font} context:nil];
    self.textLabel.textAlignment = (rect.size.width>180.0f) ? NSTextAlignmentCenter : NSTextAlignmentLeft;
    self.textLabel.frame = CGRectMake(25/2, 10, rect.size.width, rect.size.height);
    [self addSubview:self.textLabel];
    
    CGFloat width = rect.size.width+25;
    CGFloat height = rect.size.height+20;
    CGFloat x = (HSCREEN_WIDTH - width)/2;
    CGFloat y = (HSCREEN_HEIGHT -height)/2;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.frame = CGRectMake(x, y, width, height);
}


/**
 显示带有Icon的Toast提示

 @param message 提示文本
 */
-(void)setIconText:(NSString *)message type:(ToastType)type{
    self.textLabel.text = message;
    
    UIImage *tipsIcon = nil;
    if (type == ToastType_Success) {
        tipsIcon = [UIImage imageNamed:@"picker_ok_sigh"];
    }else if (type == ToastType_Error){
        tipsIcon = [UIImage imageNamed:@"picker_alert_sigh"];
    }else if (type == ToastType_Del){
        tipsIcon = [UIImage imageNamed:@"picker_del_sigh"];
    }
    
    
    CGRect rect = [self.textLabel.text boundingRectWithSize:CGSizeMake(Normal_Size_Width, MAXFLOAT)
                                                    options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:@{NSFontAttributeName:self.textLabel.font}
                                                    context:nil];
    CGFloat width = rect.size.width + 30*2;
    CGFloat height = rect.size.height + 20 + tipsIcon.size.height + 5*2;
    CGFloat x = (HSCREEN_WIDTH - width) / 2;
    CGFloat y = (HSCREEN_HEIGHT - height) / 2;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.frame = CGRectMake(x, y, width, height);
    
    CGFloat iconX = (self.frame.size.width - tipsIcon.size.width)/2;
    self.tipsImageView.frame = CGRectMake(iconX, 20/2, tipsIcon.size.width, tipsIcon.size.height);
    self.tipsImageView.image = tipsIcon;
    [self addSubview:self.tipsImageView];
    
    self.textLabel.frame = CGRectMake(30, self.tipsImageView.frame.origin.y + self.tipsImageView.frame.size.height + 5, rect.size.width, rect.size.height);
    [self addSubview:self.textLabel];
    
}

-(void)setTopText:(NSString *)message offsetY:(CGFloat)offsetY{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    self.textLabel.text = message;
    CGFloat normalWidth = HSCREEN_WIDTH - 2*25;
    CGRect rect =[self.textLabel.text  boundingRectWithSize:CGSizeMake(normalWidth, MAXFLOAT)
                                                    options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:@{NSFontAttributeName:self.textLabel.font} context:nil];
    self.textLabel.textAlignment = (rect.size.width>normalWidth) ? NSTextAlignmentCenter : NSTextAlignmentLeft;
    self.textLabel.frame = CGRectMake(25/2, 20/2, rect.size.width, rect.size.height);
    [self addSubview:self.textLabel];
    CGFloat height = rect.size.height+20;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.frame = CGRectMake(0.0f, offsetY > 0 ? offsetY : HNAVBAR_HEIGHT, HSCREEN_WIDTH, height);
}

#pragma mark - Lazy load
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

-(UIImageView *)tipsImageView{
    if (!_tipsImageView) {
        _tipsImageView = [[UIImageView alloc] init];
        _tipsImageView.backgroundColor = [UIColor clearColor];
    }
    return _tipsImageView;
}

@end


#pragma mark - HToast

@interface HToast()
@property (strong,nonatomic) HToastView *toastView;
@property (assign,nonatomic) NSTimeInterval duration;
@property (assign,nonatomic) BOOL active;//是否活跃
@property (assign,nonatomic) CGFloat top_offsetY;//顶部显示Toast偏移量
@end

@implementation HToast

+(instancetype)shareInstance{
    static
    HToast *hcToast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hcToast = [[HToast alloc] init];
    });
    return hcToast;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.toastView = [[HToastView alloc] init];
        self.active = NO;
        self.top_offsetY = 0;
    }
    return self;
}

-(void)showToast:(NSString *)message{
    if (!_active) {
        [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_Toast];
    }
}

-(void)showTopToast:(NSString *)message withType:(ToastType)type{
    if (![HUtils isNull:message]) {
        if (!_active){
            switch (type) {
                case ToastType_Toast:
                    [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_Success];
                    break;
                case ToastType_Error:
                    [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_Error];
                    break;
                case ToastType_Del:
                    [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_Del];
                    break;
                case ToastType_TopToast:
                    [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_TopToast];
                    break;
                default:
                    break;
            }
        }
    }
}

//-(void)showSuccessIconToast:(NSString *)message{
//    if (!_active) {
//        [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_Success];
//    }
//}

//-(void)showSuccessIconToast:(NSString *)message delay:(NSString*)second{
//    if (!_active) {
//        [[HToast shareInstance] showToastViewWithMessage:message duration:[second floatValue] type:ToastType_Success];
//    }
//}
//
//-(void)showErrorIconToast:(NSString *)message{
//    if (!_active) {
//        [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_Error];
//    }
//}
//
//-(void)showDelIconToast:(NSString *)message{
//    if (!_active) {
//        [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_Del];
//    }
//}
//
//-(void)showTopToast:(NSString *)message{
//    if (!_active) {
//        [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_TopToast];
//    }
//}

//-(void)showTopToast:(NSString *)message offsetY:(CGFloat)offsetY{
//    if (!_active) {
//        self.top_offsetY = offsetY;
//        [[HToast shareInstance] showToastViewWithMessage:message duration:Toast_Duration_Normal type:ToastType_TopToast];
//    }
//}

-(void)clearToast{
    if (_active) {
        [self animationForViewRemove];
    }
}

-(void)showToastViewWithMessage:(NSString *)message duration:(NSTimeInterval)duration type:(ToastType)type{
    if ([self isEmptyObj:message]) {
        return;
    }
    self.active = YES;
    self.duration = duration;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.toastView];
    
    //显示
    switch (type) {
        case ToastType_Toast:{
            [self.toastView setTextMessage:message];
            break;
        }
        case ToastType_Success:{
            [self.toastView setIconText:message type:type];
            break;
        }
        case ToastType_Error:{
            [self.toastView setIconText:message type:type];
            break;
        }
        case ToastType_TopToast:{
            [self.toastView setTopText:message offsetY:self.top_offsetY];
            break;
        }
        case ToastType_Del:{
            [self.toastView setIconText:message type:type];
            break;
        }
            
        default:
            break;
    }
    
    if (type != ToastType_TopToast) {
        self.toastView.center = [UIApplication sharedApplication].keyWindow.center;
    }
    
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationWithDismiss)];
    self.toastView.alpha = 0.8;
    [UIView commitAnimations];
}

-(void)animationWithDismiss{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:self.duration?self.duration:1.f];//逗留时长
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationForViewRemove)];
    self.toastView.alpha = 0;
    [UIView commitAnimations];
}

- (void)animationForViewRemove{
    [self.toastView removeFromSuperview];
    self.active = NO;
    self.top_offsetY = 0;
}

#pragma mark - Utils
- (BOOL)isEmptyObj:(id)o
{
    if (o==nil) {
        return YES;
    }
    if (o==NULL) {
        return YES;
    }
    if ([o isKindOfClass:[NSNull class]]) {
        return YES;
    }

    if ([o isKindOfClass:[NSData class]]) {
        return [((NSData *)o) length]<=0;
    }
    if ([o isKindOfClass:[NSDictionary class]]) {
        return [((NSDictionary *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSArray class]]) {
        return [((NSArray *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSSet class]]) {
        return [((NSSet *)o) count]<=0;
    }
    return NO;
}

@end
