//
//  Macro.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/21.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
//////////////memberId////////是否认证 真是姓名

//员工 ZiLk1ug0tPYu33aN 1是通过0是没有



var memberId = UserDefaults.standard.string(forKey: "memberId")!

var certFlagID = UserDefaults.standard.string(forKey: "certFlag")!
var realNameID = UserDefaults.standard.string(forKey: "realName")!

var shopQRCodeID = UserDefaults.standard.string(forKey: "shopQRCode")!
var shopImgUrlID = UserDefaults.standard.string(forKey: "shopImgUrl")!

var verifyStatusID = UserDefaults.standard.string(forKey: "verifyStatus")!
var shopcityID = UserDefaults.standard.string(forKey: "shopcity")!
var shopLicenseUrlID = UserDefaults.standard.string(forKey: "shopLicenseUrl")

var PhoneNumber = UserDefaults.standard.string(forKey: "PhoneNumb")!
var PasswordStr = UserDefaults.standard.string(forKey: "Password")!

///////////手机号码 登录密码///////////////////////



//极光商户和员工版的区别hmgjsh
var appId = "hmgjsh"

var CATEGORY = ""
let UUID = UIDevice.current.identifierForVendor?.uuidString
let UUSYS = UIDevice.current.systemVersion
let UUNAME = UIDevice.current.systemName

//当前app的版本号
let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
var registrationIDSTR = ""//UserDefaults.standard.string(forKey: "registrationID")
//NSDictionary * dicInfo =[[NSBundle mainBundle] infoDictionary];
//NSString * appNameStr =[dicInfo objectForKey:@"CFBundleName"]; //当前应用名称
//NSString * appVersionStr =[dicInfo objectForKey:@"CFBundleShortVersionString"];//当前应用版本
//NSString * appBuildStr =[dicInfo objectForKey:@"CFBundleVersion"];//当前应用版本号码

//判断iPhone X的宏
//let IS_IPHONE           = (UI_USER_INTERFACE_IDIOM() == .phone)
//let IS_IPHONE_iPX       = (IS_IPHONE && SCREEN_MAX_LENGTH > 736.0)
//let SCREEN_MAX_LENGTH   = max(SCREEN_WIDTH, SCREEN_HEIGHT)

class Macro: NSObject {

    
}
