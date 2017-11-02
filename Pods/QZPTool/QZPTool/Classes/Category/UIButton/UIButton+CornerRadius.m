//
//  UIButton+CornerRadius.m
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "UIButton+CornerRadius.h"

@implementation UIButton (CornerRadius)
@dynamic cornerRadius,boardColor,borderWidth;
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.userInteractionEnabled = YES;
    self.layer.cornerRadius = cornerRadius;
}
- (void)setBoardColor:(UIColor *)boardColor
{
    if (self.layer.borderWidth == 0) {
        self.layer.borderWidth = 1;
    }
    self.layer.borderColor = boardColor.CGColor;
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}
@end
