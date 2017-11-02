//
//  NSObject+HUD.h
//  YLProject
//
//  Created by qzp on 2017/2/23.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HUD)
/** 弹出文字提示 */
+ (void)showAlert:(NSString *)text;
/** 显示忙 */
+ (void)showBusy;
/** 隐藏提示 */
+ (void)hideProgress;

@end
