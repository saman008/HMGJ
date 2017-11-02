
//
//  touchidViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/31.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import LocalAuthentication
import SSZipArchive

class touchidViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "指纹解锁"
        self.view.backgroundColor = UIColor.red
        
        //指纹解锁
        //self.touchID()
        self.dowload()
       
    }
    
    func dowload(){
        // 服务器上zip文件地址
        let url = NSURL(string: "http://file.inlee.com.cn:8011/file/ios_js/js.zip")
        // 发送请求，下载文件
        let task = URLSession.shared.downloadTask(with: url! as URL) { (location, response, error) -> Void in
            // 拿到沙盒caches路径
            let caches = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first

           
            let jsFile = caches?.appending("/jsFile")
           
            
            // 解压缩zip文件
            
            SSZipArchive.unzipFile(atPath: location!.path, toDestination: jsFile!, progressHandler: { (aaa, unz_file_info, number, total) in

                
                
            }) { (path, suceed, error) in
                
                if suceed{
                    
                    OperationQueue.main.addOperation
                        {
                            
                            let touchVC = aaaViewController()
                            
                            
                            self.navigationController?.pushViewController(touchVC, animated: true)
                    }
                    

                }
                
                return
            }
           
        }
        // 开始下载
        task.resume()
        
    }
    
//    func ssD(){
//        
//        let caches = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
//        
//        
//        let file = caches?.appending("/js.zip")
//        
//
//        
//        
//    }
    
    
    
    //http://file.inlee.com.cn:8011/file/ios_js/js.zip
//    NSString *jsFile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"/jsFile"];
//    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"/js.zip"];
//    [SSZipArchive unzipFileAtPath: file toDestination:jsFile progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
//    
//    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
//    QLog(@"解压：%@-%d", path,succeeded );
//    
//    RNVC * vc = [[RNVC alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.viewController.navigationController pushViewController: vc animated: YES];
//    }];
    
    
    
    func touchID(){
        
        let context = LAContext()
        
        var error:NSError?
        
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            // 开始进入识别状态，以闭包形式返回结果。闭包的 success 是布尔值，代表识别成功与否。error 为错误信息。
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请用指纹支付", reply: {success, error in
//                dispatch_async(dispatch_get_main_queue(), { () -> Voidin //放到主线程执行，这里特别重要
//                    if success
//                    {
//                        //调用成功后你想做的事情
//                    }
//                    else
//                    {
//                        // If authentication failed then show a message to the console with a short description.
//                        // In case that the error is a user fallback, then show the password alert view.
//                        
//                    }
//                })
                if success {
                    // 成功之后的逻辑， 通常使用多线程来实现跳转逻辑。////必须回到主线程中 ////
                    OperationQueue.main.addOperation
                        {

                            self.navigationController?.popViewController(animated: true)
                    }
                    return
                }else {
                    if let error = error as NSError? {
                        // 获取错误信息
                        let message = self.errorMessageForLAErrorCode(errorCode: error.code)
                        print(message)
                    }
                }
                
            })
        }

        
        
    }

    //指纹解锁每个情况
    func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        
        if #available(iOS 9.0, *) {
            switch errorCode {
            case LAError.appCancel.rawValue:
                message = "Authentication was cancelled by application"
                
            case LAError.authenticationFailed.rawValue:
                message = "The user failed to provide valid credentials"
                
            case LAError.invalidContext.rawValue:
                message = "The context is invalid"
                
            case LAError.passcodeNotSet.rawValue:
                message = "Passcode is not set on the device"
                
            case LAError.systemCancel.rawValue:
                message = "Authentication was cancelled by the system"
                
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            //不具有指纹的功能的手机
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                //            showPassWordInput()
                
            case LAError.userCancel.rawValue:
                message = "The user did cancel"
                
            //输入密码
            case LAError.userFallback.rawValue:
                message = "The user chose to use the fallback"
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            // Fallback on earlier versions
        }
        return message
    }
    

    

}
