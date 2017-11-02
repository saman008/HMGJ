//
//  MainViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/17.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //addChildVc("RecommendSB", titleStr: "我的店", imageStr: "main_shop", imageSelectStr: "main_shop_select")
        
        addChildVc("HomeSB", titleStr: "红码", imageStr: "main_home", imageSelectStr: "main_home_select")
        addChildVc("ServiceSB", titleStr: "天天活动", imageStr: "newactivity", imageSelectStr: "newactivityselecte")
        addChildVc("MessageSB", titleStr: "消息", imageStr: "newmessage", imageSelectStr: "newmessage_selecte")
        addChildVc("MeSB", titleStr: "我的", imageStr: "newMe", imageSelectStr: "newMeselecte")
        
       // self.selectedIndex = 1
       //self.tabBarController?.childViewControllers[1].tabBarItem.badgeValue = "33"
//        let MSVC = UIStoryboard.init(name: "MessageSB", bundle: nil).instantiateViewController(withIdentifier: "MSVC") as! MessageViewController
//        MSVC.navigationController?.tabBarItem.badgeValue = "123"
//        MSVC.tabBarItem.badgeValue = "3333"
//        MSVC.tabBarController?.tabBarItem.badgeValue = "5555"
    }
    
    
    fileprivate func addChildVc(_ storyName : String,titleStr:String,imageStr:String,imageSelectStr:String) {
        
        // 1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        //childVc.navigationController?.navigationBar.barTintColor = UIColor.red
        //tabBar.tintColor = UIColor.black
        //childVc.view.backgroundColor = UIColor.black
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.white
        //tabBar.tintColor = RColor
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black], for: UIControlState.normal)
       UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.red], for: UIControlState.selected)
        childVc.tabBarItem = UITabBarItem(title: titleStr, image: UIImage.init(named: imageStr), selectedImage: UIImage.init(named: imageSelectStr))
        //        childVc.tabBarItem.image = UIImage.init(named: imageStr)
        //        childVc.tabBarItem.selectedImage = UIImage.init(named: imageSelectStr)
        // 2.将childVc作为子控制器
        addChildViewController(childVc)
    }
}
