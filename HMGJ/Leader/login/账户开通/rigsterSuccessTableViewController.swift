//
//  rigsterSuccessTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/12.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class rigsterSuccessTableViewController: TabBaseTableViewController {

    
    @IBOutlet weak var backBtn: UIButton!
    
     var The_navigation_barV:The_navigation_barViewView!
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "新商户申请"
        
        backBtn.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //自定义导航栏
        The_navigation_barV = UINib.init(nibName: "The_navigation_barView", bundle: nil).instantiate(withOwner: self, options: nil).first as! The_navigation_barViewView
        The_navigation_barV.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 64)
        UIApplication.shared.keyWindow?.addSubview(The_navigation_barV)
        The_navigation_barV.backBtn.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        The_navigation_barV.titleLabel.text = "新商户申请"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.The_navigation_barV.removeFromSuperview()
        
    }
    //返回按钮
    func backAction(){
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        
    }
    
}
