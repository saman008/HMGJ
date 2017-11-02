//
//  HttpRequest.h
//  Yl
//
//  Created by qzp on 2017/2/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpBaseRequest.h"
#import "CPersonInfo.h"

typedef void (^resultBlock) (NSInteger statusCode, NSString * msg, id anyobject);

typedef void (^resultBlock2) (NSInteger statusCode, NSString * msg, id anyobject, id sign);

@interface HttpRequest : NSObject
#pragma mark -Person-
+ (void) loginWithPassword: (NSString *) pwd userName: (NSString *) userName equipNo: (NSString*) equipNo results: (resultBlock) resultsBlock;

+ (void) registerWithPassword: (NSString *) pwd userName: (NSString *) userName challenge: (NSString *) challenge results: (resultBlock) resultsBlock;
//18608009015
+ (void) sendCodeWithCell: (NSString *) phone results: (resultBlock) resultsBlock;

+ (void) updatePersonInfoWithCell: (NSString *) phone otherInfoDic: (NSDictionary *) otherDic results: (resultBlock) resultsBlock;

+ (void) rebindCell: (NSString *) phone results: (resultBlock) resultsBlock;

+ (void) modifyPasswordWithCell: (NSString *) cell challenge: (NSString *) challenge password: (NSString *) pwd results: (resultBlock) resultsBlock;
///上报推送code
+ (void) postRenderWithJpushCode: (NSString *) jpushCode results: (resultBlock) resultsBlock;
#pragma mark ---bills-
///pageSize 每页显示条数,pageNumber当前页码,queryDate查询日期yyyy-MM-dd
+ (void) getDailyWithPageSize: (NSInteger) pageSize pageNumber: (NSInteger) pageNumber queryDate: (NSString *) queryDate qrCode: (NSString *) qrCode result: (resultBlock) resultsBlock;

+ (void)getMonthWithPageSize: (NSInteger) pageSize pageNumber: (NSInteger) pageNumber  qrCode: (NSString *) rqCode result: (resultBlock) resultsBlock;
///查询当前统计数据
+ (void)getBillsCurrentWithQRCode:(NSString*) rqCode result : (resultBlock) resultsBlock;

#pragma mark --employee--

///签到
+ (void) employeeSignWithShopQRCode:(NSString *) shopQRCode result: (resultBlock) resultsBlock;
///申请店铺岗位
+ (void) employeeApplyWithRoleCode: (NSString *) roleCode shopName: (NSString *) shopName shopQRCode: (NSString *) shopQRCode realName: (NSString *) realName  industry:(NSString *) industry result: (resultBlock) resultsBlock;

///获取所有店员 status  null-全部店员1-审核通过店员  shopQRCode店铺二维码url的参数值
+ (void) employeeListWithStatus: (NSString *) status shopQRCode: (NSString *) shopQRCode result: (resultBlock) resultsBlock;
///店铺岗位申请
+ (void) employeeVerifyWithOperMID: (NSString *) operMid applyerMID: (NSString *)applyerMid shopQRCode: (NSString *) shopQRCode status: (NSString *) status result: (resultBlock) resultsBlock;
///解雇员工
+ (void) emloyeefieWithOperMID: (NSString *) operMId firedMId: (NSString *) firedMId shopQRCode: (NSString *) shopQRCode result: (resultBlock) resultsBlock;
///调整员工
+ (void) emloyeeswapWithOperMID:(NSString *) operMID targetMID: (NSString *) targetMID targetRole: (NSString *)targetRole targetShopQRCode: (NSString *) targetShopQRCode targetStatus: (NSString *) targetStatus shopQRCode: (NSString *) shopQRCode result: (resultBlock) resultsBlock;
///获取店员信息
+ (void) employeeoneWithShopQRCode: (NSString *) shopQRCode status: (NSString *) status result: (resultBlock) resultsBlock;

#pragma mark --shop--
///添加店铺
+ (void) addShopWithShopName: (NSString *) shopName industry: (NSString *) industry model: (NSString *) model adress: (NSString *) adress result: (resultBlock) resultsBlock;
///更新店铺信息
+ (void) updateShopInfoWithShopName: (NSString *) shopName shopQRCode: (NSString *) shopQRCode industry: (NSString *) industry model: (NSString *) model address: (NSString *) address result: (resultBlock) resultsBlock;
///获取店铺信息
+ (void) getShopInfoWithShopQRCode: (NSString *) shopQRCode result: (resultBlock) resultsBlock;
///获取店铺列表
+ (void) getShopListWithShopQRCode: (NSString *) shotQRCode result: (resultBlock) resultsBlock;
///转让店铺
+ (void) shopSwapWithOperMId: (NSString *) operMId shopQRCode: (NSString *) shopQRCode targetMId: (NSString *) targetMId targetRole: (NSString *) targetRole targetShopQRCode: (NSString *) targetShopQRCode targetStatus: (NSString *)targetStatus result: (resultBlock) resultsBlock;
///删除店铺
+ (void) shopDeleteWithShopQRCode: (NSString *) shopQRCode result: (resultBlock) resultsBlock;
///获取评论信息
//+ (void) getShopComments


#pragma mark -pay-
///生成微信预支付订单
+ (void) wechatPrepayWithAmount: (NSString *) amount openId: (NSString *) openId qrCode: (NSString *) qrCode staffMId: (NSString *) staffMId result: (resultBlock) resultsBlock;
///支付结果通知
+ (void) wechatResultFromAppWithOutTradeNo: (NSString *) outTradeNo transactionId: (NSString *) transactionId amount: (NSString *) amount state: (NSString *) state stateMsg: (NSString *) stateMag transTime: (NSString *)transTime result: (resultBlock) resultsBlock;
///支付结果查询
+ (void) wechatQueryWithOutTradeNo: (NSString *) outTradeNo qrCode: (NSString *) qrCode empMId: (NSString *) empMId result: (resultBlock) resultsBlock;

#pragma mark -ebank-
///查询余额
+ (void) ebankBalance: (resultBlock) resultsBlock;
///充值、提现、收益、清算交易明细 transType CZ：充值；TX提现；SY：收益；QS：清算；ALL：全部,
+ (void) ebankTransWithCurrentPage: (NSInteger) currentPage showCount: (NSInteger) count startDate: (NSString *) startDate endDate: (NSString *) endDate transType: (NSString *) transType result: (resultBlock) resultsBlock;
///理财产品每日率
+ (void) ebankProfitRatioWithCurrentPage: (NSInteger) currentPage showCount: (NSInteger) count startDate: (NSString *) startDate endDate: (NSString *) endDate result: (resultBlock) resultsBlock;

///转入
+ (void) ebankRechrgeWithAmout: (NSInteger) amount password: (NSString *) password result: (resultBlock) resultsBlock;
///获取银行卡 custCode 新商盟账号存在则查询易付系统中绑定过得卡，为空则为查询已绑定e账户对应的银行卡
+ (void) ebankGetCardWithCustCode:(NSString *) custCode result: (resultBlock) resultsBlock;
///转出
+ (void) ebankCashoutWithAmount: (NSInteger) amount password: (NSString *) password result: (resultBlock) resultsBlock;
///开户
+ (void) ebankApplyWithBankCardNo: (NSString *) bankCardNo userName: (NSString *) userName creditNo: (NSString *) creditNo reserveMobile: (NSString *) reserveMobile smsValidCode: (NSString *) smsValidCode result: (resultBlock) resultsBlock;
///获取短信验证码 --E账号
+ (void) ebankChallengeWithCell: (NSString *) cell result: (resultBlock) resultsBlock;
///修过e账号信息
+ (void) ebankAcountWtihPassword: (NSString *) password result: (resultBlock) resultsBlock;
///修改卡号或手机号  modiType修改类型（00:改卡；01:改手机号）
+ (void) ebankAcountWithBankCardNo: (NSString *) bankCardNo reserveMobile: (NSString *) reserveMobile smsValidCode: (NSString *) smsValidCode modiType: (NSString *) modiType result: (resultBlock) resultsBlock;

#pragma mark -xms-
///新商盟登录
+ (void) xmsCustomerLoginWithCellPhone: (NSString * ) cellPhone password: (NSString *) password name: (NSString *) name result: (resultBlock) resultsBlock;

+ (void) messageListWithCategory:(NSString *) category result: (resultBlock) resultsBlock;

+ (void) getModel:(NSString *) modelId result: (resultBlock) resultsBlock;


///----------新版登录注册
///注册手机号
+ (void) registerWithCell: (NSString *) cell password:(NSString *) password result: (resultBlock) resultsBlock;
///验证随机码
+ (void) postCode:(NSString *) code  memberId: (NSString *) mb result: (resultBlock) resultsBlock;
///完成注册
+ (void) completionRegistWithMemberCredentials: (NSArray *) marray  memberId: (NSString *) mb result: (resultBlock) resultsBlock;
///修改头像
+ (void) modifyHeadWithCell: (NSString *) cell fileUrl: (NSString *) fileUrl result: (resultBlock) resultsBlock;


///获取店铺列表
+(void) storeList: (resultBlock) resultsBlock;
///获取角色属性
+ (void)employeeOne:(resultBlock) resultsBlock;
///获取店铺店员
+ (void)employeeListWithShopQRCode:(NSString *) shopQRCode result: (resultBlock) resultsBlock;
///获取店铺信息
+ (void) storeOneWithShopQRCode: (NSString *) shopQRCode result:(resultBlock) resultsBlock;
///解雇
+ (void) employeeFireWithShopQRCode: (NSString *) shopQRCode firedMId: (NSString *) firedMId result: (resultBlock) resultsBlock;
///删除店铺
+ (void) storeDeleteWithShopQRCode: (NSString *) shopQRCode result: (resultBlock) resultBlock;
///店铺类型
+ (void)sellrangList: (resultBlock) resultBlock;
///选择店铺类型
+ (void) chooseSellrang:(NSArray *) list result: (resultBlock) resultBlock;
///创建店铺
+(void) careateShopWithShopName: (NSString *) shopName shopImgUrl: (NSString*) shopImgUrl industry:(NSArray *) industry certificate:(NSArray *) certificate  shopCodePrefix:(NSString *) shopCodePrefix result:(resultBlock) resultBlock;
///申请职位
+(void)applyWithUrl:(NSString *) url result:(resultBlock) resultBlock;
///获取店铺信息
+ (void)storeOne:(resultBlock) resultBlock;


///获取会员服务器
+ (void) getAvailable:(resultBlock) resultBlock;

///获取功能列表
+ (void) getAvailableAll: (resultBlock) resultBlock;

///校验二维码
+(void) storeValidation:(NSString *) qrCodeSelf qrCodeOther:(NSString *) qrCodeOther result:(resultBlock) resultBlock;
///上报校验成功
+(void) storeValidationSuccess:(NSString *) qrCodeSelf qrCodeOther:(NSString *) qrCodeOther result:(resultBlock) resultBlock;
///创建商户
+(void) employeeCreate:(resultBlock) resultBlock;

///首页
+(void) getFirst:(resultBlock) resultBlock;



#pragma mark-新商盟-
///获取烟草组织机构
+ (void) getOrganizeById:(NSString *) ID result:(resultBlock) resultblock;
///新商盟授权
+(void) xsmLoginWithPhone:(NSString *) phone password:(NSString *) password custId:(NSString *)custId orgCode:(NSString *) orgCode result:(resultBlock) resultblock;
+(void) aaxsmLoginWithPhone:(NSDictionary *)params result:(resultBlock) resultblock;
//获取当前订单
+(void) xsmGetCurrentBillsWithCustId:(NSString *) custId result:(resultBlock) resultBlock;
//获取烟品列表
+(void) xsmGetBillsListWithCustId:(NSString *) custId result:(resultBlock) resultBlock;
//收藏
+(void) xsmFavoriteWithCustId:(NSString *) custId result:(resultBlock) resultBlock;
//订单列表
+(void) xsmGetOrder:(resultBlock) resultBlock;
//订单详情
+(void) xsmGetOrderDetailWithOrderNo:(NSString *) orderNo result:(resultBlock) resultBlock;

//查询订单支付结果
+(void) xsmOrderPayResultWithOrderNo:(NSString *) orderNo ref_id:(NSString *) ref_id company_id:(NSString *)cpmpay key:(NSString *)key service_code:(NSString *) service_code version:(NSString *) version result:(resultBlock) resultBlock;
//获取客服限量
+(void) xsmGetLimt:(resultBlock) resultBlock;
//获取商品限量
+(void) xsmGetSingleLimtByCgtCodes:(NSString *) cgtCodes result:(resultBlock) resultBlock;
//获取提交订单的条件判断
+(void) xsmgetOrgarm:(resultBlock) resultblock;
///更新当期订单
+(void) xsmUpdateOrderWithCoNum:(NSString *) coNum details:(NSArray *) details result:(resultBlock) resultBlock;
// 提交新订单
+(void) xsmSubmitOrder:(NSArray *) details result:(resultBlock) resultBlock;

///判断当前用户是否为易付用户
+(void) xsmIsEpay:(NSString *) ref_id key:(NSString *) key service:(NSString *) service_code version:(NSString *) version result:(resultBlock) resultBlock;

//删除订单
+(void) xsmDeleteOrderWithBillsNo:(NSString *) billsNo result:(resultBlock) resultblock;

//判断订单是否可以支付
+(void) xsmAllowForPhoneWithCoNum:(NSString *) coNum ordQtySum:(NSString *) ordQrySum ordAmtSum:(NSString *) ordAmtSum result:(resultBlock) resultblock;


//+(void) xsmPayWIthBillNo:(NSString *) billNo payword:(NSString *) payword result:(resultBlock)resultblock;

///获取订单信息
+(void) xsmPayBillCheckStateWithKey:(NSString *) key from_order_id:(NSString *) fid ref_id:(NSString *) ref_id bill_acct:(NSString *) bill_acct exp_date:(NSString *)exp_date order_type:(NSString *) order_type result:(resultBlock) resultblock;

///订单支付
+ (void) xsmPayBillCheckWithKey:(NSString *) key bill_acct_id:(NSString *) bill_acct_id payword:(NSString *) payword result:(resultBlock) resultblock;



#pragma mark --

+ (void) paymentTransactionWithCategory:(NSString *) category dataJson: (NSString *) dataJson transactionNo: (NSString *)transactionNo sign:(id) sign result: (resultBlock2) resultsBlock;

@end
