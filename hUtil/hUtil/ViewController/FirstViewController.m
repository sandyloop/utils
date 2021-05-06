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
#import <CommonCrypto/CommonCrypto.h>
#import "ZLCountdownManager.h"

@interface FirstViewController ()
@property(nonatomic,strong)WorkView* workView;
@property(nonatomic,strong)ZLCountdownManager* cd;
@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navbar.titleString = @"首页";
    
    [self.view addSubview:self.workView];
    
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
//        dispatch_async(globalQueue, ^{
//
//            NSLog(@"开始下载图片:%@", [NSThread currentThread]);
//            //NSString -> NSURL -> NSData -> UIImage
//            NSString *imageStr = @"https://qiniuimage.hulianjun.com/icon/logo180.png";
//            NSURL *imageURL = [NSURL URLWithString:imageStr];
//            //下载图片
//            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//            UIImage *image = [UIImage imageWithData:imageData];
//
//            //从子线程回到主线程(方式二：常用)
//            //组合：主队列异步执行
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"回到主线程:%@", [NSThread currentThread]);
//                //更新界面
//                [self saveSmallImageWithImage:image AtDirectory:@"/Icon"];
//            });
//
//            NSLog(@"xxxxxxxx");
//        });
//
//        //主线程执行
//        NSLog(@"下载图片。。。。。");
    
    __weak typeof(self) weakself = self;
    self.cd =[[ZLCountdownManager alloc] init];
    self.cd.maxNumber = 10;
    self.cd.minNumber = 0;
    self.cd.spaceTime = 1.0;
    self.cd.lessNumber = 1;
    [self.cd startCountingDown];

    self.cd.run = ^(NSInteger number) {
        NSLog(@"aaaaaa");
        if (number == 1) {
            NSLog(@"1111111");
        }
        [weakself.cd stopCountingDown];
        weakself.cd =[[ZLCountdownManager alloc] init];
        weakself.cd.maxNumber = 5;
        weakself.cd.minNumber = 0;
        weakself.cd.spaceTime = 1.0;
        weakself.cd.lessNumber = 1;
        [weakself.cd startCountingDown];

        weakself.cd.run = ^(NSInteger number) {
            NSLog(@"bbbbbb");
            if (number == 1) {
                NSLog(@"222222");
            }
        };
        
        
        
    };
    
    
    [self getMonthFirstDay:[self getCurrentTimes]];
    
    
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (void)saveSmallImageWithImage:(UIImage*)image AtDirectory:(NSString*)directory
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //1、拼接目录
    NSArray *libsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [libsPath objectAtIndex:0];
    NSString* savePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.png",@"svip_app_icon"]];
    NSLog(@"%@",savePath);
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (![fileManager fileExistsAtPath:savePath]) {//判断是否存在
        //createFileAtPath:
        //第一个参数  创建的文件的路径（全路径包括文件名及后缀）
        //第二个参数  文件里面显示的内容（一般情况下 新创建的文件里面的内容为空 nil）
        //第三个参数  属性权限  一般时为nil  表示是文件管理类的默认权限
        BOOL ret = [fileManager createFileAtPath:savePath contents:UIImagePNGRepresentation(image) attributes:nil];
        if (!ret) {
            NSLog(@"图片 文件 创建失败");
        }
    }
}



-(WorkView*) workView{
    if (!_workView) {
        _workView = [[WorkView alloc] init];
        _workView.frame = CGRectMake(0, HNAVBAR_HEIGHT, HSCREEN_WIDTH, HSCREEN_HEIGHT-HTABBAR_HEIGHT);
        _workView.backgroundColor = [UIColor whiteColor];
    }
    return _workView;
}


- (NSString *)getMonthFirstDay:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];

    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @"";
    }

    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
    NSLog(@"firstString = %@",firstString);
    return firstString;
}


-(NSString*)getCurrentTimes{
    NSDate *date = [NSDate date];
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
    [forMatter setTimeZone:timeZone];
    //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [forMatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [forMatter stringFromDate:date];
    return dateStr;
}


@end
