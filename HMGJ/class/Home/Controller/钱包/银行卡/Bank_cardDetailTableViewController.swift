//
//  Bank_cardDetailTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class Bank_cardDetailTableViewController: TabBaseTableViewController {

    @IBOutlet weak var viewconstentHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "填写银行卡信息"
        
        self.viewconstentHeight.constant = self.view.bounds.height - 64
        
    }


    
}
