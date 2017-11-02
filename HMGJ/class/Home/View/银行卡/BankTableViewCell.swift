//
//  BankTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class BankTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardTypeLabel: UILabel!
    
    @IBOutlet weak var bankCardNoLabel: UILabel!
    
    @IBOutlet weak var widS: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.headerImageView?.layer.masksToBounds = true
        self.headerImageView?.layer.cornerRadius = 30
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 5
        
        
    }
    
    var model:acountcardlistModel? = nil{
        
        didSet{
            
            
            if let aa = model?.bankName{
                self.widS.constant = ToolManger.calculateStringSize(str: aa, maxW: 1000, maxH: 1000, fontSize: 17).width
            }
            
            self.cardNameLabel.text = model?.bankName
            self.cardTypeLabel.text = model?.cardType
            self.bankCardNoLabel.text = model?.bankCardNo
            
            

            
            
            
            
        }
        
    }

    
    
}
