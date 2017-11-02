//
//  UIButton+Click.h
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Click)
@property (nonatomic, copy) void (^Click) ();
@end
