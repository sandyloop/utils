//
//  UIView+Frame.h
//  hUtil
//
//  Created by sandyloop on 2020/7/9.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

- (void)qm_setHeight:(float)height;
- (void)qm_setWidth:(float)width;
- (void)qm_setX:(float)x;;
- (void)qm_setY:(float)y;
- (CGFloat)qm_x;
- (CGFloat)qm_y;
- (CGFloat)qm_top;
- (CGFloat)qm_bottom;
- (CGFloat)qm_left;
- (CGFloat)qm_right;
- (CGFloat)qm_width;
- (CGFloat)qm_height;
@end

NS_ASSUME_NONNULL_END
