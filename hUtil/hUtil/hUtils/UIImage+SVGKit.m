//
//  UIImage+SVGKit.m
//  hUtil
//
//  Created by sandyloop on 2020/7/8.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import "UIImage+SVGKit.h"
#import "SVGKImage.h"
#import "UIColor+Extension.h"

@implementation UIImage (SVGKit)

+(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv{
    return [UIImage name:name imgv:imgv];
}

+(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv hexColor:(NSString *)hexColor{
    UIColor *tintColor = [UIColor colorWithHexString:hexColor];
    return [UIImage name:name imgv:imgv tintColor:tintColor];
}

+(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv objColor:(UIColor *)objColor{
    UIColor *tintColor = objColor;
    return [UIImage name:name imgv:imgv tintColor:tintColor];
}

#pragma mark - 加载svg图片统一调用此方法
+(UIImage *)name:(NSString *)name imgv:(UIImageView *)imgv{
    SVGKImage *svgImage = [SVGKImage imageNamed:name];
    svgImage.size = CGSizeMake(imgv.frame.size.width, imgv.frame.size.height);
    return svgImage.UIImage;
}

#pragma mark - 修改颜色统一调用此方法
+(UIImage *)name:(NSString *)name imgv:(UIImageView *)imgv tintColor:(UIColor *)tintColor{
    
    UIImage *svgImage = [UIImage name:name imgv:imgv];
    
    CGRect rect = CGRectMake(0, 0, svgImage.size.width, svgImage.size.height);
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(svgImage.CGImage);
    BOOL opaque = alphaInfo == (kCGImageAlphaNoneSkipLast | kCGImageAlphaNoneSkipFirst | kCGImageAlphaNone);
    UIGraphicsBeginImageContextWithOptions(svgImage.size, opaque, svgImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, svgImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, svgImage.CGImage);
    
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

@end
