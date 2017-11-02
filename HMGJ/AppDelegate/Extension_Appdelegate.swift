//
//  aaa.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/2.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

extension AppDelegate{
    
    
    //广告页启动页
    func LeaderStart(){
        if UserDefaults.standard.object(forKey: "isFristOpenApp") == nil{
            
            window?.rootViewController = GuideViewController()
            UserDefaults.standard.set("isFristOpenApp", forKey: "isFristOpenApp")
        }else if "\(UserDefaults.standard.object(forKey: "isFristOpenApp")!)" == "isFristOpenApp"{
            window?.rootViewController = UIStoryboard.init(name: "LoginSB", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! loginTableViewController
            
           // UserDefaults.standard.set("MainOpenApp", forKey: "isFristOpenApp")
        }
        else{
            let logon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main") as! MainViewController
             self.window?.rootViewController = logon
            
        }
    }
    
}
