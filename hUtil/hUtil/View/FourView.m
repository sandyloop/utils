//
//  FourView.m
//  hUtil
//
//  Created by ygf on 2021/2/25.
//  Copyright © 2021 wjr. All rights reserved.
//

#define IMAGEHEIGHT 300*HSCALAE

#import "FourView.h"

@interface FourView() <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIImageView * topImageView;
@property(nonatomic,strong) NSArray * arrData;
@property(nonatomic,assign) BOOL flag;
@property (nonatomic,strong)UITableView *tableView;//列表

@end

@implementation FourView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        _flag = NO;
        _arrData = @[@"我的Blog",@"清除缓存",@"夜间模式"];
        [self createTopImageView];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

#pragma mark -- createTopImageView
- (void)createTopImageView{
    //顶部试图
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -IMAGEHEIGHT, [UIScreen mainScreen].bounds.size.width, IMAGEHEIGHT)];
    _topImageView.image = [UIImage imageNamed:@"biao"];
    _topImageView.clipsToBounds = YES;
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    //添加到tableView上
    [self.tableView addSubview:_topImageView];
    //contentInset 额外滑动区域
    self.tableView.contentInset = UIEdgeInsetsMake(IMAGEHEIGHT, 0, 0, 0);
}

/* 行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrData.count;
}
/* cell内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _arrData[indexPath.row];
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = [self showCache];
        
    }else if (indexPath.row == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch * sw = [[UISwitch alloc]initWithFrame:CGRectMake(50, 50, 100, 50)];
        sw.on = NO;//关闭状态
        if (_flag) {
            sw.on = YES;//开启状态
        }
        [sw addTarget:self action:@selector(changeEvent:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = sw;
    }
    return cell;
}

#pragma mark -- UISwitch开关按钮事件实现
- (void)changeEvent:(UISwitch *)sw{
    _flag = !_flag;
    if (sw.on && _flag) {
        [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor blackColor];//设置背景色
        [UIApplication sharedApplication].keyWindow.alpha = 0.5;//透明度
    }else{
        [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
        [UIApplication sharedApplication].keyWindow.alpha = 1.0;
    }
}

#pragma mark -- cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.cnblogs.com/"] options:@{} completionHandler:nil];
    }else if(indexPath.row == 1){
        //清除缓存
        [self clearCacheFromPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]];
        [self.tableView reloadData];
    }
}

#pragma mark -- scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offSet = scrollView.contentOffset.y;
    if (offSet < -IMAGEHEIGHT) {
        //正在下拉
        //更新顶部试图的效果
        //1.图片始终顶在最上方
        //2.图片高度随下拉而增加
        CGRect rect = _topImageView.frame;
        rect.origin.y = offSet;
        rect.size.height = -offSet;
        //重置
        _topImageView.frame = rect;
        
    }
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, HSCREEN_WIDTH, HSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor=[UIColor whiteColor];
    }
    return _tableView;
}

/* 返回多少M*/
- (NSString * )showCache{
    return [NSString stringWithFormat:@"%0.2fM",[self folderSizeAtPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]]];
}

/* 遍历文件夹获得文件夹大小 */
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    //通过枚举遍历法遍历文件夹中的所有文件
    //创建枚举遍历器
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    //首先声明文件名称、文件大小
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        //得到当前遍历文件的路径
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        //调用封装好的获取单个文件大小的方法
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);//转换为多少M进行返回
}

/* 跳转的打开方法 */
- (void)openFuncCommd:(NSString *)str{
    //NSString转NSURL
    NSURL* url = [NSURL URLWithString:str];
    //当前程序
    UIApplication* app = [UIApplication sharedApplication];
    //判断
    if([app canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [app openURL:url options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
        }
    }else{
        [ToastHelper showPromptWithMessage:@"没有此功能或者该功能不可用!" withPromptType:ToastType_Toast];
    }
}


- (void)clearCache{
    [self clearCacheFromPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]];
}

/* 返回缓存的大小 */
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/* 清除缓存大小 打印NSHomeDritiony前往Documents进行查看路径*/
- (void)clearCacheFromPath:(NSString*)path{
    //建立文件管理器
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        //如果文件路径存在 获取其中所有文件
        NSArray * fileArr = [manager subpathsAtPath:path];//找到所有子文件的路径，存到数组中。
        //首先需要转化为完整路径
        //直接删除所有子文件
        for (int i = 0; i < fileArr.count; i++) {
            NSString * fileName = fileArr[i];
            //完整路径
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:filePath error:nil];
        }
    }
}


@end
