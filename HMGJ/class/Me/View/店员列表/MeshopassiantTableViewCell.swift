//
//  MeshopassiantTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/11.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MeshopassiantTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var certLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var noBtn: UIButton!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var The_activationLabel: UILabel!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        //self.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
        baseView.layer.masksToBounds = true
        baseView.layer.cornerRadius = 5
        
        
    }
    var model:MenewempoyModel? = nil{
        
        didSet{
            self.nameLabel.text = model?.realName
            if let aa = model?.gender{
                if let bb = model?.realName{
                     self.nameLabel.text = bb + "(\(aa))"
                }
                if aa == "男"{
                    self.headerImageView.image = UIImage.init(named: "男")
                }
                if aa == "女"{
                    self.headerImageView.image = UIImage.init(named: "女")
                }
               
            }
            
            self.phoneLabel.text = model?.cellphone
            self.addressLabel.text = model?.shopName
            
            if let bb = model?.status{
                
                if bb == "1"{
                    self.sendBtn.isHidden = true
                    self.The_activationLabel.isHidden = true
                }
                if bb == "0"{
                 
                    self.sendBtn.isHidden = false
                    self.The_activationLabel.isHidden = false
                }
                
            }
            
            
            
        }
        
    }
    
    
}
