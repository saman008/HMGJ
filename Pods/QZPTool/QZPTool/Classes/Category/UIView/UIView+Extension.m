//
//  UIView+Extension.m
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
@dynamic viewController;
- (UIViewController *)viewController
{
    UIViewController *viewController=nil;
    UIView* next = [self superview];
    UIResponder *nextResponder = [next nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        viewController = (UIViewController *)nextResponder;
    }
    else
    {
        viewController = [next viewController];
    }
    return viewController;
}
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

- (UIImage *)image {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}
- (void)addBottomLineWithColor:(UIColor *)color {
    CALayer * separatorl = [CALayer layer];
    separatorl.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1);
    separatorl.backgroundColor = color.CGColor;
    [self.layer addSublayer: separatorl];
}
@end
