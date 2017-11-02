//
//  UIView+Xib.h
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Xib)
+ (instancetype)loadFromNib;
+ (instancetype)loadFromNibWithName:(NSString*)aName;
+ (instancetype)loadFromNibWithFrame:(CGRect)frame;
+ (UINib *)nib;

@end
