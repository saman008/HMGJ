//
//  PublicSuccessTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/15.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class PublicSuccessTableViewController: TabBaseTableViewController {

    @IBOutlet weak var rightLabel: UILabel!
    
    
    @IBOutlet weak var okBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "操作结果"
        
        // 返回按钮
        let backButton = UIButton(type: .custom)
        
        // 给按钮设置返回箭头图片
        //backButton.setBackgroundImage(, for: .normal)
        backButton.setBackgroundImage(UIImage.init(named: "返回"), for: UIControlState.normal)
        // 设置frame
        backButton.frame = CGRect(x: 0, y: 13, width: 18, height: 18)
        
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        // 自定义导航栏的UIBarButtonItem类型的按钮
        let backView = UIBarButtonItem(customView: backButton)
        
        // 返回按钮设置成功
        navigationItem.leftBarButtonItem = backView
        
        okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
    }

    func back(){
        
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    
    func okAction(){
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
