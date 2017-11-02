//
//  aaaViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/18.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

import React

import MBProgressHUD


class aaaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "RN截面"
        self.navigationController?.isNavigationBarHidden = true
        self.RNAction()
        NotificationCenter.default.addObserver(self, selector: #selector(aaaViewController.hidVC(_:)), name: NSNotification.Name.init(rawValue: "Notificatioinhide"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(aaaViewController.comeBack), name: NSNotification.Name.init(rawValue: "K_finishActivity"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(RNManagerVC.backPreviousVC(_:)), name: NSNotification.Name.init(rawValue: "NotificatioinBack"), object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(RNManagerVC.backPreviousVC(_:)), name: NSNotification.Name.init(rawValue: "NotificatioinNext"), object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(aaaViewController.hidVC(_:)), name: NSNotification.Name.init(rawValue: "Notificatioinhide"), object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self);
    }
    
    
    func RNAction(){

        

        
        var localJSPath = Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        let caches = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let jsFile = caches?.appending("/jsFile/main.jsbundle")
        localJSPath = NSURL.init(string: jsFile!)! as URL
       
        let file = caches?.appending("/jsFile/")
        
        
        let params:NSDictionary = ["memberId":"29c00f6dcfe1d729a6c02b16b444ad0b18608009015","file":file!]
        
        let rootView : RCTRootView = RCTRootView(bundleURL: localJSPath! as URL, moduleName: "HelloWorld", initialProperties: params as! [AnyHashable : Any], launchOptions: nil)
        
        rootView.frame = CGRect.init(x: 0, y: 15, width: ScreenW, height: ScreenH)
        self.view.addSubview(rootView)
        
//        let rnViewController = RNManagerViewController.init(backBlock: { (backParams) in
//            print(backParams)
//            
//            if backParams is Dictionary<String, String>  {
//                
//                let dict = backParams as! Dictionary<String, String>
//                
//                print("name")
//                print("url")
//            }
//            
//        }) { (vc, nextParams) in
//            print("vc=%@ \n  params=%@",vc,params)
//        }
        
//        rnViewController.view = rootView
//        
//        rnViewController.title = "JS写的视图"
//        
//        self.navigationController?.pushViewController(rnViewController, animated: true)
    }

    
}

extension aaaViewController {
    
    func hidVC(_ notification:Notification){
        
        DispatchQueue.main.async {
            
            var hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.labelText = "成功"
            //背景渐变效果
            hud.dimBackground = true
            
            //延迟隐藏
            hud.hide(true, afterDelay: 0.8)
//            
//            if (self.hidBlock != nil) {
//                self.hidBlock!(notification.object ?? "");
//            }
            
            
            
            //            if let navigationVC: UINavigationController = self.navigationController, navigationVC.viewControllers.count > 1 {
            //
            //                navigationVC.popViewController(animated: true)
            //            } else {
            //                self.dismiss(animated: true, completion: nil)
            //            }
            
        }
        
    }
    //返回按钮
    func comeBack(){
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
//    func backPreviousVC(_ notification: Notification) {
//        
//        print("current Thread %@",Thread.current)
//        
//        DispatchQueue.main.async {
//            
//            if (self.backBlock != nil) {
//                self.backBlock!(notification.object ?? "");
//            }
//            
//            if let navigationVC: UINavigationController = self.navigationController, navigationVC.viewControllers.count > 1 {
//                
//                navigationVC.popViewController(animated: true)
//            } else {
//                self.dismiss(animated: true, completion: nil)
//            }
//            
//        }
//    }
//    
//    func nextHandle(_ notification: Notification) {
//        print("current Thread %@",Thread.current)
//        
//        DispatchQueue.main.async {
//            if (self.backBlock != nil) {
//                self.backBlock!(notification.object ?? "");
//            }
//        }
//    }
}

