//
//  UIButton+Extension.h
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
@property(nonatomic, strong) IBInspectable UIImage *rightImage;
@property(nonatomic, strong) IBInspectable UIImage *topImage;
@property(nonatomic, strong) IBInspectable UIColor *backgroundColorAtNormal;
@property(nonatomic, assign) IBInspectable BOOL txtColor;
/**
 *   @brief  行间距
 */
@property(nonatomic, assign) IBInspectable CGFloat lineSpacing;
@end
