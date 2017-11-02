//
//  AppMacro.h
//  Yl
//
//  Created by qzp on 2017/2/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h
//  http://sso.inlee.com.cn/

/*
 http://125.69.76.146:1472/payment/
 结算中心
 http://125.69.76.146:1474/sso/
 用户中心
 http://file.inlee.com.cn:8011/
 文件中心
 http://125.69.76.146:1475/merchant/
 商户中心
 http://125.69.76.146:9980/baccy/baccy/
 新商盟
 
 
 */


#define BaseURL @"http://apis.inlee.com.cn/" //正式
//#define BaseURL @"http://125.69.76.146:1474/" //测试

#define MainURL @"http://merchant.inlee.com.cn/"
#define XSMURL @"http://busilinq.com:18080/"
#define FILEURL @"http://file.inlee.com.cn:8011/" //文件路径

#define FILE_IMG_URL @"http://file.inlee.com.cn:8011/file/images"

#define microURL @"http://125.69.76.146:7081/"

//烟草
#define BACCY_URL @"http://admin.inlee.com.cn:9980/"//正式
//#define BACCY_URL @"http://125.69.76.146:8895/"//测试

//#define MerchantURL @"http://125.69.76.146:1475/" //test
#define MerchantURL @"http://merchant.inlee.com.cn/" //正式

#define NavColor [UIColor colorWithHexString: @"#C31223"]
#define BlueColor RGBCOLOR(19.0,116.0,231.0)

#define UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define CELL [AppManager person].cell
#define RealName  [AppManager person].realName

//#define MemberId [AppManager person].memberId

#define MemberId [[NSUserDefaults standardUserDefaults] objectForKey: @"memberId"]

#define CurentQRCode @""

#define key_RodeCode @"rodeCode" //角色 -1 新用户， 0 店主  1 店员
#define key_CurrentRodeCode [[NSUserDefaults standardUserDefaults] objectForKey: key_RodeCode]

#define key_Zone1 @"key_Zone1" //一级城市
#define key_Zone2 @"key_Zone2" //二级城市



#define Login_password   [[NSUserDefaults standardUserDefaults] objectForKey: @"UD_PWD"]
#define Login_username   [[NSUserDefaults standardUserDefaults] objectForKey: @"UD_PHONE"]

///烟草个人信息
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]

#define C_CustID  [[NSUserDefaults standardUserDefaults] objectForKey:@"Q_CustID"]
#define C_Phone  [[NSUserDefaults standardUserDefaults] objectForKey:@"Q_Phone"]
#define C_password  [[NSUserDefaults standardUserDefaults] objectForKey:@"Q_password"]
///是否是易付用户
#define XSM_ISEPAY  ![[[NSUserDefaults standardUserDefaults] objectForKey:@"result_code"] boolValue]


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DEF_Gray_Text9Color UIColorFromRGB(0x999999)
#define DEF_BackGroundColor UIColorFromRGB(0xf4f4f4)


#endif /* AppMacro_h */
