//
//  AppManager.h
//  Epay
//
//  Created by disancheng on 2017/5/22.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonModel.h"
#import "JPUSHService.h"

@interface AppManager : NSObject
+ (BOOL) canLogin;
+ (PersonModel *) person;
+ (void) changePersonInfo: (NSDictionary *) params;
///上报推送
+ (void) postRender;

+ (void) autoLogin;

///修改本地烟品
+(void) changeCigarette:(NSDictionary *) cigare;
//获取烟品限量
+(NSInteger) getCigaretteLimitByCgCode:(NSString *) cgCode;
///改变本地烟品购物车数量
+(void) chnangeShopCigarette:(NSDictionary *) cg;

///获取商户信息
+(NSDictionary *) getLocalEmplyeeOne;

@end
