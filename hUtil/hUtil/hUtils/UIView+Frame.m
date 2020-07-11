//
//  UIView+Frame.m
//  hUtil
//
//  Created by sandyloop on 2020/7/9.
//  Copyright © 2020 sandyloop. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)qm_x{
    return self.frame.origin.x;
}

- (CGFloat)qm_y{
    return self.frame.origin.y;
}

- (CGFloat)qm_width{
    return self.frame.size.width;
}

- (CGFloat)qm_height{
    return self.frame.size.height;
}

- (CGFloat)qm_left{
    return self.frame.origin.x;
}

- (CGFloat)qm_right{
    return self.qm_left + self.qm_width;
}

- (CGFloat)qm_top{
    return self.frame.origin.y;
}

- (CGFloat)qm_bottom{
    return self.qm_top + self.qm_height;
}


- (void)qm_setX:(float)x{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)qm_setY:(float)y{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}


- (void)setX:(float)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)setY:(float)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (void)qm_setWidth:(float)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}
- (void)qm_setHeight:(float)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

@end
