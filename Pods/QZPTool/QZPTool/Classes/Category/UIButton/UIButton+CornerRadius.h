//
//  UIButton+CornerRadius.h
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CornerRadius)
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic,strong) IBInspectable UIColor *boardColor;
@property (nonatomic,assign) IBInspectable CGFloat borderWidth;
@end
