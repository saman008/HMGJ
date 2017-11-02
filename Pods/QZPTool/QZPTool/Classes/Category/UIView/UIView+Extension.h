//
//  UIView+Extension.h
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
///所在视图的控制器
@property (nonatomic,readonly) UIViewController *viewController;
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic,strong) IBInspectable UIColor *boardColor;
@property (nonatomic,assign) IBInspectable CGFloat borderWidth;
///转为图片
@property (nonatomic, strong, readonly) UIImage * image;

///添加一条横线
- (void) addBottomLineWithColor: (UIColor *) color;
@end
