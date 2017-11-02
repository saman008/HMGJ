//
//  BaseRequest.m
//  YLProject
//
//  Created by qzp on 2017/3/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "BaseRequest.h"


#import "RoleModel.h"
#import <YYWebImage/YYWebImage.h>
#import "AppMacro.h"
#import "NSObject+HUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "HttpRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "SMProgressHUD.h"
#import "NSString+hash.h"
#import "AppManager.h"
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowMessage(msg) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
otherButtonTitles: @[] ];\
}\

#define UD_tobaccoFlag @"tobaccoFlag"
#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
#define ShowSuccess(msg)  [[SMProgressHUD shareInstancetype] showTip: msg]

@implementation BaseRequest

+ (void)getEmployeeOne:(void (^)(NSInteger))result {

    [HttpRequest employeeoneWithShopQRCode: nil status: nil result:^(NSInteger statusCode, NSString *msg, id anyobject) {

       
        if (statusCode != HttpResponseCodeSuccess) {
            UIViewController *vc=[UIApplication sharedApplication].keyWindow.rootViewController;
            // vc: 导航控制器, 标签控制器, 普通控制器
            if ([vc isKindOfClass:[UITabBarController class]]) {
                vc = [(UITabBarController *)vc selectedViewController];
            }
            if ([vc isKindOfClass:[UINavigationController class]]) {
                vc = [(UINavigationController *)vc visibleViewController];
            }
//            ShopSelectedVC * spvc = [[UIStoryboard storyboardWithName:@"Main" bundle: nil]instantiateViewControllerWithIdentifier: @"ShopSelectedVC"];
//            spvc.hidesBottomBarWhenPushed = YES;
//            [vc.navigationController pushViewController: spvc animated: YES];
            
        } else {
            if ([anyobject[@"status"] integerValue] ==3){ //收款关闭
                ShowMessage(@"您的收款功能已被店主禁用，请联系店主打开");
                return ;
            }
            
        }
        
        result(statusCode);
    }];

}

+ (void)getEmployeeOneForFirst:(void (^)(NSInteger))result {
    if (MemberId == nil) {
        result(0);
        return;
    }
    [HttpRequest employeeoneWithShopQRCode: nil status: nil result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        if (statusCode == HttpResponseCodeSuccess) {
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject: anyobject[@"tobaccoFlag"] forKey: UD_tobaccoFlag];
            [userDefault synchronize];
        }
        
        
        result(statusCode);
    }];
    
}

@end
