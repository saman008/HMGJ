//
//  HttpRequest.m
//  Yl
//
//  Created by qzp on 2017/2/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "HttpRequest.h"
#import <YTKKeyValueStore/YTKKeyValueStore.h>

#import "NSObject+HUD.h"
#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppMacro.h"
#import "AppManager.h"
#import "QZPToolHeader.h"
#import <YYModel/YYModel.h>
#import "ThirdParyMarco.h"
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowMessage(msg) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
otherButtonTitles: @[] ];\
}\


#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
#define ShowSuccess(msg)  [[SMProgressHUD shareInstancetype] showTip: msg]

@implementation HttpRequest

+ (void)loginWithPassword:(NSString *)pwd userName:(NSString *)userName equipNo:(NSString *)equipNo results:(resultBlock)resultsBlock {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSDictionary * params = @{@"password": pwd,
                              @"username": userName,
                              @"equipNo": equipNo,
                              @"version": app_Version};
    [MBProgressHUD showBusy];
    [HttpBaseRequest requestWithURL: @"sso/member/login" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        NSLog(@"登录信息-%@", anyobject);
        [MBProgressHUD hideProgress];
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)registerWithPassword:(NSString *)pwd userName:(NSString *)userName challenge:(NSString *)challenge results:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"password": pwd,
                              @"cell": userName,
                              @"challenge": challenge};
    [HttpBaseRequest requestWithURL: @"sso/member" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)sendCodeWithCell:(NSString *)phone results:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"cell": phone};
    [HttpBaseRequest requestWithURL: @"sso/member/challenge" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)updatePersonInfoWithCell:(NSString *)phone otherInfoDic:(NSDictionary *)otherDic results:(resultBlock)resultsBlock {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: otherDic];
    [params setObject: phone forKey: @"cell"];
    [HttpBaseRequest requestWithURL: @"sso/member/modify" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
    
}

+ (void)rebindCell:(NSString *)phone results:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"cell": phone};
    [HttpBaseRequest requestWithURL: @"sso/member/rebind" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}

+ (void)modifyPasswordWithCell:(NSString *)cell challenge:(NSString *)challenge password:(NSString *)pwd results:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"cell": cell,
                            @"challenge": challenge,
                              @"password": pwd};
    [HttpBaseRequest requestWithURL: @"sso/member/password" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}

+ (void)postRenderWithJpushCode:(NSString *)jpushCode results:(resultBlock)resultsBlock {
    NSString * uuid32 = UUID;
    if (UUID.length > 32) {
        uuid32 = [UUID substringToIndex: 31];
    }
    NSString * equpOS = [NSString stringWithFormat:@"%@,%@,%@,%@",@"iOS",[[UIDevice currentDevice] systemVersion] ,@"iphone",@"iphone"];
    
    NSDictionary * params = @{@"equipNo": UUID,
                              @"memberId": MemberId,
                              @"equipOS":  equpOS,
                              @"jpushCode": jpushCode,
                              @"cell": CELL
                              };
    
    [HttpBaseRequest requestWithURL: @"sso/member/report" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)getDailyWithPageSize:(NSInteger)pageSize pageNumber:(NSInteger)pageNumber queryDate:(NSString *)queryDate  qrCode: (NSString *) rqCode result:(resultBlock)resultsBlock {
    NSDictionary * dic = @{@"pageSize": [NSNumber numberWithInteger: pageSize],
                           @"pageNumber": [NSNumber numberWithInteger: pageNumber],
                           @"queryDate": queryDate,
                           @"memberId": MemberId
                           };
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: dic];
    if (rqCode != nil) {
        [params setObject: rqCode forKey: @"qrCode"];
    }
    [HttpBaseRequest requestWithURL: @"shop/bills/daily" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
          resultsBlock(code, msg, anyobject);
    }];
}
+ (void)getMonthWithPageSize:(NSInteger)pageSize pageNumber:(NSInteger)pageNumber  qrCode: (NSString *) rqCode result:(resultBlock)resultsBlock {
    NSDictionary * dic = @{@"pageSize": [NSNumber numberWithInteger: pageSize],
                              @"pageNumber": [NSNumber numberWithInteger: pageNumber],
                             @"memberId": MemberId};
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: dic];
    if (rqCode != nil) {
        [params setValue: rqCode forKey: @"qrCode"];
    }
    [HttpBaseRequest requestWithURL: @"shop/bills/monthly" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+(void)getBillsCurrentWithQRCode:(NSString *)rqCode result:(resultBlock)resultsBlock {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: @{ @"memberId": MemberId}];
    if (rqCode != nil) {
        [params setValue: rqCode forKey: @"qrCode"];
    }
    
    [HttpBaseRequest requestWithURL: @"shop/bills/current" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}


+ (void)employeeSignWithShopQRCode:(NSString *)shopQRCode result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"shopQRCode": shopQRCode};
    [HttpBaseRequest requestWithURL: @"shop/employee/sign" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}


+ (void)employeeApplyWithRoleCode:(NSString *)roleCode shopName:(NSString *)shopName shopQRCode:(NSString *)shopQRCode realName:(NSString *)realName industry:(NSString *) industry result:(resultBlock)resultsBlock {
    NSDictionary * dic = @{@"memberId": MemberId,
                              @"roleCode": roleCode,
                           @"industry": industry
                             };
    NSMutableDictionary * paramse = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (shopQRCode != nil) {
        [paramse setObject: shopQRCode forKey:@"shopQRCode"];
    }
    if (realName != nil) {
        [paramse setObject: realName forKey:@"realName"];
    }
    if (shopName != nil) {
        [paramse setObject: shopName forKey: @"shopName"];
    }
    QLog(@"%@", paramse);
    
    [HttpBaseRequest requestWithURL: @"shop/employee/apply" params: paramse method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];

}


+ (void) employeeListWithStatus:(NSString *)status shopQRCode:(NSString *)shopQRCode result:(resultBlock)resultsBlock {
    if (shopQRCode == nil) {
        resultsBlock(400, @"失败", @{});
        return;
    }
    NSDictionary * dic = @{@"memberId": MemberId,
                              @"shopQRCode": shopQRCode,
                              };
    
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: dic];
    if (status != nil) {
        [params setObject: status forKey: @"status"];
    }
    [HttpBaseRequest requestWithURL: @"shop/employee/list" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
 
}

+ (void)employeeVerifyWithOperMID:(NSString *)operMid applyerMID:(NSString *)applyerMid shopQRCode:(NSString *)shopQRCode status:(NSString *)status result:(resultBlock)resultsBlock {
    NSDictionary * params= @{@"operMId": operMid,
                             @"applyerMId": applyerMid,
                             @"shopQRCode": shopQRCode,
                             @"status": status};
    [HttpBaseRequest requestWithURL: @"employee/verify" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}

+ (void)emloyeefieWithOperMID:(NSString *)operMId firedMId:(NSString *)firedMId shopQRCode:(NSString *)shopQRCode result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"operMId": operMId,
                              @"firedMId": firedMId,
                              @"shopQRCode": shopQRCode};
    [HttpBaseRequest requestWithURL: @"shop/employee/fire" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)emloyeeswapWithOperMID:(NSString *)operMID targetMID:(NSString *)targetMID targetRole:(NSString *)targetRole targetShopQRCode:(NSString *)targetShopQRCode targetStatus:(NSString *)targetStatus shopQRCode:(NSString *)shopQRCode result:(resultBlock)resultsBlock {
    NSDictionary * dic = @{@"operMId": operMID,
                              @"targetMId": operMID,
                              @"targetRole": targetRole,
                              @"targetShopQRCode": targetShopQRCode,
                              @"targetStatus": targetStatus,
                              @"shopQRCode": shopQRCode};
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: dic];
    [HttpBaseRequest requestWithURL: @"employee/swap" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}

+ (void)employeeoneWithShopQRCode:(NSString *)shopQRCode status:(NSString *)status result:(resultBlock)resultsBlock {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: @{@"memberId": MemberId}];
    if (shopQRCode != nil) {
        [params setObject: shopQRCode forKey: @"shopQRCode"];
    }
    if (status != nil) {
        [params setObject: status forKey: @"status"];
    }
    [HttpBaseRequest requestWithURL: @"shop/employee/one" params: params method: MethodTypeGET completion:^(NSInteger statusCode, NSString *msg, id anyobject) {
        YTKKeyValueStore * store = [[YTKKeyValueStore alloc] initDBWithName: DBName];
        [store createTableWithName: Current_role_Table];
        [store putString:[NSString stringWithFormat:@"%ld", (long)statusCode] withId: Key_role_statusCode intoTable: Current_role_Table];
     
        
        if (statusCode != HttpResponseCodeSuccess) {
            [store putString: @"3" withId: RoleCode_Key intoTable: Current_role_Table];
            
        } else {
            [store putString: anyobject[@"roleCode"] withId: RoleCode_Key intoTable: Current_role_Table];
            [store putString: anyobject[@"eAccountFlag"] withId: Key_eAccountFlag intoTable: Current_role_Table];
            [store putString: anyobject[@"tobaccoFlag"] withId: Key_tobaccoFlag intoTable: Current_role_Table];
            
            [store putObject: anyobject withId: Key_RoleParams intoTable: Current_role_Table];
        }
        resultsBlock(statusCode, msg, anyobject);
    }];
}


+ (void)addShopWithShopName:(NSString *)shopName industry:(NSString *)industry model:(NSString *)model adress:(NSString *)adress result:(resultBlock)resultsBlock {
    NSDictionary * dic = @{
                           @"memberId": MemberId};
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: dic];
    if (model != nil) {
        [params setObject: model forKey: @"model"];
    }
    if (adress != nil) {
        [params setObject: adress forKey: @"address"];
    }
    if (shopName!= nil) {
        [params setObject: shopName forKey: @"shopName"];
    }
    if(industry != nil) {
        [params setObject: industry forKey: @"industry"];
    }
    [HttpBaseRequest requestWithURL: @"shop/shop" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
    
}

+ (void)updateShopInfoWithShopName:(NSString *)shopName shopQRCode:(NSString *)shopQRCode industry:(NSString *)industry model:(NSString *)model address:(NSString *)address result:(resultBlock)resultsBlock {
    NSDictionary * dic = @{@"memberId": MemberId,
                           @"shopQRCode": shopQRCode,
                           @"industry": industry};
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: dic];
    if (model != nil) {
        [params setObject: model forKey: @"model"];
    }
    if (address != nil) {
        [params setObject: address forKey: @"address"];
    }
    if(shopName != nil) {
        [params setObject: shopName forKey: @"shopName"];
    }
    [HttpBaseRequest requestWithURL: @"shop/shop" params: params method: MethodTypePUT completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)getShopInfoWithShopQRCode:(NSString *)shopQRCode result:(resultBlock)resultsBlock {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: @{@"memberId": MemberId}];
    if (shopQRCode != nil) {
        [params setObject: shopQRCode forKey: @"shopQRCode"];
    }
    [HttpBaseRequest requestWithURL: @"shop/shop" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);

    }];
}

+ (void)getShopListWithShopQRCode:(NSString *)shotQRCode result:(resultBlock)resultsBlock {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary:@{@"memberId": MemberId}];
    if (shotQRCode != nil) {
        [params setObject: shotQRCode forKey: @"shopQRCode"];
      
    }
    [HttpBaseRequest requestWithURL: @"shop/shop/list" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)shopSwapWithOperMId:(NSString *)operMId shopQRCode:(NSString *)shopQRCode targetMId:(NSString *)targetMId  targetRole: (NSString *) targetRole targetShopQRCode: (NSString *) targetShopQRCode targetStatus: (NSString *)targetStatus result:(resultBlock)resultsBlock {

    NSDictionary * dicx =@{
                           @"operMId": operMId
                           };
    NSMutableDictionary * pMd = [NSMutableDictionary dictionaryWithDictionary: dicx];
    if (targetStatus != nil) {
        [pMd setObject: targetStatus forKey:@"targetStatus"];
    }
    if (targetShopQRCode != nil) {
        [pMd setObject: targetShopQRCode forKey: @"targetShopQRCode"];
    }
    if (targetRole != nil) {
        [pMd setObject: targetRole forKey: @"targetRole"];
    }
    if (targetMId != nil) {
        [pMd setObject: targetMId forKey: @"targetMId"];
    }
    if (shopQRCode != nil) {
        [pMd setObject: shopQRCode forKey: @"shopQRCode"];
    }

    [HttpBaseRequest requestWithURL: @"shop/employee/swap" params: pMd method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
    
 

}

+ (void)shopDeleteWithShopQRCode:(NSString *)shopQRCode result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"shopQRCode": shopQRCode,
                              @"memberId": MemberId};
    [HttpBaseRequest requestWithURL: @"shop/shop/close" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
           resultsBlock(code, msg, anyobject);
    }];
}


+ (void)wechatPrepayWithAmount:(NSString *)amount openId:(NSString *)openId qrCode:(NSString *)qrCode staffMId:(NSString *)staffMId result:(resultBlock)resultsBlock {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: @{@"amount": amount,
                                                                                    @"openId": openId,
                                                                                    @"qrCode": qrCode}];
    if (staffMId != nil) {
        [params setObject: staffMId forKey: @"staffMId"];
    }
    [HttpBaseRequest requestWithURL: @"wechat/prepay" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)wechatResultFromAppWithOutTradeNo:(NSString *)outTradeNo transactionId:(NSString *)transactionId amount:(NSString *)amount state:(NSString *)state stateMsg:(NSString *)stateMag transTime:(NSString *)transTime result:(resultBlock)resultsBlock {
    NSDictionary * parames = @{@"outTradeNo": outTradeNo,
                               @"transactionId": transactionId,
                               @"amount": amount,
                               @"state": state,
                               @"stateMsg": stateMag,
                               @"transTime": transTime};
    [HttpBaseRequest requestWithURL: @"wechat/resultFromApp" params: parames method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)wechatQueryWithOutTradeNo:(NSString *)outTradeNo qrCode:(NSString *)qrCode empMId:(NSString *)empMId result:(resultBlock)resultsBlock {
    NSDictionary * dic = @{@"outTradeNo": outTradeNo,
                           @"qrCode": qrCode};
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: dic];
    if (empMId != nil) {
        [params setObject: empMId forKey: @"empMId"];
    }
    [HttpBaseRequest requestWithURL: @"wechat/query" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}



+ (void)ebankBalance:(resultBlock)resultsBlock {
    NSDictionary * dic = @{@"memberId": MemberId};
    [HttpBaseRequest requestWithURL: @"shop/ebank/balance" params: dic method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}
+ (void)ebankTransWithCurrentPage:(NSInteger)currentPage showCount:(NSInteger)count startDate:(NSString *)startDate endDate:(NSString *)endDate transType:(NSString *)transType result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"currentPage": [NSNumber numberWithInteger: currentPage],
                              @"showCount": [NSNumber numberWithInteger: count],
                              @"startDate": startDate,
                              @"endDate": endDate,
                              @"transType": transType};
    [HttpBaseRequest requestWithURL: @"shop/ebank/trans" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)ebankProfitRatioWithCurrentPage:(NSInteger)currentPage showCount:(NSInteger)count startDate:(NSString *)startDate endDate:(NSString *)endDate result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"currentPage": [NSNumber numberWithInteger: currentPage],
                              @"showCount": [NSNumber numberWithInteger: count],
                              @"startDate": startDate,
                              @"endDate": endDate};
    [HttpBaseRequest requestWithURL: @"shop/ebank/finance/profitRatio" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}

+ (void)ebankRechrgeWithAmout:(NSInteger)amount password:(NSString *)password result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"amount": [NSNumber numberWithInteger: amount],
                              @"passWord": password,
                              };
    [HttpBaseRequest requestWithURL: @"shop/ebank/recharge" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void) ebankGetCardWithCustCode:(NSString *) custCode result: (resultBlock) resultsBlock{
    NSDictionary * dic  = @{@"memberId": MemberId};
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary: dic];
    if (custCode != nil) {
        [params setObject:custCode forKey: @"custCode"];
    }
    [HttpBaseRequest requestWithURL: @"shop/ebank/card" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)ebankCashoutWithAmount:(NSInteger)amount password:(NSString *)password result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"amount": [NSNumber numberWithInteger: amount],
                              @"passWord": password,
                              };
    
    [HttpBaseRequest requestWithURL: @"shop/ebank/cashout" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)ebankApplyWithBankCardNo:(NSString *)bankCardNo userName:(NSString *)userName creditNo:(NSString *)creditNo reserveMobile:(NSString *)reserveMobile smsValidCode:(NSString *)smsValidCode result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"bankCardNo": bankCardNo,
                              @"userName": userName,
                              @"creditNo": creditNo,
                              @"reserveMobile": reserveMobile,
                              @"smsValidCode": smsValidCode,
                              @"cell": CELL};
    [HttpBaseRequest requestWithURL: @"shop/ebank/apply" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}
//==============具体实现网络连接请求
+ (void)ebankChallengeWithCell:(NSString *)cell result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"cell": cell};
    [HttpBaseRequest requestWithURL: @"merchant/account/sendSmsCode" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)ebankAcountWtihPassword:(NSString *)password result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"passWord": password};
    [HttpBaseRequest requestWithURL: @"shop/ebank/acount" params:params method: MethodTypePUT completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)ebankAcountWithBankCardNo:(NSString *)bankCardNo reserveMobile:(NSString *)reserveMobile smsValidCode:(NSString *)smsValidCode modiType:(NSString *)modiType result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"bankCardNo":bankCardNo,
                              @"reserveMobile": reserveMobile,
                              @"smsValidCode": smsValidCode,
                              @"modiType": modiType};
    [HttpBaseRequest requestWithURL: @"shop/ebank/replace" params:params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)xmsCustomerLoginWithCellPhone:(NSString *)cellPhone password:(NSString *)password name:(NSString *)name result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"cellphone": cellPhone,
                              @"j_password": password,
                              @"j_username": name};
    [HttpBaseRequest requestWithURL: @"customer/login" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
    
}

+ (void)messageListWithCategory:(NSString *)category result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"equipOS": @"iOS",
                              @"category": category,
                              @"memberId": MemberId};
    [HttpBaseRequest requestWithURL: @"message/messageList" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
               resultsBlock(code, msg, anyobject);
    }];
}

+ (void)getModel:(NSString *)modelId result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"modelId": modelId};
    [HttpBaseRequest requestWithURL: @"message/searchModel" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}



+ (void)registerWithCell:(NSString *)cell password:(NSString *)password result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"cell": cell, @"password": password};
    [HttpBaseRequest requestWithURL: @"sso/member/cell" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}

+ (void)postCode:(NSString *)code  memberId: (NSString *) mb result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"challenge": code,
                              @"memberId": mb};
    [HttpBaseRequest requestWithURL:@"sso/member/challenge" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
             resultsBlock(code, msg, anyobject);
    }];
}

+ (void)completionRegistWithMemberCredentials:(NSArray *)marray   memberId: (NSString *) mb result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"memberId": mb,
                              @"memberCredentials": marray};
    [HttpBaseRequest requestWithURL:@"sso/member/finish" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}

+ (void)modifyHeadWithCell:(NSString *)cell fileUrl:(NSString *)fileUrl result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"cell": cell,
                              @"fileUrl": fileUrl};
    [HttpBaseRequest requestWithURL: @"sso/member/head" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
    
}

+ (void)storeList:(resultBlock)resultsBlock {
    [HttpBaseRequest requestWithURL:@"merchant/store/list" params:@{@"masterMId": MemberId} method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}

+ (void)employeeOne:(resultBlock)resultsBlock {
    [HttpBaseRequest requestWithURL:@"merchant/employee/one" params: @{@"memberId": MemberId} method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        
        ///保存本地shagn'h
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject: anyobject];
        [userDefaults setValue: data forKey: @"emplyeeOne"];
        
        if(code == HttpResponseCodeSuccess) {

            if ([anyobject[@"roleCode"] isKindOfClass:[NSNull class]]) {
                [userDefaults setValue: @"-3" forKey: key_RodeCode];
            }else {
               [userDefaults setValue: anyobject[@"roleCode"] forKey: key_RodeCode];
            }
         
        } else if(code == 404){//没有创建商户
            [userDefaults setValue: @"-2" forKey: key_RodeCode];
            [HttpRequest employeeCreate:^(NSInteger statusCode, NSString *msg, id anyobject) {
                QLog(@"创建商户=-%ld-%@-%@", (long)statusCode, msg, anyobject);
            }];
            
        } else {//没有创建商户
            [userDefaults setValue: @"-1" forKey: key_RodeCode];
            [HttpRequest employeeCreate:^(NSInteger statusCode, NSString *msg, id anyobject) {
                QLog(@"创建商户=-%ld-%@-%@", (long)statusCode, msg, anyobject);
            }];
            
        }
        [userDefaults synchronize];
        resultsBlock(code, msg, anyobject);
        
        
    }];
}


+ (void)employeeListWithShopQRCode:(NSString *)shopQRCode result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"shopQRCode": shopQRCode,
                              @"memberId": MemberId};
    [HttpBaseRequest requestWithURL: @"merchant/employee/list" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultsBlock(code, msg, anyobject);
    }];
}

+ (void)storeOneWithShopQRCode:(NSString *)shopQRCode result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"shopQRCode": shopQRCode,
                              @"memberId": MemberId};
    [HttpBaseRequest requestWithURL: @"merchant/store/one" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)employeeFireWithShopQRCode:(NSString *)shopQRCode firedMId:(NSString *)firedMId result:(resultBlock)resultsBlock {
    NSDictionary * params = @{@"shopQRCode": shopQRCode,
                              @"operMId": MemberId,
                              @"firedMId": firedMId};
    [HttpBaseRequest requestWithURL:@"merchant/employee/fire" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultsBlock(code, msg, anyobject);
    }];
}

+ (void)storeDeleteWithShopQRCode:(NSString *)shopQRCode result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"shopQRCode": shopQRCode,
                              @"masterMId": MemberId};
    [HttpBaseRequest requestWithURL: @"merchant/store/delete" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}


+ (void)sellrangList:(resultBlock)resultBlock {
    NSDictionary * params = @{@"memberId": MemberId};
    [HttpBaseRequest requestWithURL:@"sso/sellrang/list" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}

+ (void)chooseSellrang:(NSArray *)list result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"randIds": list,
                              @"memberId": MemberId};
    [HttpBaseRequest requestWithURL:@"sso/member/choose" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}

+ (void)careateShopWithShopName:(NSString *)shopName shopImgUrl:(NSString *)shopImgUrl industry:(NSArray *)industry certificate:(NSArray *)certificate shopCodePrefix:(NSString *)shopCodePrefix result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"shopName": shopName,
                              @"masterMId":MemberId,
                              @"shopCodePrefix": shopCodePrefix,
                              @"shopImgUrl": shopImgUrl,
                              @"industry": industry,
                              @"certificate":certificate};
    
    
    [HttpBaseRequest requestWithURL:@"merchant/store/create" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}
+ (void)applyWithUrl:(NSString *)url result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"shopQRCode": url};
    [HttpBaseRequest requestWithURL:@"merchant/employee/apply" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
          resultBlock(code, msg, anyobject);
    }];
}


+ (void)storeOne:(resultBlock)resultBlock {
    NSDictionary * params = @{@"memberId": MemberId};
    [HttpBaseRequest requestWithURL:@"merchant/store/one" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultBlock(code, msg, anyobject);
    }];
}

+ (void)getAvailable:(resultBlock)resultBlock {
    //////////////////////////////////////////////需要改成memberid
    NSDictionary * params = @{@"memberId": MemberId,@"appId":@"baccy"};
    [HttpBaseRequest requestWithURL:@"micro/app/userInfo" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}
+ (void)getAvailableAll:(resultBlock)resultBlock {
    [HttpBaseRequest requestWithURL:@"sso/services/getAvailable" params: @{} method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}

+ (void)paymentTransactionWithCategory:(NSString *)category dataJson:(NSString *)dataJson transactionNo:(NSString *)transactionNo  sign:(id) sign result:(resultBlock2)resultsBlock {
    NSDictionary * params = @{@"id": MemberId,
                              @"transactionNo": transactionNo,
                              @"transactionDate": todayDate(@"yyyy-MM-dd HH:ss:mm"),
                              @"dataJson": dataJson,
                              @"channel": @"MERCHANT",
                              @"provider": @"ios",
                              @"category": category};
//    [HttpBaseRequest requestWithURL:@"payment/transaction" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
//        resultsBlock(code, msg, anyobject);
//    }];
    
    [HttpBaseRequest requestWithURL:@"payment/transaction" params: params method: MethodTypePOST sign: sign completion:^(NSInteger code, NSString *msg, id anyobject, id rSign) {
        resultsBlock(code, msg, anyobject, sign);
    }];
//    
}
+ (void)storeValidation:(NSString *)qrCodeSelf qrCodeOther:(NSString *)qrCodeOther result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"qrCodeSelf": qrCodeSelf,
                              @"qrCodeOther": qrCodeOther};
    [HttpBaseRequest requestWithURL:@"merchant/store/validation" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
            resultBlock(code, msg, anyobject);
    }];
}

+ (void)storeValidationSuccess:(NSString *)qrCodeSelf qrCodeOther:(NSString *)qrCodeOther result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                              @"qrCodeSelf": qrCodeSelf,
                              @"qrCodeOther": qrCodeOther};
    [HttpBaseRequest requestWithURL:@"merchant/store/validationSuccess" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}


+ (void)employeeCreate:(resultBlock)resultBlock {
    PersonModel * person = [AppManager person];
    NSDictionary * dic ;
    if (person.realName == nil) {
        dic = @{@"realName":@"",
                @"memberId": MemberId};
        return;
    } else {
        dic = @{@"memberId": MemberId,
                @"realName": person.realName};
    }

    
    
    [HttpBaseRequest requestWithURL:@"merchant/employee/create" params: dic method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}

+ (void)getFirst:(resultBlock)resultBlock {
    NSDictionary * params = @{@"memberId": MemberId,
                          };
    [HttpBaseRequest requestWithURL:@"inform/acquire" params:params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        
          resultBlock(code, msg, anyobject);
    }];
}

+ (void)getOrganizeById:(NSString *)ID result:(resultBlock)resultblock {
    NSDictionary * params = @{@"id":ID};
    [HttpBaseRequest requestWithURL:@"baccy/baccy/organize" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultblock(code, msg, anyobject);
    }];
}

+ (void)xsmLoginWithPhone:(NSString *)phone password:(NSString *)password  custId:(NSString *)custId  orgCode:(NSString *)orgCode result:(resultBlock)resultblock {
    
   // MemberId = @"29c00f6dcfe1d729a6c02b16b444ad0b18608009015";
    NSLog(@"%@", MemberId);
    NSLog(@"%@", orgCode);
    NSLog(@"%@", custId);
    NSLog(@"%@", password);
    NSDictionary * params = @{@"memberId": MemberId,
                              @"cell":phone,
                              @"orgCode": orgCode,
                              @"custId": custId,
                              @"password": password};
    [HttpBaseRequest requestWithURL:@"baccy/baccy/authorize" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
              resultblock(code, msg, anyobject);
    }];
}

+ (void)aaxsmLoginWithPhone:(NSDictionary *)params result:(resultBlock)resultblock {

    
    [HttpBaseRequest requestWithURL:@"baccy/baccy/authorize" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultblock(code, msg, anyobject);
    }];
}

+ (void)xsmGetCurrentBillsWithCustId:(NSString *)custId result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"custId": custId};
    [HttpBaseRequest requestWithURL:@"baccy/baccy/bills/current" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}
+ (void)xsmGetBillsListWithCustId:(NSString *)custId result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"custId": custId};
      NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    id cigareetList = [NSKeyedUnarchiver unarchiveObjectWithData: [userDefault objectForKey:@"cigaretteList"]];
    //有数据就返回
    if ([cigareetList isKindOfClass:[NSArray class]]) {
        if ([cigareetList count] > 0) {
            resultBlock(200,@"成功",cigareetList);
            return;
        }
    }
    
    
    [HttpBaseRequest requestWithURL:@"baccy/baccy/cigarette/list" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        
        //本地保存
        if(code ==HttpResponseCodeSuccess) { //保存烟品列表
          
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject: anyobject];
            [userDefault setObject: data forKey: @"cigaretteList"];
            [userDefault synchronize];
        }
        
        resultBlock(code, msg, anyobject);
    }];
}


+ (void)xsmFavoriteWithCustId:(NSString *)custId result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"custId": custId};
    [HttpBaseRequest requestWithURL:@"baccy/baccy/favorite" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}


+ (void)xsmGetOrder:(resultBlock)resultBlock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSString * begin = lastDate(@"yyyyMMdd",1);
    NSString * lastYear = preDate(@"yyyyMMdd", 365);
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              @"begin": lastYear,
                              @"end": begin};
    [HttpBaseRequest requestWithURL:@"baccy/baccy/bills/his/head" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
         resultBlock(code, msg, anyobject);
    }];
}

+ (void)xsmGetOrderDetailWithOrderNo:(NSString *)orderNo result:(resultBlock)resultBlock {
 CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              @"billsNo": orderNo};
    [HttpBaseRequest requestWithURL:@"baccy/baccy/bills/his/lines" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}

+ (void)xsmOrderPayResultWithOrderNo:(NSString *)orderNo ref_id:(NSString *)ref_id company_id:(NSString *)company key :(NSString *)key service_code:(NSString *)service_code version:(NSString *)version result:(resultBlock)resultBlock {
    NSDictionary * params = @{@"from_order_id": orderNo,
                              @"ref_id": ref_id,
                              @"company_id": company,
                              @"key": key,
                              @"service_code": service_code,
                              @"version": version};
    [HttpBaseRequest requestWithURL:@"http://www.zdepay.com/epay/order/pay/result/qryPhone" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];

}
+ (void)xsmGetLimt:(resultBlock)resultBlock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                             };
    [HttpBaseRequest requestWithURL:@"baccy/baccy/merchant/limit" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}

+ (void)xsmGetSingleLimtByCgtCodes:(NSString *)cgtCodes result:(resultBlock)resultBlock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                             @"orderDate": personInfo.orderDate,
                              @"cgtCodes": cgtCodes};
    [HttpBaseRequest requestWithURL:@"baccy/baccy/cigarette/limit" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}


+ (void)xsmgetOrgarm:(resultBlock)resultblock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              };
    [HttpBaseRequest requestWithURL:@"baccy/baccy/orgparm" params: params method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultblock(code, msg, anyobject);
    }];
}

+ (void)xsmUpdateOrderWithCoNum:(NSString *)coNum details:(NSArray *)details result:(resultBlock)resultBlock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              @"orderDate": personInfo.orderDate,
                              @"coNum":coNum,
                              @"details": details
                              };
    
    [HttpBaseRequest requestWithURL:@"baccy/baccy/bills/update" params: params method:MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];

}

+ (void)xsmSubmitOrder:(NSArray *)details result:(resultBlock)resultBlock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              @"orderDate": personInfo.orderDate,
                              @"details": details
                              };
    
    [HttpBaseRequest requestWithURL:@"baccy/baccy/bills/update" params: params method:MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultBlock(code, msg, anyobject);
    }];
}

+ (void)xsmIsEpay:(NSString *)ref_id key:(NSString *)key service:(NSString *)service_code version:(NSString *)version result:(resultBlock) resultBlock{
    NSDictionary * params = @{
                              @"ref_id": ref_id,
                              @"key": key,
                              @"service_code": service_code,
                              @"version": version};
    
    [HttpBaseRequest requestWithURL:@"http://www.zdepay.com/front/judgeByRefid" params: params method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
       
        resultBlock(code, msg, anyobject);
    }];

}

+ (void)xsmDeleteOrderWithBillsNo:(NSString *)billsNo result:(resultBlock)resultblock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              @"billsNo":billsNo
                              };
    
    [HttpBaseRequest requestWithURL:@"baccy/baccy/bills" params: params method:MethodTypeDELETE completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultblock(code, msg, anyobject);
    }];
}

+ (void)xsmAllowForPhoneWithCoNum:(NSString *)coNum ordQtySum:(NSString *)ordQrySum ordAmtSum:(NSString *)ordAmtSum result:(resultBlock)resultblock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              @"coNum": coNum,
                              @"ordQtySum":ordQrySum,
                              @"ordAmtSum": ordAmtSum
                              };
    
    [HttpBaseRequest requestWithURL:@"baccy/baccy/allowforphone" params: params method:MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultblock(code, msg, anyobject);
    }];
}

+(void)xsmPayWIthBillNo:(NSString *)billNo payword:(NSString *)payword result:(resultBlock)resultblock {
     CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              @"bill_acct_id": billNo,
                              @"payword": payword};
    [HttpBaseRequest requestWithURL:@"epay/epay" params: params method:MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultblock(code, msg, anyobject);
    }];

}
+(void)xsmPayBillCheckStateWithKey:(NSString *)key from_order_id:(NSString *)fid ref_id:(NSString *)ref_id bill_acct:(NSString *)bill_acct exp_date:(NSString *)exp_date order_type:(NSString *)order_type result:(resultBlock)resultblock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              @"key": @"FD3BFAB4421CE0196203CD039AA8945D",
                              @"version":@"1.0.0",
                              @"service_code":@"035",
                              @"from_order_id":fid,
                              @"ref_id": ref_id,
                              @"bill_acct": bill_acct,
                              @"exp_date": exp_date,
                              @"order_type": @"101"};
    //?custId= 510321100232&bill_acct=11416720&exp_date=20171019&from_order_id=XZG500000057258&key=FD3BFAB4421CE0196203CD039AA8945D&order_type=101&ref_id=510321100232&service_code=035&version=1.0.0
//    NSArray *par = @[@"custId",@"key",@"version",@"service_code",@"from_order_id",@"ref_id",@"bill_acct",@"exp_date",@"order_type"];
//    NSString *boundary = @"boundary";
//    
//    NSMutableData *data = [NSMutableData  data];
//    [data appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    NSLog(@"%@", par);
//    //遍历keys
//    for(int i=0;i<[par count];i++)
//    {
//        //得到当前key
//        NSString *key=[par objectAtIndex:i];
//        
//        //拼接参数名
//        [data appendData:[[@"Content-Disposition:form-data;name=\"%@\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
//        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        //拼接参数值
//        [data appendData:[personInfo.custCode dataUsingEncoding:NSUTF8StringEncoding]];
//        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//
//        
//        //添加分界线，换行
//        [body appendFormat:@"%@\r\n",MPboundary];
//        //添加字段名称，换2行
//        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
//        //添加字段的值
//        [body appendFormat:@"%@\r\n",[postParems objectForKey:key]];
//        
//        NSLog(@"添加字段的值==%@",[postParems objectForKey:key]);
//    }
    
//    
//     [data appendData:[[NSString stringWithFormat:@"--%@--",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [HttpBaseRequest requestWithURL:@"http://www.zdepay.com/epay/pay/billcheck" params: params method:MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultblock(code, msg, anyobject);
    }];
}


+ (void)xsmPayBillCheckWithKey:(NSString *)key bill_acct_id:(NSString *)bill_acct_id payword:(NSString *)payword result:(resultBlock)resultblock {
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSDictionary * params = @{@"custId": personInfo.custCode,
                              @"key": @"FD3BFAB4421CE0196203CD039AA8945D",
                              @"payword": payword,
                              @"version":@"1.0.0",
                              @"service_code":@"036",
                              @"bill_acct_id": bill_acct_id};
    
    [HttpBaseRequest requestWithURL:@"http://www.zdepay.com/epay/pay/mobilepay" params: params method:MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        resultblock(code, msg, anyobject);
    }];
}

@end
