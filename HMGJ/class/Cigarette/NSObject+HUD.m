//
//  NSObject+HUD.m
//  YLProject
//
//  Created by qzp on 2017/2/23.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "NSObject+HUD.h"
#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
@implementation NSObject (HUD)
//获取当前屏幕的最上方正在显示的那个view
+ (UIView *)currentView{
    UIViewController *vc=[UIApplication sharedApplication].keyWindow.rootViewController;
    // vc: 导航控制器, 标签控制器, 普通控制器
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = [(UITabBarController *)vc selectedViewController];
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController *)vc visibleViewController];
    }
    return vc.view;
}
///** 弹出文字提示 */
//+ (void)showAlert:(NSString *)text{
//    //防止在非主线程中调用此方法,会报错
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //    弹出新的提示之前,先把旧的隐藏掉
//        //        [self hideProgress];
//        [MBProgressHUD hideAllHUDsForView:[self currentView] animated:YES];
//        MBProgressHUD *progressHUD=[MBProgressHUD showHUDAddedTo:[self currentView] animated:YES];
//        progressHUD.mode = MBProgressHUDModeText;
//        progressHUD.color = [UIColor darkGrayColor];
//        progressHUD.labelText = text;
//        [progressHUD hide:YES afterDelay:1.5];
//    });
//}
/** 显示忙 */
+ (void)showBusy{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        //        [self hideProgress];
        [MBProgressHUD hideAllHUDsForView:[self currentView] animated:YES];
        MBProgressHUD *progressHUD=[MBProgressHUD showHUDAddedTo:[self currentView] animated:YES];
        //最长显示20秒
        [progressHUD hide:YES afterDelay:20];
        
    }];
    
}
/** 隐藏提示 */
+ (void)hideProgress{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [MBProgressHUD hideAllHUDsForView:[self currentView] animated:YES];
    }];
}


@end
