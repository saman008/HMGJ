//
//  ThirdParyMarco.h
//  Yl
//
//  Created by qzp on 2017/2/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#ifndef ThirdParyMarco_h
#define ThirdParyMarco_h

#define JPush_AppKey @"38c285d7254da04ea2199585"
#define JPush_MasterSecret @"9f4f08d33907b07f368920be"


#pragma mark -DB-
#define DBName @"merchant.db"
#define Person_table @"Person_table"
#define Person_DB_Key @"Person_DB_key"
#define Role_Table @"Role_Table"
#define ShopList_Table @"ShopList_Table"
#define ShopList_Key @"ShopList_Key"
#define Current_role_Table @"Current_role_Table"
#define RoleCode_Key @"roleCode" //当前角色
#define Key_role_statusCode @"Key_role_statusCode" //当前角色返回码 2006没权限
#define Key_RoleParams @"Key_RoleParams"
#define Key_eAccountFlag @"eAccountFlag" ///是否开通E账户 0-未开通 1-已开通
#define Key_tobaccoFlag @"tobaccoFlag" ///是否启用订烟功能 0-不启用 1- 启用


#define ShowMessage(msg) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
otherButtonTitles: @[] ];\
}\

#define ShowMessage2(msg,mId,btnTitle1,btnTitle2) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: mId alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: btnTitle2 \
otherButtonTitles: @[btnTitle1]];\
}\

#define ShowMessage3(alertTitle,msg,mId,btnTitle2,btnTitle1) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: alertTitle message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: mId alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: btnTitle1 \
otherButtonTitles: @[btnTitle2]];\
}\

#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
#define ShowSuccess(msg)  [[SMProgressHUD shareInstancetype] showTip: msg];




#endif /* ThirdParyMarco_h */
