//
//  shop_assistantListTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/23.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class shop_assistantListTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    
    
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var okBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    var model:shop_assistantListModel? = nil{
//        
//        didSet{
//            
//            //if let imgeUrl = mode
//            
//            self.nameLabel.text = model?.realName
//            
//            self.phoneLabel.text = model?.cellphone
//            
//            self.addressLabel.text = model?.address
//            
//            if let aa = model?.status{
//                if aa == "1"{
//                    self.workLabel.text = "已入职"
//                }else if aa == "0"{
//                    self.workLabel.text = "待审核"
//                }
//            }
//            
//            
//            
//            
//            
//            
//        }
//        
//    }


    
    
}
