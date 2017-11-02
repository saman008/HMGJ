//
//  MeChangePasswordTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/12.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MeChangePasswordTableViewController: TabBaseTableViewController {

    @IBOutlet weak var oldPasswordTextField: UITextField!
    
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var surenewPasswordTextField: UITextField!
    
    let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))

    var random = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "修改登录密码"
        self.rightAction()
    }

    //右上角
    func rightAction(){
        rightBtn.setTitle("完成", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.addTarget(self, action: #selector(rightActi), for: UIControlEvents.touchUpInside)
        
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    func rightActi(){
        
        
        
    }
}

extension MeChangePasswordTableViewController{
    
    

    
    
    
}
