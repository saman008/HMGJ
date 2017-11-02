//
//  Bank_cardTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class Bank_cardTableViewController: TabBaseTableViewController {

    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var viewconstentHeght: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "添加银行卡"
        
        viewconstentHeght.constant = self.view.bounds.height - 64
        nextBtn.addTarget(self, action: #selector(nextAction), for: UIControlEvents.touchUpInside)
        
    }
    
    func nextAction(){
        
        let BankDetailVC = UIStoryboard.init(name: "Bank_cardDetailSB", bundle: nil).instantiateViewController(withIdentifier: "BankDetailVC") as! Bank_cardDetailTableViewController
        
        
        self.navigationController?.pushViewController(BankDetailVC, animated: true)
        
        
    }
    
}
