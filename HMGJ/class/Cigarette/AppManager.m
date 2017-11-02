//
//  AppManager.m
//  Epay
//
//  Created by disancheng on 2017/5/22.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "AppManager.h"
#import "LoginVM.h"


#import <YYWebImage/YYWebImage.h>
#import "AppMacro.h"
#import "NSObject+HUD.h"
#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>
#import "QZPToolHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "HttpRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "SMProgressHUD.h"
#import <YTKKeyValueStore/YTKKeyValueStore.h>
#import "ThirdParyMarco.h"
static NSString * storyboards = @"HomeStoryboard|ShopStoryboard|MeStoryboard";

@implementation AppManager
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [[self class] initData];
//        [[self class] setupKeybord];
        [[self class] setupNav];
//        [[self class] baseNetWork];
//        [[self class] autoLogin];
    });
    
}

+ (void) setupNav {
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
//    {
//        [UINavigationBar appearance].translucent = NO;
//    }
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] }];
////    [UINavigationBar appearance].backgroundColor = NavColor;
//    [UINavigationBar appearance].barTintColor = NavColor;
//    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(0, -60) forBarMetrics: UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage: [UIImage new]];
//    [[UINavigationBar appearance] setBackgroundImage: [UIImage new] forBarMetrics: UIBarMetricsDefault];
}
+ (BOOL)canLogin {
    
    PersonModel * model = [self person];
    return model.memberId == nil || model.memberId.length == 0 ? NO : YES;
}
+ (PersonModel *)person {
    YTKKeyValueStore * store = [[YTKKeyValueStore alloc] initDBWithName: DBName];
    NSDictionary * personDic = [store getObjectById: Person_DB_Key fromTable: Person_table];
    PersonModel * model = [PersonModel yy_modelWithDictionary: personDic];
    return model;
}
+ (void)postRender {
    
    if (MemberId != nil) {
        NSString * clientUID = @"";
        if ([JPUSHService registrationID]) {
            clientUID = [JPUSHService registrationID];
        }
        
        
        [HttpRequest postRenderWithJpushCode: clientUID results:^(NSInteger statusCode, NSString *msg, id anyobject) {
            QLog(@"上报推送-%ld",(long)statusCode);
        }];
    }
    
}
+ (void)changePersonInfo:(NSDictionary *)params {
    YTKKeyValueStore * store = [[YTKKeyValueStore alloc] initDBWithName: DBName];
    NSDictionary * personDic = [store getObjectById: Person_DB_Key fromTable: Person_table];
    NSMutableDictionary * mutDic = [NSMutableDictionary dictionaryWithDictionary: personDic];
    for (NSString * key in params.allKeys) {
        [mutDic setObject: params[key] forKey: key];
    }
    [store putObject: mutDic withId: Person_DB_Key intoTable: Person_table];
}

+ (void)autoLogin {
    if (MemberId != nil && Login_password != nil && Login_username != nil) {
        LoginVM * loginVM = [[LoginVM alloc] init];
        loginVM.phone = Login_username;
        loginVM.pwd = Login_password;
        [loginVM.loginCommand execute: nil];
    }
}

+ (void)changeCigarette:(NSDictionary *)cigare {
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    id cigareetList = [NSKeyedUnarchiver unarchiveObjectWithData: [userDefault objectForKey:@"cigaretteList"]];
    if ([cigareetList isKindOfClass:[NSArray class]]) {
        NSMutableArray * tempArray = [NSMutableArray arrayWithArray: cigareetList];
        if ([cigareetList count] > 0) {
            for (NSInteger i = 0; i < [cigareetList count]; i++) {
                if ([[cigareetList[i] objectForKey:@"cgtCode"] isEqualToString: cigare[@"cgtCode"]]) {
                    [tempArray replaceObjectAtIndex: i withObject: cigare];
                }
                
            }
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject: tempArray];
            [userDefault setObject: data forKey: @"cigaretteList"];
            [userDefault synchronize];

            
        }
    }

}

+ (NSInteger)getCigaretteLimitByCgCode:(NSString *)cgCode {
    NSInteger temp = -1;
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    id cigareetLimit = [NSKeyedUnarchiver unarchiveObjectWithData: [userDefault objectForKey:@"cigareetLimit"]];
    if ([cigareetLimit isKindOfClass:[NSArray class]]) {
        for (NSDictionary  * dic in cigareetLimit) {
            if ([dic[@"cgtCode"] isEqualToString: cgCode]) {
                
                return [dic[@"qtyLmt"] integerValue];
            }
            
        }
    
    }
    
    
    
    return temp;
}


+ (void)chnangeShopCigarette:(NSDictionary *)cg {
    
    if (cg==nil) {
        return;
    }
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    id cigaretteLocalOrder = [NSKeyedUnarchiver unarchiveObjectWithData: [userDefault objectForKey:@"cigaretteLocalOrder"]];
    NSMutableArray * tempArray = [NSMutableArray arrayWithArray: cigaretteLocalOrder];
    for (NSInteger i = 0; i < [cigaretteLocalOrder count]; i++) {
        NSDictionary * tempDic = cigaretteLocalOrder[i];
        if ([tempDic[@"cgtCode"] isEqualToString:cg[@"cgtCode"]]) { //如果原来本地已经保存了,替换
            [tempArray replaceObjectAtIndex: i withObject: tempDic];
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject: tempArray];
            [userDefault setObject: data forKey:@"cigaretteLocalOrder"];
            [userDefault synchronize];
            return;
        }
    }
    //本地没保存
    [tempArray addObject: cg];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject: tempArray];
    [userDefault setObject: data forKey:@"cigaretteLocalOrder"];
    [userDefault synchronize];
    
    
    
}

+ (NSDictionary *)getLocalEmplyeeOne {
//    emplyeeOne
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
         id emplyeeOne = [NSKeyedUnarchiver unarchiveObjectWithData: [userDefaults objectForKey:@"emplyeeOne"]];
    return emplyeeOne;
    
}


@end
