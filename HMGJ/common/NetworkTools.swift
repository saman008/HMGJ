//
//  NetworkTools.swift
//  YCL
//
//  Created by Apple on 2017/4/5.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit
import Alamofire
import KVNProgress


enum MethodType {
    case get
    case post
}
//post是jsoncncoding  get是urlencoding
class NetworkTools {

    class func requestAnyData(type : MethodType, URLString : String, parameters : [String:Any],encoding:String,T:AnyObject,ShowStr:Bool,error:Bool, finishedCallback : @escaping (_ json : AnyObject) -> (),failture:@escaping(_ error:Error) -> ()) {
        
        if ShowStr{
            ToolManger.yanchiShow(T: T, Str: "正在加载")
        }
        var encodingS:ParameterEncoding?
        if encoding == "get"{
            encodingS = URLEncoding.default
        }else if encoding == "post"{
            encodingS = JSONEncoding.default
        }
        
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: encodingS!, headers: ["Content-Type":"application/json;charset=utf-8","Accept":"application/json;charset=utf-8"]).responseJSON { (data) in
            // KVNProgress.dismiss()
            if ShowStr{
                ToolManger.hideShow(T: T)
            }
            print(data)
            if data.result.isSuccess{
                
                if let json = data.result.value as? AnyObject{
                    if let msgStr = json.value(forKey: "msg") as? String{
                        if let codeStr = json.value(forKey: "code") as? String{
                            if codeStr == "0000"{
                                //KVNProgress.showError(withStatus: json.value(forKey: "msg") as! String)
                                // ToolManger.defaultShow(Str: msgStr, T: T)
                                finishedCallback(data.result.value as AnyObject)
                            }else if codeStr == "9999"{
                                
                                
                                //                            DispatchQueue.main.async(execute: {
                                //
                                //                                let logon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "logon")
                                //
                                //
                                //                                T.view!!.window?.rootViewController = logon
                                //
                                //                                T.present(logon, animated: true, completion: nil)
                                //
                                //
                                //                            })
                                let logon = UIStoryboard.init(name: "LoginSB", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! loginTableViewController
                                T.view!.window?.rootViewController = logon
                                
                                T.present(logon, animated: true, completion: nil)
                                
                            }else{
                                if error{
                                    SMProgressHUD.shareInstancetype().showErrorTip(msgStr)
                                }
                                
                            }
                        }
                    }
                }
                
                
            }else{
                print(data.result.error!)
                failture(data.result.error!)
                if error{
                    SMProgressHUD.shareInstancetype().showErrorTip("系统内部错误")
                }
                
            }
        }
    }
    
    
        
    
    class func requestData(type : MethodType, URLString : String, parameters : [String:String],encoding:String,T:AnyObject,ShowStr:Bool, finishedCallback : @escaping (_ json : AnyObject) -> (),failture:@escaping(_ error:Error) -> ()) {

        //KVNProgress.show(withStatus: "正在加载")
        if ShowStr{
            ToolManger.yanchiShow(T: T, Str: "正在加载")
        }
        var encodingS:ParameterEncoding?
        if encoding == "get"{
            encodingS = URLEncoding.default
        }else if encoding == "post"{
            encodingS = JSONEncoding.default
        }
        
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: encodingS!, headers: ["Content-Type":"application/json;charset=utf-8","Accept":"application/json;charset=utf-8"]).responseJSON { (data) in
           // KVNProgress.dismiss()
            if ShowStr{
                ToolManger.hideShow(T: T)
            }
            print(data)
            if data.result.isSuccess{
                
                if let json = data.result.value as? AnyObject{
                    if let msgStr = json.value(forKey: "msg") as? String{
                        if let codeStr = json.value(forKey: "code") as? String{
                            if codeStr == "0000"{
                                //KVNProgress.showError(withStatus: json.value(forKey: "msg") as! String)
                               // ToolManger.defaultShow(Str: msgStr, T: T)
                                finishedCallback(data.result.value as AnyObject)
                            }else if codeStr == "9999"{
                                
                                
                                //                            DispatchQueue.main.async(execute: {
                                //
                                //                                let logon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "logon")
                                //
                                //
                                //                                T.view!!.window?.rootViewController = logon
                                //
                                //                                T.present(logon, animated: true, completion: nil)
                                //
                                //
                                //                            })
                                let logon = UIStoryboard.init(name: "LoginSB", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! loginTableViewController
                                T.view!.window?.rootViewController = logon
                                
                                T.present(logon, animated: true, completion: nil)
                                
                            }else{
                                SMProgressHUD.shareInstancetype().showErrorTip(msgStr)
                            }
                        }
                    }
                }
                
                
            }else{
                print(data.result.error!)
                failture(data.result.error!)
               SMProgressHUD.shareInstancetype().showErrorTip("系统内部错误")
            }
            
            
        }
        
        
        
//        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (data) in
//            if let json = data.result.value{
//                
//                finishedCallback(json as AnyObject)
//            }else{
//                return
//            }
//        }
//
//        Alamofire.request(method, URLString, parameters: parameters, encoding: .URL, headers: nil).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (data) -> Void in
//            
//            if let json = data.result.value{
//                let ecode = json.objectForKey("ecode")?.stringValue
//                if ecode == "0"{
//                    finishedCallback(json: json)
//                }else if ecode == "83"{
//                    KVNProgress.showErrorWithStatus("账号已在其他地方登录，若非本人操作，请尽快修改密码")
//                    
//                    let time:NSTimeInterval = 2.0
//                    
//                    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
//                    dispatch_after(delay, dispatch_get_main_queue(), { () -> Void in
//                        
//                        NSUserDefaults.standardUserDefaults().removeObjectForKey("ticket")
//                        NSUserDefaults.standardUserDefaults().removeObjectForKey("isok")
//                        let logon = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("logon")
//                        
//                        
//                        T.view!!.window?.rootViewController = logon
//                        
//                        T.presentViewController(logon, animated: true, completion: nil)
//                    })
//                
//            }
//            
//        }
    }
}
//
//#define ShowMessage(msg) {\
//    [[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
//        otherButtonTitles: @[] ];\
//}\
//
//#define ShowMessage2(msg,mId,btnTitle1,btnTitle2) {\
//    [[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: mId alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: btnTitle2 \
//        otherButtonTitles: @[btnTitle1]];\
//}\
//
//#define ShowMessage3(alertTitle,msg,mId,btnTitle2,btnTitle1) {\
//    [[SMProgressHUD shareInstancetype]showAlertWithTitle: alertTitle message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: mId alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: btnTitle1 \
//        otherButtonTitles: @[btnTitle2]];\
//}\
