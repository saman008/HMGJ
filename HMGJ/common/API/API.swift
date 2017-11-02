//
//  API.swift
//  FunLife
//
//  Created by Forever on 2017/6/24.
//  Copyright © 2017年 Forever. All rights reserved.
//

import UIKit

//头文件 注册
//测试环境
//let HOST = "http://125.69.76.146:7081/"

//正式环境

let HOST = "http://test.jike8.com.cn/"


//========登录=========

let loginSTR = "user-auth"

//user-auth/auth/getRandom
///////////////post用户登录///////////////
let LOGINOKSTR = HOST + loginSTR + "/auth/login"

//========注册=========

let RegisteredSTR = "user-manage"


/////////////get//验证注册账户//////////

let registercheckPhoneSTR = HOST + RegisteredSTR + "/register/checkPhone"

let RegisterBodySTR = HOST + RegisteredSTR + "/register/checkAccount"

//////////////////////get 获取随机码/////////////////
let RegisterRandomSTR = HOST + RegisteredSTR + "/register/getChallenge"

///////////////POST验证随机码/////////////////
let SureRandomSTR = HOST + RegisteredSTR + "/register/checkChallenge"

//////////////POST输入密码完成注册//////////
let RegisterOKSTR = HOST + RegisteredSTR + "/register/finish"

//==========忘记密码===================

//获取随机密码get

let usergetRandomSTR = HOST + RegisteredSTR + "/user/getChallenge"

//更换登录账号post

let userresetAccountSTR = HOST + RegisteredSTR + "/user/resetAccount"

////修改密码post
//let userresetPasswordSTR = HOST + RegisteredSTR + "/user/resetPassword"
//
////忘记密码post
//let userforgetPasswordSTR = HOST + RegisteredSTR + "/user/forgetPassword"


//=====================员工信息==========================

let personSTR = "personnel"


//////////////post创建员工/////////
let CreatPersonSTR = HOST + personSTR + "/employee/create"

///////////get获取员工///////////
let ONEPersonSTR = HOST + personSTR + "/employee/one"

//========================商户信息================================

////////////post创建商户/////////////
let merchantcreateSTR = HOST + personSTR + "/merchant/create"

////////////////get获取商户///////////////
let merchantoneSTR = HOST + personSTR + "/merchant/one"

///====================红码支付=====================================
let moneyPaySTR = "pay"
/////////////////post生成预订单接口
let prepaySTR = HOST + moneyPaySTR + "/pay/prepay"

///////////////////post查询支付结果//////////////
let querySTR = HOST + moneyPaySTR + "/pay/query"

//////////////////post支付结果通知////////////////
let resultFromPayCenterSTR = HOST + moneyPaySTR + "/pay/resultFromPayCenter"

//==================个人管理============================

//////////////////////POST更换登录账号///////////////////////
let resetAccountSTR = HOST +  RegisteredSTR + "/manage/resetAccount"

//////////////////////GET获取个人信息/////////////////
let getUserSTR = HOST + RegisteredSTR + "/manage/getUser"

////////////////////////POST更新个人信息//////////////////
let renewalSTR = HOST + RegisteredSTR + "/manage/renewal"

////////////////////POST修改密码///////////////
let resetPasswordSTR = HOST + RegisteredSTR + "/user/resetPassword"

///////////////////////POST忘记密码//////////
let forgetPasswordSTR = HOST + RegisteredSTR + "/user/forgetPassword"

//支付方式
let orderchannelpaywaylistSTR = HOST + "/order-channel/payway/list"


//==========================消息中心=======================

////////消息列表//////
let messageSTR = HOST + "message/messages"

//////////////////消息详情/////////////////////////////////

let searchSourcelSTR = HOST + "message/searchSource"

///////////最外层消息列表删除////////////////////////

let deleteSourceSTR = HOST + "message/deleteSource"

///////////内层消息列表删除///////////////////////

let deleteMessageSTR = HOST + "message/deleteMessage"

//=============上传单个文件==============================
let globalStr = "file-manage"

//注册图片上传
let SingleSTR = HOST + globalStr + "/file/single"
//商品图片上传
let singleWithThumbSTR = HOST + globalStr + "/file/singleWithThumb"

//========================活动商品=============================

//1.1	上传商品信息 post
let activitychannelshopgoodsuploadSTR = HOST + "/activity-channel/shopgoods/upload"

//1.1	获取商品列表get
let activitychannelshopgoodsappListSTR = HOST + "/activity-channel/shopgoods/appList"
//1.1	编辑商品信息post
let activitychannelshopgoodsmodifySTR = HOST + "/activity-channel/shopgoods/modify"
//1.1	商品上架下架删除post
let activitychannelshopgoodsmodifyToSTR = HOST + "/activity-channel/shopgoods/modifyTo"

//====================实名认证=======================================

///////post////更新实名认证
let authrealCertSTR = HOST + loginSTR + "/cert/save"

//////////post/////验证身份
let authcheckCertSTR = HOST + loginSTR + "/cert/checkCert"

///////////get//////cert/ getCert

let certgetCertSTR = HOST + loginSTR + "/cert/getCert"

//====================1	订单查询模块================================
////////////////////post//1.1	员工按时间查询流水////////////////

let employeesearchSTR = HOST + "order-statistics/employee/search"

////////////////post/1.1	订单添加备注//////////////////


let orderremarkSTR = HOST + "/order-statistics/order/remark"

////////////////////post//1.1	员工查询月流水///////////////
let employeemonthDetailSTR = HOST + "order-statistics/employee/monthDetail"

//////////////post////1.1	员工查询交易详情////////////////////////
//http://192.168.3.207:7081/order-statistics/trade/detail
let employeeorderDetailSTR = HOST + "order-statistics/employee/orderDetail"

////////////////post 1.1	店员按时间查询总额统计///////////////////////

let employeesumSTR = HOST + "order-statistics/employee/sum"


////////////////////post//1.1	店长按时间查询流水////////////////

let managersearchSTR = HOST + "order-statistics/manager/search"

////////////////////post//1.1	店长查询月流水///////////////
let managermonthDetailSTR = HOST + "order-statistics/manager/monthDetail"

//////////////post////1.1	店长按时间查询总额////////////////////////

let managerorderDetailSTR = HOST + "order-statistics/manager/sum"

///post1.1=====	=============流水=======================
let merchanthomeSTR = HOST +  "order-statistics/merchant/home"
//刷选
let tradescreeningSTR = HOST +  "order-statistics/condition/screening"
//流水列表
let tradesearchSTR = HOST + "order-statistics/trade/search"
//流水头 统计
let tradedaySTR = HOST + "order-statistics/trade/day"
//流水详情

let tradedetailSTR = HOST + "order-statistics/trade/detail"
///=====================报表===================================

//报表列表
let reportsearchSTR = HOST + "order-statistics/report/search"

//==============店铺================================
///////////////////////////////
let shopCenterSTR = "shop"
///////获取店铺所有员工get

let employeelistSTR = HOST + shopCenterSTR + "/relationship/employee/list"

///创建员工
let employeecreateSTR = HOST + shopCenterSTR + "/relationship/employee/create"

//./////////////////////post解雇店员//////////////

let relationshipfireSTR = HOST + shopCenterSTR + "/relationship/fire"

////////////重新方法短信/////////////////

let employeeresendsmsSTR = HOST + shopCenterSTR + "/relationship/employee/resendsms"

///////////post添加店铺/////////

let storecreateSTR = HOST + shopCenterSTR + "/store/create"

//////////////post更新店铺信息//////////////
let storeupdateSTR = HOST + shopCenterSTR + "/store/update"

////////////////////get获取店铺信息//////////////
let storeoneSTR = HOST + shopCenterSTR + "/store/one"

////////////////////get获取店铺列表///////////////
let storelistSTR = HOST + shopCenterSTR + "/store/list"

///////////////////Post删除店铺////////////
let storedeleteSTR = HOST + shopCenterSTR + "/store/delete"

//////////////get获取行业信息////////////////////////

let storeindustryListSTR = HOST + shopCenterSTR + "/store/industryList"
//================店铺人员关系================================

////////get获取所有店员//////////
let relationshipemployeesSTR = HOST + shopCenterSTR + "/relationship/employees"

///////////////////post申请岗位/////////////////

let relationshipapplySTR = HOST + shopCenterSTR + "/relationship/apply"

///////////////////post审核申请////////////////

let relationshipverifySTR = HOST + shopCenterSTR + "/relationship/verify"


//===========post获取活动列表================================

let activitySTR = "activity-channel"

let activitylistSTR = HOST + activitySTR + "/activity/list"

//=================post获取用户微服务列表=====================================

let appmemberChooseSTR = HOST + "micro/app/memberChoose"

/////////////////post用户未选择服务/////////////////////

let appnoChooseSTR = HOST + "micro/app/noChoose"

//////////////////我的服务添加服务post/////////
let appaddChooseSTR = HOST + "/micro/app/addChoose"

////////////////////////////我的服务删除服务////////////
let appdeleteChooseSTR = HOST + "/micro/app/deleteChoose"

////1.1	App我的服务更新排序/post////////

let appupdateChooseSTR = HOST + "/micro/app/updateChoose"

///////////1.1	App获取用户信息/////////////post
let appuserInfoSTR = HOST + "/micro/app/userInfo"

//////////1.1	服务端存储会员服务信息////////////post
let servicesaveMemberAccountSTR = HOST + "/micro/service/saveMemberAccount"


///////////==============钱包============================

////////////////1.1.1 post//1.1	账户服务/////
let acountapplySTR = HOST + "acount/apply"


/////////1.1	交易服务//////////////////////
let transapplySTR = HOST + "payment/apply"

//////////////查记录///////////////////////
let reportapplySTR = HOST + "report/apply"
//////////////////////获取验证码post
let challengesendSTR = HOST + "message/challenge/send"


//、=============扫一扫(订单order)========================

let orderchannelStr = "order-channel"

//商户扫码收款post
let scancodepayStr = HOST + orderchannelStr + "/scancode/pay"

////查询支付结果post
let payqueryStr = HOST + orderchannelStr + "/pay/query"



//================城市选择器===============================
//////////get///////////////////
let globalSTR = "global"
let getareaSTR = HOST + globalSTR + "/area/getArea"

///////get///////////
let getSubArea = HOST + globalSTR + "/area/getSubArea"

///////////////get获取随机数////////////////
let randgetRandomSTR = HOST + globalSTR + "/rand/getRandom"

//jpush上传key值post
let JPUSHSTR = HOST + "message/terminal/bind"


class API: NSObject {

}
